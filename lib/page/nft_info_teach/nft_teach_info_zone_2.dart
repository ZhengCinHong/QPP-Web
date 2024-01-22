import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:qpp_example/page/nft_info_teach/nft_info_teach_main_frame.dart';
import 'package:qpp_example/page/nft_info_teach/nft_teach_section.dart';
import 'package:qpp_example/utils/nft_info_teach_img_size.dart';
import 'package:qpp_example/utils/qpp_image.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';

class NFTTeachInfoZone2 extends StatelessWidget {
  final bool isDesktop;

  const NFTTeachInfoZone2({super.key, required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
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
                    SizedBox(
                      width: NFTInfoTeachImgSize.getSize(1, isDesktop).width,
                      height: NFTInfoTeachImgSize.getSize(1, isDesktop).height,
                      child: Image.asset(
                        QPPImages.desktop_pic_nft_instruction_02,
                        cacheWidth: NFTInfoTeachImgSize.getWidth(1, isDesktop),
                        cacheHeight: NFTInfoTeachImgSize.getHeight(1, isDesktop),
                      ),
                    ),
                    SizedBox(
                      width: NFTInfoTeachImgSize.getSize(2, isDesktop).width,
                      height: NFTInfoTeachImgSize.getSize(2, isDesktop).height,
                      child: Image.asset(
                        QPPImages.desktop_pic_nft_instruction_03,
                        cacheWidth: NFTInfoTeachImgSize.getWidth(2, isDesktop),
                        cacheHeight: NFTInfoTeachImgSize.getHeight(2, isDesktop),
                      ),
                    ),
                  ],
                  isDesktop: isDesktop,
                ),
              1 => ItemTeachInfo(
                  margin: const EdgeInsets.only(top: 64),
                  contentKey:
                      QppLocales.nftInfoTeachSubtitle2ContentTeach1ContentStep2,
                  displayImg: [
                    SizedBox(
                      width: NFTInfoTeachImgSize.getSize(3, isDesktop).width,
                      height: NFTInfoTeachImgSize.getSize(3, isDesktop).height,
                      child: Image.asset(
                        QPPImages.desktop_pic_nft_instruction_04,
                        cacheWidth: NFTInfoTeachImgSize.getWidth(3, isDesktop),
                        cacheHeight: NFTInfoTeachImgSize.getHeight(3, isDesktop),
                      ),
                    ),
                    SizedBox(
                      width: NFTInfoTeachImgSize.getSize(4, isDesktop).width,
                      height: NFTInfoTeachImgSize.getSize(4, isDesktop).height,
                      child: Image.asset(
                        QPPImages.desktop_pic_nft_instruction_05,
                        cacheWidth: NFTInfoTeachImgSize.getWidth(4, isDesktop),
                        cacheHeight: NFTInfoTeachImgSize.getHeight(4, isDesktop),
                      ),
                    ),
                  ],
                  isDesktop: isDesktop,
                ),
              2 => ItemTeachInfo(
                  margin: const EdgeInsets.only(top: 64),
                  contentKey:
                      QppLocales.nftInfoTeachSubtitle2ContentTeach1ContentStep3,
                  displayImg: [
                    SizedBox(
                      width: NFTInfoTeachImgSize.getSize(5, isDesktop).width,
                      height: NFTInfoTeachImgSize.getSize(5, isDesktop).height,
                      child: Image.asset(
                        QPPImages.desktop_pic_nft_instruction_06,
                        cacheWidth: NFTInfoTeachImgSize.getWidth(5, isDesktop),
                        cacheHeight: NFTInfoTeachImgSize.getHeight(5, isDesktop),
                      ),
                    ),
                  ],
                  isDesktop: isDesktop,
                ),
              3 => ItemTeachInfo(
                  margin: const EdgeInsets.only(top: 64),
                  contentKey:
                      QppLocales.nftInfoTeachSubtitle2ContentTeach1ContentStep4,
                  displayImg: [
                    SizedBox(
                      width: NFTInfoTeachImgSize.getSize(6, isDesktop).width,
                      height: NFTInfoTeachImgSize.getSize(6, isDesktop).height,
                      child: Image.asset(
                        QPPImages.desktop_pic_nft_instruction_07,
                        cacheWidth: NFTInfoTeachImgSize.getWidth(6, isDesktop),
                        cacheHeight: NFTInfoTeachImgSize.getHeight(6, isDesktop),
                      ),
                    ),
                  ],
                  isDesktop: isDesktop,
                ),
              4 => ItemTeachInfo(
                  margin: const EdgeInsets.only(top: 64),
                  contentKey:
                      QppLocales.nftInfoTeachSubtitle2ContentTeach1ContentStep5,
                  displayImg: [
                    SizedBox(
                      width: NFTInfoTeachImgSize.getSize(7, isDesktop).width,
                      height: NFTInfoTeachImgSize.getSize(7, isDesktop).height,
                      child: Image.asset(
                        QPPImages.desktop_pic_nft_instruction_08,
                        cacheWidth: NFTInfoTeachImgSize.getWidth(7, isDesktop),
                        cacheHeight: NFTInfoTeachImgSize.getHeight(7, isDesktop),
                      ),
                    ),
                    SizedBox(
                      width: NFTInfoTeachImgSize.getSize(8, isDesktop).width,
                      height: NFTInfoTeachImgSize.getSize(8, isDesktop).height,
                      child: Image.asset(
                        QPPImages.desktop_pic_nft_instruction_09,
                        cacheWidth: NFTInfoTeachImgSize.getWidth(8, isDesktop),
                        cacheHeight: NFTInfoTeachImgSize.getHeight(8, isDesktop),
                      ),
                    ),
                    SizedBox(
                      width: NFTInfoTeachImgSize.getSize(9, isDesktop).width,
                      height: NFTInfoTeachImgSize.getSize(9, isDesktop).height,
                      child: Image.asset(
                        QPPImages.desktop_pic_nft_instruction_10,
                        cacheWidth: NFTInfoTeachImgSize.getWidth(9, isDesktop),
                        cacheHeight: NFTInfoTeachImgSize.getHeight(9, isDesktop),
                      ),
                    ),
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
                    SizedBox(
                      width: NFTInfoTeachImgSize.getSize(10, isDesktop).width,
                      height: NFTInfoTeachImgSize.getSize(10, isDesktop).height,
                      child: Image.asset(
                        QPPImages.desktop_pic_nft_instruction_11,
                        cacheWidth: NFTInfoTeachImgSize.getWidth(10, isDesktop),
                        cacheHeight: NFTInfoTeachImgSize.getHeight(10, isDesktop),
                      ),
                    ),
                  ],
                  isDesktop: isDesktop,
                ),
              1 => ItemTeachInfo(
                  margin: const EdgeInsets.only(top: 64),
                  contentKey:
                      QppLocales.nftInfoTeachSubtitle2ContentTeach2ContentStep2,
                  displayImg: [
                    SizedBox(
                      width: NFTInfoTeachImgSize.getSize(11, isDesktop).width,
                      height: NFTInfoTeachImgSize.getSize(11, isDesktop).height,
                      child: Image.asset(
                        QPPImages.desktop_pic_nft_instruction_12,
                        cacheWidth: NFTInfoTeachImgSize.getWidth(11, isDesktop),
                        cacheHeight: NFTInfoTeachImgSize.getHeight(11, isDesktop),
                      ),
                    ),
                    SizedBox(
                      width: NFTInfoTeachImgSize.getSize(12, isDesktop).width,
                      height: NFTInfoTeachImgSize.getSize(12, isDesktop).height,
                      child: Image.asset(
                        QPPImages.desktop_pic_nft_instruction_13,
                        cacheWidth: NFTInfoTeachImgSize.getWidth(12, isDesktop),
                        cacheHeight: NFTInfoTeachImgSize.getHeight(12, isDesktop),
                      ),
                    ),
                  ],
                  isDesktop: isDesktop,
                ),
              2 => ItemTeachInfo(
                  margin: const EdgeInsets.only(top: 64),
                  contentKey:
                      QppLocales.nftInfoTeachSubtitle2ContentTeach2ContentStep3,
                  displayImg: [
                    SizedBox(
                      width: NFTInfoTeachImgSize.getSize(13, isDesktop).width,
                      height: NFTInfoTeachImgSize.getSize(13, isDesktop).height,
                      child: Image.asset(
                        QPPImages.desktop_pic_nft_instruction_14,
                        cacheWidth: NFTInfoTeachImgSize.getWidth(13, isDesktop),
                        cacheHeight: NFTInfoTeachImgSize.getHeight(13, isDesktop),
                      ),
                    ),
                  ],
                  isDesktop: isDesktop,
                ),
              3 => ItemTeachInfo(
                  margin: const EdgeInsets.only(top: 64),
                  contentKey:
                      QppLocales.nftInfoTeachSubtitle2ContentTeach2ContentStep4,
                  displayImg: [
                    SizedBox(
                      width: NFTInfoTeachImgSize.getSize(14, isDesktop).width,
                      height: NFTInfoTeachImgSize.getSize(14, isDesktop).height,
                      child: Image.asset(
                        QPPImages.desktop_pic_nft_instruction_15,
                        cacheWidth: NFTInfoTeachImgSize.getWidth(14, isDesktop),
                        cacheHeight: NFTInfoTeachImgSize.getHeight(14, isDesktop),
                      ),
                    ),
                  ],
                  isDesktop: isDesktop,
                ),
              4 => ItemTeachInfo(
                  margin: const EdgeInsets.only(top: 64),
                  contentKey:
                      QppLocales.nftInfoTeachSubtitle2ContentTeach2ContentStep5,
                  displayImg: [
                    SizedBox(
                      width: NFTInfoTeachImgSize.getSize(15, isDesktop).width,
                      height: NFTInfoTeachImgSize.getSize(15, isDesktop).height,
                      child: Image.asset(
                        QPPImages.desktop_pic_nft_instruction_16,
                        cacheWidth: NFTInfoTeachImgSize.getWidth(15, isDesktop),
                        cacheHeight: NFTInfoTeachImgSize.getHeight(15, isDesktop),
                      ),
                    ),
                    SizedBox(
                      width: NFTInfoTeachImgSize.getSize(16, isDesktop).width,
                      height: NFTInfoTeachImgSize.getSize(16, isDesktop).height,
                      child: Image.asset(
                        QPPImages.desktop_pic_nft_instruction_17,
                        cacheWidth: NFTInfoTeachImgSize.getWidth(16, isDesktop),
                        cacheHeight: NFTInfoTeachImgSize.getHeight(16, isDesktop),
                      ),
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
                    SizedBox(
                      width: NFTInfoTeachImgSize.getSize(17, isDesktop).width,
                      height: NFTInfoTeachImgSize.getSize(17, isDesktop).height,
                      child: Image.asset(
                        QPPImages.desktop_pic_nft_instruction_18,
                        cacheWidth: NFTInfoTeachImgSize.getWidth(17, isDesktop),
                        cacheHeight: NFTInfoTeachImgSize.getHeight(17, isDesktop),
                      ),
                    ),
                  ],
                  isDesktop: isDesktop,
                ),
              1 => ItemTeachInfo(
                  margin: const EdgeInsets.only(top: 64),
                  contentKey:
                      QppLocales.nftInfoTeachSubtitle2ContentTeach3ContentStep2,
                  displayImg: [
                    SizedBox(
                      width: NFTInfoTeachImgSize.getSize(18, isDesktop).width,
                      height: NFTInfoTeachImgSize.getSize(18, isDesktop).height,
                      child: Image.asset(
                        QPPImages.desktop_pic_nft_instruction_19,
                        cacheWidth: NFTInfoTeachImgSize.getWidth(18, isDesktop),
                        cacheHeight: NFTInfoTeachImgSize.getHeight(18, isDesktop),
                      ),
                    ),
                  ],
                  isDesktop: isDesktop,
                ),
              2 => ItemTeachInfo(
                  margin: const EdgeInsets.only(top: 64),
                  contentKey:
                      QppLocales.nftInfoTeachSubtitle2ContentTeach3ContentStep3,
                  displayImg: [
                    SizedBox(
                      width: NFTInfoTeachImgSize.getSize(19, isDesktop).width,
                      height: NFTInfoTeachImgSize.getSize(19, isDesktop).height,
                      child: Image.asset(
                        QPPImages.desktop_pic_nft_instruction_20,
                        cacheWidth: NFTInfoTeachImgSize.getWidth(19, isDesktop),
                        cacheHeight: NFTInfoTeachImgSize.getHeight(19, isDesktop),
                      ),
                    ),
                  ],
                  isDesktop: isDesktop,
                ),
              3 => ItemTeachInfo(
                  margin: const EdgeInsets.only(top: 64),
                  contentKey:
                      QppLocales.nftInfoTeachSubtitle2ContentTeach3ContentStep4,
                  displayImg: [
                    SizedBox(
                      width: NFTInfoTeachImgSize.getSize(20, isDesktop).width,
                      height: NFTInfoTeachImgSize.getSize(20, isDesktop).height,
                      child: Image.asset(
                        QPPImages.desktop_pic_nft_instruction_21,
                        cacheWidth: NFTInfoTeachImgSize.getWidth(20, isDesktop),
                        cacheHeight: NFTInfoTeachImgSize.getHeight(20, isDesktop),
                      ),
                    ),
                  ],
                  isDesktop: isDesktop,
                ),
              _ => const SizedBox.shrink()
            };
          },
        ),
      );
}
