import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:qpp_example/page/nft_info_teach/nft_teach_section.dart';
import 'package:qpp_example/utils/nft_info_teach_img_util.dart';
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
          ValueKey key = ValueKey('info$index');
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
            1 => isDesktop ?  Info1.desktop(key: key,) :  Info1.mobile(key: key,),
            2 => isDesktop ?  Info2.desktop(key: key,) :  Info2.mobile(key: key,),
            3 => isDesktop ?  Info3.desktop(key: key,) :  Info3.mobile(key: key,),
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
          physics: const NeverScrollableScrollPhysics(),
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
                    NFTInfoTeachImgUtil.getImg(1, isDesktop),
                    NFTInfoTeachImgUtil.getImg(2, isDesktop),
                  ],
                  isDesktop: isDesktop,
                ),
              1 => ItemTeachInfo(
                  margin: const EdgeInsets.only(top: 64),
                  contentKey:
                      QppLocales.nftInfoTeachSubtitle2ContentTeach1ContentStep2,
                  displayImg: [
                    NFTInfoTeachImgUtil.getImg(3, isDesktop),
                    NFTInfoTeachImgUtil.getImg(4, isDesktop),
                  ],
                  isDesktop: isDesktop,
                ),
              2 => ItemTeachInfo(
                  margin: const EdgeInsets.only(top: 64),
                  contentKey:
                      QppLocales.nftInfoTeachSubtitle2ContentTeach1ContentStep3,
                  displayImg: [
                    NFTInfoTeachImgUtil.getImg(5, isDesktop),
                  ],
                  isDesktop: isDesktop,
                ),
              3 => ItemTeachInfo(
                  margin: const EdgeInsets.only(top: 64),
                  contentKey:
                      QppLocales.nftInfoTeachSubtitle2ContentTeach1ContentStep4,
                  displayImg: [
                    NFTInfoTeachImgUtil.getImg(6, isDesktop),
                  ],
                  isDesktop: isDesktop,
                ),
              4 => ItemTeachInfo(
                  margin: const EdgeInsets.only(top: 64),
                  contentKey:
                      QppLocales.nftInfoTeachSubtitle2ContentTeach1ContentStep5,
                  displayImg: [
                    NFTInfoTeachImgUtil.getImg(7, isDesktop),
                    NFTInfoTeachImgUtil.getImg(8, isDesktop),
                    NFTInfoTeachImgUtil.getImg(9, isDesktop),
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
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: ((context, index) {
            return switch (index) {
              0 => ItemTeachInfo(
                  contentKey:
                      QppLocales.nftInfoTeachSubtitle2ContentTeach2ContentStep1,
                  displayImg: [
                    NFTInfoTeachImgUtil.getImg(10, isDesktop),
                  ],
                  isDesktop: isDesktop,
                ),
              1 => ItemTeachInfo(
                  margin: const EdgeInsets.only(top: 64),
                  contentKey:
                      QppLocales.nftInfoTeachSubtitle2ContentTeach2ContentStep2,
                  displayImg: [
                    NFTInfoTeachImgUtil.getImg(11, isDesktop),
                    NFTInfoTeachImgUtil.getImg(12, isDesktop),
                  ],
                  isDesktop: isDesktop,
                ),
              2 => ItemTeachInfo(
                  margin: const EdgeInsets.only(top: 64),
                  contentKey:
                      QppLocales.nftInfoTeachSubtitle2ContentTeach2ContentStep3,
                  displayImg: [
                    NFTInfoTeachImgUtil.getImg(13, isDesktop),
                  ],
                  isDesktop: isDesktop,
                ),
              3 => ItemTeachInfo(
                  margin: const EdgeInsets.only(top: 64),
                  contentKey:
                      QppLocales.nftInfoTeachSubtitle2ContentTeach2ContentStep4,
                  displayImg: [
                    NFTInfoTeachImgUtil.getImg(14, isDesktop),
                  ],
                  isDesktop: isDesktop,
                ),
              4 => ItemTeachInfo(
                  margin: const EdgeInsets.only(top: 64),
                  contentKey:
                      QppLocales.nftInfoTeachSubtitle2ContentTeach2ContentStep5,
                  displayImg: [
                    NFTInfoTeachImgUtil.getImg(15, isDesktop),
                    NFTInfoTeachImgUtil.getImg(16, isDesktop),
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
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 4,
          itemBuilder: (context, index) {
            return switch (index) {
              0 => ItemTeachInfo(
                  contentKey:
                      QppLocales.nftInfoTeachSubtitle2ContentTeach3ContentStep1,
                  displayImg: [
                    NFTInfoTeachImgUtil.getImg(17, isDesktop),
                  ],
                  isDesktop: isDesktop,
                ),
              1 => ItemTeachInfo(
                  margin: const EdgeInsets.only(top: 64),
                  contentKey:
                      QppLocales.nftInfoTeachSubtitle2ContentTeach3ContentStep2,
                  displayImg: [
                    NFTInfoTeachImgUtil.getImg(18, isDesktop),
                  ],
                  isDesktop: isDesktop,
                ),
              2 => ItemTeachInfo(
                  margin: const EdgeInsets.only(top: 64),
                  contentKey:
                      QppLocales.nftInfoTeachSubtitle2ContentTeach3ContentStep3,
                  displayImg: [
                    NFTInfoTeachImgUtil.getImg(19, isDesktop),
                  ],
                  isDesktop: isDesktop,
                ),
              3 => ItemTeachInfo(
                  margin: const EdgeInsets.only(top: 64),
                  contentKey:
                      QppLocales.nftInfoTeachSubtitle2ContentTeach3ContentStep4,
                  displayImg: [
                    NFTInfoTeachImgUtil.getImg(20, isDesktop),
                  ],
                  isDesktop: isDesktop,
                ),
              _ => const SizedBox.shrink()
            };
          },
        ),
      );
}
