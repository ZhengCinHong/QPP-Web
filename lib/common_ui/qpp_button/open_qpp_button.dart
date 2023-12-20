import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qpp_example/common_ui/qpp_button/c_button.dart';
import 'package:qpp_example/constants/server_const.dart';
import 'package:qpp_example/extension/string/url.dart';
import 'package:qpp_example/extension/throttle_debounce.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:qpp_example/utils/qpp_color.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';

/// 開啟QPP數位背包按鈕
class OpenQppButton extends StatelessWidget {
  const OpenQppButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CButton.rectangle(
      height: 48,
      width: 154,
      color: QppColors.mayaBlue,
      text: context.tr(QppLocales.errorPageOpenQpp),
      textStyle: QppTextStyles.mobile_16pt_title_m_bold_oxford_blue_C,
      onTap: () {
        ServerConst.appStoreUrl.launchURL();
      }.throttle(),
    );
  }
}
