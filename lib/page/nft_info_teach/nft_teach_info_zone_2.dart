import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:qpp_example/page/nft_info_teach/nft_teach_section.dart';
import 'package:qpp_example/utils/qpp_image.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';

class NFTTeachInfoZone2 extends StatelessWidget {
  final bool isDesktop;

  const NFTTeachInfoZone2({super.key, required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: Text(
            context.tr(QppLocales.nftInfoTeachSubtitle2),
            style: QppTextStyles.web_24pt_title_L_maya_blue_C,
          ),
        ),
        const Info1.desktop(),
        // const Info2.desktop(),
        // const Info3.desktop(),
        // const Info4.desktop(),
      ],
    );
  }
}

class Info1 extends NFTTeachInfoExpand {
  const Info1.desktop({super.key}) : super.desktop();
  const Info1.mobile({super.key}) : super.mobile();

  @override
  Widget get title => const NFTTeachSectionInfoTitle(
        titleKey: QppLocales.nftInfoTeachSubtitle2ContentTeach1,
      );

  @override
  Widget get content => Container(
        margin: const EdgeInsets.only(top: 20),
        child: Builder(builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.tr(
                    QppLocales.nftInfoTeachSubtitle2ContentTeach1ContentStep1),
                style: QppTextStyles.web_16pt_body_platinum_L,
              ),
              const SizedBox(
                height: 28,
              ),
              // Wrap 流式佈局 https://blog.csdn.net/yuzhiqiang_1993/article/details/88378021
              Wrap(
                runSpacing: 16,
                spacing: 16,
                children: [
                  Image.asset(QPPImages.desktop_pic_nft_instruction_02),
                  Image.asset(QPPImages.desktop_pic_nft_instruction_03),
                ],
              ),
              const SizedBox(
                height: 64,
              ),
              Text(
                context.tr(
                    QppLocales.nftInfoTeachSubtitle2ContentTeach1ContentStep2),
                style: QppTextStyles.web_16pt_body_platinum_L,
              ),
              const SizedBox(
                height: 24,
              ),
              Wrap(
                runSpacing: 16,
                spacing: 16,
                children: [
                  Image.asset(QPPImages.desktop_pic_nft_instruction_04),
                  Image.asset(QPPImages.desktop_pic_nft_instruction_05),
                ],
              ),
              const SizedBox(
                height: 64,
              ),
              Text(
                context.tr(
                    QppLocales.nftInfoTeachSubtitle2ContentTeach1ContentStep3),
                style: QppTextStyles.web_16pt_body_platinum_L,
              ),
              const SizedBox(
                height: 24,
              ),
              Image.asset(QPPImages.desktop_pic_nft_instruction_06),
              const SizedBox(
                height: 64,
              ),
              Text(
                context.tr(
                    QppLocales.nftInfoTeachSubtitle2ContentTeach1ContentStep4),
                style: QppTextStyles.web_16pt_body_platinum_L,
              ),
              const SizedBox(
                height: 24,
              ),
              Image.asset(QPPImages.desktop_pic_nft_instruction_07),
              const SizedBox(
                height: 64,
              ),
              Text(
                context.tr(
                    QppLocales.nftInfoTeachSubtitle2ContentTeach1ContentStep5),
                style: QppTextStyles.web_16pt_body_platinum_L,
              ),
              const SizedBox(
                height: 24,
              ),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  Image.asset(QPPImages.desktop_pic_nft_instruction_08),
                  Image.asset(QPPImages.desktop_pic_nft_instruction_09),
                  Image.asset(QPPImages.desktop_pic_nft_instruction_10),
                ],
              ),
            ],
          );
        }),
      );
}
