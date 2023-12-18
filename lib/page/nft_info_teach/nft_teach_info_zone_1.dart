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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: Text(
            context.tr(QppLocales.nftInfoTeachSubtitle1),
            style: QppTextStyles.web_24pt_title_L_maya_blue_C,
          ),
        ),
        const Info1.desktop(),
        const Info2.desktop(),
        const Info3.desktop(),
        const Info4.desktop(),
        const Info5.desktop(),
      ],
    );
  }
}

class Info1 extends NFTTeachInfoExpand {
  const Info1.desktop({super.key}) : super.desktop();
  const Info1.mobile({super.key}) : super.mobile();

  @override
  Widget get title => const NFTTeachSectionInfoTitle(
        titleKey: QppLocales.nftInfoTeachSubtitle1ContentQ1,
      );

  @override
  Widget get content => const ItemTeachInfo(
        margin: EdgeInsets.only(top: 20),
        contentKey: QppLocales.nftInfoTeachSubtitle1ContentA1,
      );
}

class Info2 extends NFTTeachInfoExpand {
  const Info2.desktop({super.key}) : super.desktop();
  const Info2.mobile({super.key}) : super.mobile();

  @override
  Widget get title => const NFTTeachSectionInfoTitle(
        titleKey: QppLocales.nftInfoTeachSubtitle1ContentQ2,
      );

  @override
  Widget get content => ItemTeachInfo(
        margin: const EdgeInsets.only(top: 20),
        contentKey: QppLocales.nftInfoTeachSubtitle1ContentA2,
        tipKey: QppLocales.nftInfoTeachSubtitle1ContentA2Tip,
        displayImg: [
          Image.asset(QPPImages.desktop_pic_nft_instruction_01),
        ],
      );
}

class Info3 extends NFTTeachInfoExpand {
  const Info3.desktop({super.key}) : super.desktop();
  const Info3.mobile({super.key}) : super.mobile();

  @override
  Widget get title => const NFTTeachSectionInfoTitle(
        titleKey: QppLocales.nftInfoTeachSubtitle1ContentQ3,
      );
  @override
  Widget get content => const ItemTeachInfo(
        margin: EdgeInsets.only(top: 20),
        contentKey: QppLocales.nftInfoTeachSubtitle1ContentA3,
      );
}

class Info4 extends NFTTeachInfoExpand {
  const Info4.desktop({super.key}) : super.desktop();
  const Info4.mobile({super.key}) : super.mobile();

  @override
  Widget get title => const NFTTeachSectionInfoTitle(
        titleKey: QppLocales.nftInfoTeachSubtitle1ContentQ4,
      );

  @override
  Widget get content => const ItemTeachInfo(
        margin: EdgeInsets.only(top: 20),
        contentKey: QppLocales.nftInfoTeachSubtitle1ContentA4,
      );
}

class Info5 extends NFTTeachInfoExpand {
  const Info5.desktop({super.key}) : super.desktop();
  const Info5.mobile({super.key}) : super.mobile();

  @override
  Widget get title => const NFTTeachSectionInfoTitle(
        titleKey: QppLocales.nftInfoTeachSubtitle1ContentQ5,
      );

  @override
  Widget get content => const ItemTeachInfo(
        margin: EdgeInsets.only(top: 20),
        contentKey: QppLocales.nftInfoTeachSubtitle1ContentA5,
      );
}
