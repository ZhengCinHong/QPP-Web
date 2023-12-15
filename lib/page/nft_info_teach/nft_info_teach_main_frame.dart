import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:qpp_example/page/nft_info_teach/nft_teach_info_zone_1.dart';
import 'package:qpp_example/page/nft_info_teach/nft_teach_info_zone_2.dart';
import 'package:qpp_example/page/nft_info_teach/nft_teach_info_zone_3.dart';
import 'package:qpp_example/utils/qpp_color.dart';
import 'package:qpp_example/utils/qpp_image.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';
import 'package:qpp_example/utils/screen.dart';

class NFTInfoTeachPageMainFrame extends StatelessWidget {
  const NFTInfoTeachPageMainFrame({super.key});

  @override
  Widget build(BuildContext context) {
    // 設定頁籤上方顯示內容
    return Title(
        title: context.tr(QppLocales.homeWebtitle),
        color: QppColors.platinum,
        child: const NFTInfoTeachScaffold());
  }
}

/// NFT 教學頁 骨架
class NFTInfoTeachScaffold extends StatelessWidget {
  const NFTInfoTeachScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final ScreenStyle screenStyle = screenSize.width.determineScreenStyle();

    return SelectionArea(
        child: Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        padding: const EdgeInsets.only(bottom: 20),
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              screenStyle.isDesktop
                  ? QPPImages.desktop_bg_kv_2
                  : QPPImages.mobile_bg_kv_2,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            // 容器與四周間距
            margin: screenStyle.isDesktop
                ? const EdgeInsets.fromLTRB(60, 0, 60, 0)
                : const EdgeInsets.fromLTRB(24, 24, 24, 24),
            constraints: const BoxConstraints(maxWidth: 1280),
            width: double.infinity,
            child: ListView(
              children: [
                // top margin
                const SizedBox(
                  height: 80,
                ),
                // title
                Text(
                  context.tr(QppLocales.nftInfoTeachTitle),
                  textAlign: TextAlign.center,
                  style: QppTextStyles.web_44pt_Display_L_Maya_blue_L,
                ),
                // divider
                Container(
                  margin: const EdgeInsets.only(top: 23, bottom: 40),
                  height: 1,
                  color: QppColors.midnightBlue,
                ),
                // zone 1
                NFTTeachInfoZone1(
                  isDesktop: screenStyle.isDesktop,
                ),
                const SizedBox(
                  height: 64,
                ),
                // zone 2
                NFTTeachInfoZone2(
                  isDesktop: screenStyle.isDesktop,
                ),
                const SizedBox(
                  height: 64,
                ),
                // zone 3
                NFTTeachInfoZone3(isDesktop: screenStyle.isDesktop),
                // bottom margin
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
