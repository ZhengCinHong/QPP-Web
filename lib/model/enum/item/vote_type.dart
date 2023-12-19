import 'package:qpp_example/localization/qpp_locales.dart';

enum VoteType {
  none(0),
  // 進行中
  inProgress(1),
  // 已結束
  ended(2),
  // 已過期
  expired(3);

  final int value;
  const VoteType(this.value);

  static VoteType findTypeByValue(int value) {
    return switch (value) {
      1 => VoteType.inProgress,
      2 => VoteType.ended,
      3 => VoteType.expired,
      _ => VoteType.none,
    };
  }

  String get text => switch (this) {
        VoteType.inProgress => QppLocales.commodityInfoVoteNow,
        VoteType.ended => QppLocales.commodityInfoVoteFinished,
        VoteType.expired => QppLocales.commodityInfoVoteExpired,
        _ => '',
      };
}
