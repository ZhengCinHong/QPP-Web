import 'package:json_annotation/json_annotation.dart';

part 'login_info.g.dart';

/// 登入資訊
@JsonSerializable()
class LoginInfo {
  const LoginInfo({
    required this.expiredTimestamp,
    required this.refreshTimestamp,
    required this.voteToken,
    required this.uid,
    required this.uidImage,
  });

  /// 到期時戳
  final String? expiredTimestamp;

  /// 是否登入
  bool get isLogin => voteToken.isNotEmpty;

  /// 刷新Token日期
  final int refreshTimestamp;

  /// 投票token
  final String voteToken;

  /// 用戶id
  final String uid;

  /// 用戶圖片
  final String uidImage;

  /// 隱藏的uid
  String get hiddenUID {
    final int start = (uid.length ~/ 2) - 1 - 1; // -1: 從0開始算, -1: 有三個*，往前一位

    print(uid.length);

    return uid.replaceRange(start, start + 3, '*' * 3);
  }

  factory LoginInfo.fromJson(Map<String, dynamic> json) =>
      _$LoginInfoFromJson(json);

  Map<String, dynamic> get toMap => _$LoginInfoToJson(this);
}
