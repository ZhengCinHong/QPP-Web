import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:qpp_example/page/nft_info_teach/nft_teach_section.dart';
import 'package:qpp_example/utils/qpp_image.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';

class NFTTeachInfoZone1 extends StatelessWidget {
  final bool isDesktop;
  const NFTTeachInfoZone1({super.key, required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 6,
        shrinkWrap: true,
        // 禁止 list 內容 滾動
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return switch (index) {
            0 => Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: Text(
                  context.tr(QppLocales.nftInfoTeachSubtitle1),
                  style: isDesktop
                      ? QppTextStyles.web_24pt_title_L_maya_blue_C
                      : QppTextStyles.mobile_20pt_title_L_maya_blue_L,
                ),
              ),
            1 => isDesktop ? const Info1.desktop() : const Info1.mobile(),
            2 => isDesktop ? const Info2.desktop() : const Info2.mobile(),
            3 => isDesktop ? const Info3.desktop() : const Info3.mobile(),
            4 => isDesktop ? const Info4.desktop() : const Info4.mobile(),
            5 => isDesktop ? const Info5.desktop() : const Info5.mobile(),
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
        titleKey: QppLocales.nftInfoTeachSubtitle1ContentQ1,
        isDesktop: isDesktop,
      );

  @override
  Widget get content => ItemTeachInfo(
        margin: const EdgeInsets.only(top: 20),
        contentKey: QppLocales.nftInfoTeachSubtitle1ContentA1,
        isDesktop: isDesktop,
      );
}

class Info2 extends NFTTeachInfoExpand {
  const Info2.desktop({super.key}) : super.desktop();
  const Info2.mobile({super.key}) : super.mobile();

  @override
  Widget get title => NFTTeachSectionInfoTitle(
        titleKey: QppLocales.nftInfoTeachSubtitle1ContentQ2,
        isDesktop: isDesktop,
      );

  @override
  Widget get content => ItemTeachInfo(
        margin: const EdgeInsets.only(top: 20),
        contentKey: QppLocales.nftInfoTeachSubtitle1ContentA2,
        tipKey: QppLocales.nftInfoTeachSubtitle1ContentA2Tip,
        displayImg: [
          Image.asset(QPPImages.desktop_pic_nft_instruction_01),
        ],
        isDesktop: isDesktop,
      );
}

class Info3 extends NFTTeachInfoExpand {
  const Info3.desktop({super.key}) : super.desktop();
  const Info3.mobile({super.key}) : super.mobile();

  @override
  Widget get title => NFTTeachSectionInfoTitle(
        titleKey: QppLocales.nftInfoTeachSubtitle1ContentQ3,
        isDesktop: isDesktop,
      );
  @override
  Widget get content => ItemTeachInfo(
        margin: const EdgeInsets.only(top: 20),
        contentKey: QppLocales.nftInfoTeachSubtitle1ContentA3,
        isDesktop: isDesktop,
      );
}

class Info4 extends NFTTeachInfoExpand {
  const Info4.desktop({super.key}) : super.desktop();
  const Info4.mobile({super.key}) : super.mobile();

  @override
  Widget get title => NFTTeachSectionInfoTitle(
        titleKey: QppLocales.nftInfoTeachSubtitle1ContentQ4,
        isDesktop: isDesktop,
      );

  @override
  Widget get content => ItemTeachInfo(
        margin: const EdgeInsets.only(top: 20),
        contentKey: QppLocales.nftInfoTeachSubtitle1ContentA4,
        isDesktop: isDesktop,
      );
}

class Info5 extends NFTTeachInfoExpand {
  const Info5.desktop({super.key}) : super.desktop();
  const Info5.mobile({super.key}) : super.mobile();

  @override
  Widget get title => NFTTeachSectionInfoTitle(
        titleKey: QppLocales.nftInfoTeachSubtitle1ContentQ5,
        isDesktop: isDesktop,
      );

  @override
  Widget get content => ItemTeachInfo(
        margin: const EdgeInsets.only(top: 20),
        contentKey: QppLocales.nftInfoTeachSubtitle1ContentA5,
        isDesktop: isDesktop,
      );
}
