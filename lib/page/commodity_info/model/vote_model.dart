import 'package:qpp_example/localization/qpp_locales.dart';

/// 投票狀態類型
enum VoteItemStateType {
  /// 狀態
  state,

  /// 投票人數
  voteCount;

  String get title => switch (this) {
        VoteItemStateType.state => QppLocales.commodityInfoStatus,
        VoteItemStateType.voteCount => QppLocales.commodityInfoVoteNumber
      };
}
