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
    return ListView.builder(
        itemCount: 4,
        shrinkWrap: true,
        // 禁止 list 內容 滾動
        primary: false,
        itemBuilder: (context, index) {
          return switch (index) {
            0 => Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: Text(
                  context.tr(QppLocales.nftInfoTeachSubtitle2),
                  style: isDesktop
                      ? QppTextStyles.web_24pt_title_L_maya_blue_C
                      : QppTextStyles.mobile_20pt_title_L_maya_blue_L,
                ),
              ),
            1 => isDesktop ? const Info1.desktop() : const Info1.mobile(),
            2 => isDesktop ? const Info2.desktop() : const Info2.mobile(),
            3 => isDesktop ? const Info3.desktop() : const Info3.mobile(),
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
        titleKey: QppLocales.nftInfoTeachSubtitle2ContentTeach1,
        isDesktop: isDesktop,
      );

  @override
  Widget get content => Container(
        margin: const EdgeInsets.only(top: 20),
        child: ListView.builder(
          itemCount: 5,
          shrinkWrap: true,
          // 禁止 list 內容 滾動
          primary: false,
          itemBuilder: (context, index) {
            return switch (index) {
              0 => ItemTeachInfo(
                  contentKey:
                      QppLocales.nftInfoTeachSubtitle2ContentTeach1ContentStep1,
                  displayImg: [
                    Image.asset(QPPImages.desktop_pic_nft_instruction_02),
                    Image.asset(QPPImages.desktop_pic_nft_instruction_03),
                  ],
                  isDesktop: isDesktop,
                ),
              1 => ItemTeachInfo(
                  margin: const EdgeInsets.only(top: 64),
                  contentKey:
                      QppLocales.nftInfoTeachSubtitle2ContentTeach1ContentStep2,
                  displayImg: [
                    Image.asset(QPPImages.desktop_pic_nft_instruction_04),
                    Image.asset(QPPImages.desktop_pic_nft_instruction_05),
                  ],
                  isDesktop: isDesktop,
                ),
              2 => ItemTeachInfo(
                  margin: const EdgeInsets.only(top: 64),
                  contentKey:
                      QppLocales.nftInfoTeachSubtitle2ContentTeach1ContentStep3,
                  displayImg: [
                    Image.asset(QPPImages.desktop_pic_nft_instruction_06),
                  ],
                  isDesktop: isDesktop,
                ),
              3 => ItemTeachInfo(
                  margin: const EdgeInsets.only(top: 64),
                  contentKey:
                      QppLocales.nftInfoTeachSubtitle2ContentTeach1ContentStep4,
                  displayImg: [
                    Image.asset(QPPImages.desktop_pic_nft_instruction_07),
                  ],
                  isDesktop: isDesktop,
                ),
              4 => ItemTeachInfo(
                  margin: const EdgeInsets.only(top: 64),
                  contentKey:
                      QppLocales.nftInfoTeachSubtitle2ContentTeach1ContentStep5,
                  displayImg: [
                    Image.asset(QPPImages.desktop_pic_nft_instruction_08),
                    Image.asset(QPPImages.desktop_pic_nft_instruction_09),
                    Image.asset(QPPImages.desktop_pic_nft_instruction_10),
                  ],
                  isDesktop: isDesktop,
                ),
              _ => const SizedBox.shrink()
            };
          },
        ),
      );
}

class Info2 extends NFTTeachInfoExpand {
  const Info2.desktop({super.key}) : super.desktop();
  const Info2.mobile({super.key}) : super.mobile();

  @override
  Widget get title => NFTTeachSectionInfoTitle(
        titleKey: QppLocales.nftInfoTeachSubtitle2ContentTeach2,
        isDesktop: isDesktop,
      );

  @override
  Widget get content => Container(
        margin: const EdgeInsets.only(top: 20),
        child: ListView.builder(
          shrinkWrap: true,
          // 禁止 list 內容 滾動
          primary: false,
          itemCount: 5,
          itemBuilder: ((context, index) {
            return switch (index) {
              0 => ItemTeachInfo(
                  contentKey:
                      QppLocales.nftInfoTeachSubtitle2ContentTeach2ContentStep1,
                  displayImg: [
                    Image.asset(QPPImages.desktop_pic_nft_instruction_11),
                  ],
                  isDesktop: isDesktop,
                ),
              1 => ItemTeachInfo(
                  margin: const EdgeInsets.only(top: 64),
                  contentKey:
                      QppLocales.nftInfoTeachSubtitle2ContentTeach2ContentStep2,
                  displayImg: [
                    Image.asset(
                      QPPImages.desktop_pic_nft_instruction_12,
                    ),
                    Image.asset(QPPImages.desktop_pic_nft_instruction_13),
                  ],
                  isDesktop: isDesktop,
                ),
              2 => ItemTeachInfo(
                  margin: const EdgeInsets.only(top: 64),
                  contentKey:
                      QppLocales.nftInfoTeachSubtitle2ContentTeach2ContentStep3,
                  displayImg: [
                    Image.asset(
                      QPPImages.desktop_pic_nft_instruction_14,
                    ),
                  ],
                  isDesktop: isDesktop,
                ),
              3 => ItemTeachInfo(
                  margin: const EdgeInsets.only(top: 64),
                  contentKey:
                      QppLocales.nftInfoTeachSubtitle2ContentTeach2ContentStep4,
                  displayImg: [
                    Image.asset(
                      QPPImages.desktop_pic_nft_instruction_15,
                    ),
                  ],
                  isDesktop: isDesktop,
                ),
              4 => ItemTeachInfo(
                  margin: const EdgeInsets.only(top: 64),
                  contentKey:
                      QppLocales.nftInfoTeachSubtitle2ContentTeach2ContentStep5,
                  displayImg: [
                    Image.asset(
                      QPPImages.desktop_pic_nft_instruction_16,
                    ),
                    Image.asset(
                      QPPImages.desktop_pic_nft_instruction_17,
                    ),
                  ],
                  isDesktop: isDesktop,
                ),
              _ => const SizedBox.shrink()
            };
          }),
        ),
      );
}

class Info3 extends NFTTeachInfoExpand {
  const Info3.desktop({super.key}) : super.desktop();
  const Info3.mobile({super.key}) : super.mobile();

  @override
  Widget get title => NFTTeachSectionInfoTitle(
        titleKey: QppLocales.nftInfoTeachSubtitle2ContentTeach3,
        isDesktop: isDesktop,
      );

  @override
  Widget get content => Container(
        margin: const EdgeInsets.only(top: 20),
        child: ListView.builder(
          shrinkWrap: true,
          // 禁止 list 內容 滾動
          primary: false,
          itemCount: 4,
          itemBuilder: (context, index) {
            return switch (index) {
              0 => ItemTeachInfo(
                  contentKey:
                      QppLocales.nftInfoTeachSubtitle2ContentTeach3ContentStep1,
                  displayImg: [
                    Image.asset(QPPImages.desktop_pic_nft_instruction_18),
                  ],
                  isDesktop: isDesktop,
                ),
              1 => ItemTeachInfo(
                  margin: const EdgeInsets.only(top: 64),
                  contentKey:
                      QppLocales.nftInfoTeachSubtitle2ContentTeach3ContentStep2,
                  displayImg: [
                    Image.asset(QPPImages.desktop_pic_nft_instruction_19),
                  ],
                  isDesktop: isDesktop,
                ),
              2 => ItemTeachInfo(
                  margin: const EdgeInsets.only(top: 64),
                  contentKey:
                      QppLocales.nftInfoTeachSubtitle2ContentTeach3ContentStep3,
                  displayImg: [
                    Image.asset(QPPImages.desktop_pic_nft_instruction_20),
                  ],
                  isDesktop: isDesktop,
                ),
              3 => ItemTeachInfo(
                  margin: const EdgeInsets.only(top: 64),
                  contentKey:
                      QppLocales.nftInfoTeachSubtitle2ContentTeach3ContentStep4,
                  displayImg: [
                    Image.asset(QPPImages.desktop_pic_nft_instruction_21),
                  ],
                  isDesktop: isDesktop,
                ),
              _ => const SizedBox.shrink()
            };
          },
        ),
      );
}
