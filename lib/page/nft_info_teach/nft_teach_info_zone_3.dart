import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:qpp_example/page/nft_info_teach/nft_teach_section.dart';
import 'package:qpp_example/utils/qpp_image.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';

class NFTTeachInfoZone3 extends StatelessWidget {
  final bool isDesktop;

  const NFTTeachInfoZone3({super.key, required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 3,
        shrinkWrap: true,
        // 禁止 list 內容 滾動
        primary: false,
        itemBuilder: (context, index) {
          return switch (index) {
            0 => Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: Text(
                  context.tr(QppLocales.nftInfoTeachSubtitle3),
                  style: isDesktop
                      ? QppTextStyles.web_24pt_title_L_maya_blue_C
                      : QppTextStyles.mobile_20pt_title_L_maya_blue_L,
                ),
              ),
            1 => isDesktop ? const Info1.desktop() : const Info1.mobile(),
            2 => isDesktop ? const Info2.desktop() : const Info2.mobile(),
            _ => const SizedBox.shrink(),
          };
        });
  }
}

class Info1 extends NFTTeachInfoExpand {
  const Info1.desktop({super.key}) : super.desktop();
  const Info1.mobile({super.key}) : super.mobile();

  @override
  Widget get title => NFTTeachSectionInfoTitle(
        titleKey: QppLocales.nftInfoTeachSubtitle3ContentQ1,
        isDesktop: isDesktop,
      );

  @override
  Widget get content => ItemTeachInfo(
        margin: const EdgeInsets.only(top: 20),
        contentKey: QppLocales.nftInfoTeachSubtitle3ContentA1,
        isDesktop: isDesktop,
      );
}

class Info2 extends NFTTeachInfoExpand {
  const Info2.desktop({super.key}) : super.desktop();
  const Info2.mobile({super.key}) : super.mobile();

  @override
  Widget get title => NFTTeachSectionInfoTitle(
        titleKey: QppLocales.nftInfoTeachSubtitle3ContentTeach2,
        isDesktop: isDesktop,
      );

  @override
  Widget get content => Container(
        margin: const EdgeInsets.only(top: 20),
        child: ListView.builder(
          itemCount: 3,
          shrinkWrap: true,
          // 禁止 list 內容 滾動
          primary: false,
          itemBuilder: (context, index) {
            return switch (index) {
              0 => ItemTeachInfo(
                  contentKey:
                      QppLocales.nftInfoTeachSubtitle3ContentTeach2ContentStep1,
                  displayImg: [
                    Image.asset(QPPImages.desktop_pic_nft_instruction_22),
                  ],
                  isDesktop: isDesktop,
                ),
              1 => ItemTeachInfo(
                  margin: const EdgeInsets.only(top: 64),
                  contentKey:
                      QppLocales.nftInfoTeachSubtitle3ContentTeach2ContentStep2,
                  displayImg: [
                    Image.asset(QPPImages.desktop_pic_nft_instruction_23),
                  ],
                  isDesktop: isDesktop,
                ),
              2 => ItemTeachInfo(
                  margin: const EdgeInsets.only(top: 64),
                  contentKey:
                      QppLocales.nftInfoTeachSubtitle3ContentTeach2ContentStep3,
                  tipKey: QppLocales
                      .nftInfoTeachSubtitle3ContentTeach2ContentStep3Tip,
                  displayImg: [
                    Image.asset(QPPImages.desktop_pic_nft_instruction_24),
                  ],
                  isDesktop: isDesktop,
                ),
              _ => const SizedBox.shrink()
            };
          },
        ),
      );
}
