
/// 投票顯示類型
enum VoteShowType {
  none(0),
  /// 不顯示
  noShow(1),
  /// 顯示
  show(2),
  /// 問號
  questionMark(3);

  final int value;

  const VoteShowType(this.value);

  static VoteShowType findTypeByValue(int value) {
    return switch (value) {
      1 => VoteShowType.noShow,
      2 => VoteShowType.show,
      3 => VoteShowType.questionMark,
      _ => VoteShowType.none,
    };
  }
}
