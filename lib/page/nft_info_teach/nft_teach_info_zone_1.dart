import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:qpp_example/page/nft_info_teach/nft_teach_section.dart';
import 'package:qpp_example/utils/nft_info_teach_img_util.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';

class NFTTeachInfoZone1 extends StatelessWidget {
  final bool isDesktop;
  const NFTTeachInfoZone1({super.key, required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 6,
        shrinkWrap: true,
        // 禁止 list 內容 滾動
        primary: false,
        itemBuilder: (context, index) {
          ValueKey key = ValueKey('info$index');
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
            1 => isDesktop
                ? Info1.desktop(
                    key: key,
                  )
                : Info1.mobile(
                    key: key,
                  ),
            2 => isDesktop
                ? Info2.desktop(
                    key: key,
                  )
                : Info2.mobile(
                    key: key,
                  ),
            3 => isDesktop
                ? Info3.desktop(
                    key: key,
                  )
                : Info3.mobile(
                    key: key,
                  ),
            4 => isDesktop
                ? Info4.desktop(
                    key: key,
                  )
                : Info4.mobile(
                    key: key,
                  ),
            5 => isDesktop
                ? Info5.desktop(
                    key: key,
                  )
                : Info5.mobile(
                    key: key,
                  ),
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
          NFTInfoTeachImgUtil.getImg(0, isDesktop),
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
