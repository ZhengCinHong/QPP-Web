import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qpp_example/go_router/router.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:qpp_example/utils/qpp_image.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';
import 'package:qpp_example/utils/url_generator.dart';
import 'package:qr_flutter/qr_flutter.dart';

/// UniversalLink QRCode(物品資訊頁、個人資訊頁...等)
class UniversalLinkQRCode extends StatelessWidget {
  const UniversalLinkQRCode({super.key, required this.url, this.size = 144});

  final String url;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      primary: false,
      children: [
        Center(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
            child: QPPQRCode(data: UrlGenerator.getQRCodeUrl(url), size: size),
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: Column(children: [
            Text(
              context.tr(QppLocales.commodityInfoScanViaQPP),
              style: QppTextStyles.web_16pt_body_canary_yellow_C,
            ),
            // 路由為 membershipFetch, 顯示領取字樣
            url.contains(QppGoRouter.membershipFetch)
                ? Text(
                    context.tr(QppLocales.errorPageClaim),
                    style: QppTextStyles.web_16pt_body_canary_yellow_C,
                  )
                : const SizedBox.shrink(),
          ]),
        ),
      ],
    );
  }
}

/// 中間有QPP Icon的QRCode
class QPPQRCode extends StatelessWidget {
  const QPPQRCode({super.key, required this.data, required this.size});

  final String data;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(11),
      child: QrImageView(
        version: QrVersions.auto,
        errorCorrectionLevel: QrErrorCorrectLevel.Q,
        data: data,
        embeddedImage: const AssetImage(QPPImages.pic_qrcode),
        embeddedImageStyle: const QrEmbeddedImageStyle(size: Size(30, 30)),
        size: size,
        padding: const EdgeInsets.all(0),
      ),
    );
  }
}
