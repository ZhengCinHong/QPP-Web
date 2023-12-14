import 'dart:js';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:qpp_example/page/nft_info_teach/nft_teach_section.dart';
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
  Widget get content => Container(
        margin: const EdgeInsets.only(top: 20),
        child: Builder(builder: (context) {
          return Text(
            context.tr(QppLocales.nftInfoTeachSubtitle1ContentA1),
            style: QppTextStyles.web_16pt_body_platinum_L,
          );
        }),
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
  Widget get content => Container(
        margin: const EdgeInsets.only(top: 20),
        child: Builder(builder: (context) {
          return Text(
            context.tr(QppLocales.nftInfoTeachSubtitle1ContentA2),
            style: QppTextStyles.web_16pt_body_platinum_L,
          );
        }),
      );
}
