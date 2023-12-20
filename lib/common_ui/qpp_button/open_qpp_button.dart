import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qpp_example/constants/server_const.dart';
import 'package:qpp_example/extension/string/text.dart';
import 'package:qpp_example/extension/string/url.dart';
import 'package:qpp_example/extension/throttle_debounce.dart';
import 'package:qpp_example/extension/widget/disable_selection_container.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:qpp_example/utils/qpp_color.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';

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

/// 開啟QPP數位背包按鈕, 若無帶入 url 直接開啟 app
class OpenQppButton extends StatelessWidget {
  final String? url;
  const OpenQppButton({super.key, this.url});

  @override
  Widget build(BuildContext context) {
    return CButton.rectangle(
      height: 48,
      width: 154,
      color: QppColors.mayaBlue,
      text: context.tr(QppLocales.errorPageOpenQpp),
      textStyle: QppTextStyles.mobile_16pt_title_m_bold_oxford_blue_C,
      onTap: () {
        if (url.isNullOrEmpty) {
          ServerConst.appStoreUrl.launchURL();
        } else {
          // TODO: url check
          // 檢查 帶入 &action=download 
          url!.launchURL(isNewTab: false);
        }
      }.throttle(),
    );
  }
}
