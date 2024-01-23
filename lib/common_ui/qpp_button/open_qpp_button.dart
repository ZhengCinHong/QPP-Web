import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qpp_example/common_ui/qpp_button/c_button.dart';
import 'package:qpp_example/constants/server_const.dart';
import 'package:qpp_example/extension/string/text.dart';
import 'package:qpp_example/extension/string/url.dart';
import 'package:qpp_example/extension/throttle_debounce.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:qpp_example/utils/qpp_color.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';
import 'package:qpp_example/utils/url_generator.dart';

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
          // 檢查 帶入 &action=download
          UrlGenerator.getQRCodeUrl(url ?? '').launchURL(isNewTab: false);
        }
      }.throttle(),
    );
  }
}
