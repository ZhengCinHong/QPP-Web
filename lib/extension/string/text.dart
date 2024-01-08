import 'package:flutter/material.dart';

// MARK: - 字串擴充
extension TextExtension on String {
  /// 計算文字Size(\n不會計算)
  Size size(TextStyle style, {double maxWidth = double.infinity}) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: this, style: style),
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: maxWidth);
    return textPainter.size;
  }

  /// 是否為 NFT 物品 ID
  bool get isNFTId {
    return (contains('UC:101:'));
  }
}

extension StringExtension on String? {
  bool get isNullOrEmpty {
    if (this != null) {
      return this!.isEmpty;
    }
    return true;
  }
}
