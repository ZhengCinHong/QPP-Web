/// NFT 教學頁錨點
enum NFTInfoTeachAnchor {
  none(''),
  crossBorder('cross-border'),
  importFee('import-fee'),
  entry('entry');

  final String value;

  const NFTInfoTeachAnchor(this.value);

  factory NFTInfoTeachAnchor.findTypeByValue(String value) {
    for (var anchor in NFTInfoTeachAnchor.values) {
      if (anchor.value == value) {
        return anchor;
      }
    }
    return NFTInfoTeachAnchor.none;
  }

  /// 取得滾動時長
  int get scrollDuration {
    return switch (this) {
      crossBorder => 500,
      importFee => 1000,
      entry => 1800,
      _ => 0,
    };
  }
}
