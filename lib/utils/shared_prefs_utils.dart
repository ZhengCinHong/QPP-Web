import 'dart:convert';
import 'package:qpp_example/common_view_model/auth_service/model/login_info.dart';
import 'package:qpp_example/extension/string/text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late final SharedPreferences _instance;

  static Future<SharedPreferences> init() async =>
      _instance = await SharedPreferences.getInstance();

  // More abstraction
  static const _loginInfo = 'loginInfo';

  static Future<bool> setLoginInfo(String value) =>
      _instance.setString(_loginInfo, value);

  static LoginInfo? getLoginInfo() {
    try {
      if (_instance.getString(_loginInfo).isNullOrEmpty) {
        return null;
      } else {
        print({json.decode(_instance.getString(_loginInfo) ?? ""), 12313213});
        return LoginInfo.fromJson(
            json.decode(_instance.getString(_loginInfo) ?? ""));
      }
    } catch (error) {
      print('getLoginInfo() error: $error');
      return null;
    }
  }

  static removeLoginInfo() => _instance.remove(_loginInfo);
}
