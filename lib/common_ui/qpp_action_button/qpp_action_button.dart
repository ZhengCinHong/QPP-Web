import 'package:flutter/material.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';

/// 動作按鈕
class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    this.spacing = 5,
    this.iconSize = 24,
    required this.icon,
    required this.content,
  });

  /// 間距
  final double spacing;
  final double iconSize;

  final String icon;
  final String content;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print(123),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            icon,
            width: iconSize,
          ),
          SizedBox(width: spacing),
          Text(
            content,
            style: QppTextStyles.web_16pt_body_category_text_L,
          )
        ],
      ),
    );
  }
}
