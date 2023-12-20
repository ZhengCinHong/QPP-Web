import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qpp_example/common_ui/qpp_button/open_qpp_button.dart';
import 'package:qpp_example/common_ui/qpp_universal_link/universal_link_qrcode.dart';
import 'package:qpp_example/extension/build_context.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';

/// UniversalLinkWidget(參考: 物品資訊頁、個人資訊頁...等)
/// - Note:
///   手機平台顯示開啟QPP按鈕
///   其他平台顯示QRCode
class UniversalLinkWidget extends StatelessWidget {
  final String url;

  /// 手機平台字串
  final String mobileText;

  const UniversalLinkWidget({
    super.key,
    required this.url,
    required this.mobileText,
  });

  @override
  Widget build(BuildContext context) {
    return context.isDesktopPlatform
        ? UniversalLinkQRCode(url: url)
        : Column(
            children: [
              Text(
                context.tr(mobileText),
                style: QppTextStyles.web_16pt_body_platinum_L,
              ),
              const SizedBox(height: 24),
              const OpenQppButton(),
            ],
          );
  }
}
