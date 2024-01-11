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
  /// 判斷是否為空字串或 null
  bool get isNullOrEmpty {
    if (this != null) {
      return this!.isEmpty;
    }
    return true;
  }

  /// 是否為 Url
  bool get isUrl {
    var urlExp = RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.&]+');
    return urlExp.hasMatch(this!);
  }

  /// 是否為 Mail
  bool get isMail {
    var mailExp = RegExp(r'[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}');
    return mailExp.hasMatch(this!);
  }
}
