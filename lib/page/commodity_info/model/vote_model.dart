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

/// 已投票狀態
enum VotedState {
  /// 成功
  success,

  /// 為創建者
  failure_72,

  /// 投票時間已截止
  failure_73,

  /// 已投過票
  failure_74,

  // 未知錯誤
  unkown,

  /// 無
  none;

  static VotedState findTypeByCode(String code) {
    print({code, 123131231});
    return switch (code) {
      '1' => VotedState.success,
      '72' => VotedState.failure_72,
      '73' => VotedState.failure_73,
      '74' => VotedState.failure_74,
      '' => VotedState.none,
      _ => VotedState.unkown,
    };
  }

  /// 顯示對話框
  bool get displayDialog => switch (this) {
        VotedState.none || VotedState.unkown => false,
        _ => true,
      };

  /// 訊息
  String get message => switch (this) {
        VotedState.success => QppLocales.commodityInfoVoteSuccessP,
        VotedState.failure_72 => QppLocales.commodityInfoVoteError72,
        VotedState.failure_73 => QppLocales.commodityInfoVoteError73,
        VotedState.failure_74 => QppLocales.commodityInfoVoteError74,
        _ => '',
      };
}
