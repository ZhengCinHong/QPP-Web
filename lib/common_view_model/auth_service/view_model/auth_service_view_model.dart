import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qpp_example/api/core/api_response.dart';
import 'package:qpp_example/api/local/api/local_api.dart';
import 'package:qpp_example/api/local/response/check_login_token.dart';
import 'package:qpp_example/api/local/response/get_login_token.dart';
import 'package:qpp_example/common_view_model/auth_service/model/login_info.dart';
import 'package:qpp_example/utils/shared_prefs_utils.dart';

/// 驗證服務(登入/登出)Provider
final ChangeNotifierProvider<AuthServiceStateNotifier> authServiceProvider =
    ChangeNotifierProvider<AuthServiceStateNotifier>((ref) {
  return AuthServiceStateNotifier();
});

/// 驗證服務(登入/登出)Notifier
class AuthServiceStateNotifier extends ChangeNotifier {
  /// 取得登入token狀態
  ApiResponse<GetLoginTokenResponse> getLoginTokenState = ApiResponse.initial();

  /// 驗證登入token狀態
  ApiResponse<CheckLoginTokenResponse> checkLoginTokenState =
      ApiResponse.initial();

  /// 登出狀態
  ApiResponse<()> logoutState = ApiResponse.initial();

  /// 投票token
  String? voteToken;

  /// 計時器
  Timer? timer;

  /// 取得登入token
  void getLoginToken(String lang) {
    getLoginTokenState = ApiResponse.loading();
    notifyListeners();

    if (!(SharedPrefs.getLoginInfo()?.isLogin ?? false)) {
      final request = GetLoginTokenRequest().createBody(lang);

      LocalApiClient.client
          .postGetLoginToken(request)
          .then((getLoginTokenResponse) {
        if (getLoginTokenResponse.isSuccess) {
          checkLoginToken(getLoginTokenResponse.data.vendorToken ?? "");
          getLoginTokenState = ApiResponse.completed(getLoginTokenResponse);
        } else {
          getLoginTokenState = ApiResponse.error(
              getLoginTokenResponse.qppReturnError?.errorMessage);
        }
        notifyListeners();
      }).catchError((error) {
        getLoginTokenState = ApiResponse.error(error);
        notifyListeners();
      });
    }
  }

  /// 驗證登入token
  void checkLoginToken(String vendorToken) {
    checkLoginTokenState = ApiResponse.loading();
    notifyListeners();

    timer?.cancel();

    timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      final request = CheckLoginTokenRequest().createBody(vendorToken);

      LocalApiClient.client
          .postCheckLoginToken(request)
          .then((checkLoginTokenResponse) {
        getLoginTokenState = ApiResponse.initial();
        if (checkLoginTokenResponse.isSuccess) {
          timer.cancel();
          checkLoginTokenState = ApiResponse.completed(checkLoginTokenResponse);

          voteToken = checkLoginTokenResponse.voteToken;

          final loginInfoMap = LoginInfo(
                  expiredTimestamp: null,
                  refreshTimestamp: DateTime.timestamp().millisecondsSinceEpoch,
                  voteToken: voteToken ?? '',
                  uid: checkLoginTokenResponse.uid,
                  uidImage: checkLoginTokenResponse.uidImage)
              .toMap;

          final loginInfoJson = json.encode(loginInfoMap);

          SharedPrefs.setLoginInfo(loginInfoJson);
        } else {
          checkLoginTokenState = ApiResponse.error(
              checkLoginTokenResponse.qppReturnError?.errorMessage ?? '');
        }
        notifyListeners();
      }).catchError((error) {
        print({'checkLoginToken error: $error'});
        checkLoginTokenState = ApiResponse.error(error);
        notifyListeners();
      });
    });
  }

  /// 取消Timer
  void cancelTimer() {
    timer?.cancel();
  }

  /// 登出
  void logout(String vendorToken) {
    logoutState = ApiResponse.loading();
    notifyListeners();

    LocalApiClient.client.getLogout(vendorToken).then((_) {
      getLoginTokenState = ApiResponse.initial();
      checkLoginTokenState = ApiResponse.initial();
      SharedPrefs.removeLoginInfo();
      logoutState = ApiResponse.completed(());
      voteToken = null;

      notifyListeners();
    }).catchError((error) {
      logoutState = ApiResponse.error(error);
      notifyListeners();
    });
  }
}
