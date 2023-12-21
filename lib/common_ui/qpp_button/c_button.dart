import 'package:flutter/material.dart';
import 'package:qpp_example/extension/widget/disable_selection_container.dart';

/// 客製化按鈕樣式
enum CButtonStyle {
  /// 長方形無邊線(Radius: 4)
  rectangle;

  double get radius => switch (this) { CButtonStyle.rectangle => 4 };
}

/// 客製化按鈕公版
class CButton extends StatelessWidget {
  /// 長方形(Radius: 4)
  const CButton.rectangle({
    super.key,
    required this.width,
    required this.height,
    this.color,
    this.border,
    required this.text,
    required this.textStyle,
    required this.onTap,
  }) : style = CButtonStyle.rectangle;

  final double width;
  final double height;
  final CButtonStyle style;
  final Color? color;
  final BoxBorder? border;
  final String text;
  final TextStyle textStyle;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(style.radius),
            border: border,
          ),
          child: Center(
            child: Text(
              text,
              style: textStyle,
            ).disabledSelectionContainer,
          ),
        ),
      ),
    );
  }
}
