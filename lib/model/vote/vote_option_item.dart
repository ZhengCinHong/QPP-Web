/// 問券選項 item
class VoteOptionItem {
  /// 選項
  final String option;

  /// 投票人數
  final int voteCount;

  const VoteOptionItem({required this.option, required this.voteCount});

  /// 百分比
  double percent(int totalCount) =>
      (voteCount.toDouble() / totalCount.toDouble()).isNaN
          ? 0
          : (voteCount.toDouble() / totalCount.toDouble());
}
