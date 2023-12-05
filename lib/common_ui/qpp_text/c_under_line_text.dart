import 'package:flutter/material.dart';
import 'package:qpp_example/extension/string/url.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';

/// 客製化底線Text
///
///  Note:
/// - 鼠標移過去會顯示底線
/// - 若需使用連結初始化請用CUnderlineText.link
class CUnderlineText extends StatefulWidget {
  const CUnderlineText({
    super.key,
    required this.text,
    this.style = QppTextStyles.web_14pt_body_s_white_L,
    required this.onTap,
    this.maxLines,
  })  : link = '',
        isNewTab = false;

  const CUnderlineText.link({
    super.key,
    required this.text,
    this.style = QppTextStyles.web_14pt_body_s_white_L,
    required this.link,
    this.isNewTab = false,
    this.maxLines,
  }) : onTap = null;

  final String text;
  final TextStyle style;
  final String link;
  final bool isNewTab; // 是否打開新頁面
  final Function? onTap;
  final int? maxLines;

  @override
  State<CUnderlineText> createState() => _CUnderlineText();
}

class _CUnderlineText extends State<CUnderlineText> {
  var isHovered = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onTap != null
          ? widget.onTap!()
          : widget.link.launchURL(isNewTab: widget.isNewTab),
      onHover: (value) => setState(() {
        isHovered = value;
      }),
      child: _UnderlineText(
        text: widget.text,
        style: widget.style,
        isShowUnderline: isHovered,
        maxLines: widget.maxLines,
      ),
    );
  }
}

/// 底線Text
class _UnderlineText extends StatelessWidget {
  const _UnderlineText({
    required this.text,
    required this.style,
    required this.isShowUnderline,
    required this.maxLines,
  });

  final String text;
  final TextStyle style;
  final bool isShowUnderline;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: style.color,
        fontSize: style.fontSize,
        decoration: TextDecoration.underline,
        decorationThickness: 2,
        decorationColor: style.color?.withOpacity(isShowUnderline ? 1 : 0),
      ),
      maxLines: maxLines,
    );
  }
}
