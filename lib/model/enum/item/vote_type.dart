import 'package:qpp_example/localization/qpp_locales.dart';

enum VoteType {
  // 錯誤 (server 沒有這個值, 自己加的)
  error(-1),
  // 進行中
  inProgress(1),
  // 已結束
  end(2),
  // 已過期
  expired(3);

  final int value;
  const VoteType(this.value);

  static VoteType findTypeByValue(int value) {
    return switch (value) {
      1 => VoteType.inProgress,
      2 => VoteType.end,
      3 => VoteType.expired,
      _ => VoteType.error,
    };
  }

  String get text => switch (this) {
        VoteType.inProgress => QppLocales.commodityInfoVoteNow,
        VoteType.end => QppLocales.commodityInfoVoteFinished,
        VoteType.expired => QppLocales.commodityInfoVoteExpired,
        _ => '',
      };
}
