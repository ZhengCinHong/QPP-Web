import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:qpp_example/model/enum/item/nft_info_teach_anchor.dart';
import 'package:qpp_example/page/nft_info_teach/nft_teach_info_zone_1.dart';
import 'package:qpp_example/page/nft_info_teach/nft_teach_info_zone_2.dart';
import 'package:qpp_example/page/nft_info_teach/nft_teach_info_zone_3.dart';
import 'package:qpp_example/universal_link/universal_link_data.dart';
import 'package:qpp_example/utils/nft_info_teach_img_util.dart';
import 'package:qpp_example/utils/qpp_color.dart';
import 'package:qpp_example/utils/qpp_image.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';
import 'package:qpp_example/utils/screen.dart';

/// NFT 教學頁
class NFTInfoTeachPageMainFrame extends StatelessWidget {
  final GoRouterState routerState;
  const NFTInfoTeachPageMainFrame({super.key, required this.routerState});

  NFTInfoTeachAnchor findAnchor() {
    // 取得 link 參數資料
    UniversalLinkParamData universalLinkParamData =
        UniversalLinkParamData.fromJson(routerState.uri.queryParameters);
    if (universalLinkParamData.anchor != null) {
      return NFTInfoTeachAnchor.findTypeByValue(universalLinkParamData.anchor!);
    }
    return NFTInfoTeachAnchor.none;
  }

  @override
  Widget build(BuildContext context) {
    // 設定頁籤上方顯示內容
    return Title(
        title: context.tr(QppLocales.homeWebtitle),
        color: QppColors.platinum,
        child: NFTInfoTeachScaffold(
          anchor: findAnchor(),
        ));
  }
}

class NFTInfoTeachScaffold extends StatefulWidget {
  // 錨點
  final NFTInfoTeachAnchor anchor;
  const NFTInfoTeachScaffold({super.key, required this.anchor});

  @override
  StateNFTInfoTeach createState() => StateNFTInfoTeach();
}

/// NFT 教學頁 骨架
class StateNFTInfoTeach extends State<NFTInfoTeachScaffold>
    with WidgetsBindingObserver {
  // 滾動的錨點判斷
  final GlobalKey k1 = GlobalKey();
  final GlobalKey k2 = GlobalKey();
  final GlobalKey k3 = GlobalKey();
  final GlobalKey mainScrollKey = GlobalKey();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    preCacheAssetImages();
  }

  /// 預先載入大圖
  Future<void> preCacheAssetImages() async {
    var imgLen = NFTInfoTeachImgUtil.infoTeachImgList.length;
    for (var i = 0; i < imgLen; i++) {
      precacheImage(
        AssetImage(NFTInfoTeachImgUtil.infoTeachImgList[i]),
        context,
      );
    }
  }

  @override
  void initState() {
    if (widget.anchor != NFTInfoTeachAnchor.none) {
      WidgetsBinding.instance.addObserver(this);
      // // 有帶 anchor
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        // 這裡會在 build 之後呼叫
        Future.delayed(const Duration(milliseconds: 2000), () {
          // 延遲 1 秒後開始移動到指定位置
          Scrollable.ensureVisible(anchorKey(widget.anchor).currentContext!,
              duration: Duration(milliseconds: widget.anchor.scrollDuration));
        });
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  GlobalKey anchorKey(NFTInfoTeachAnchor anchor) {
    if (anchor == NFTInfoTeachAnchor.importFee) {
      return k2;
    } else if (anchor == NFTInfoTeachAnchor.entry) {
      return k3;
    }
    // 其他直接回第一個
    return k1;
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final ScreenStyle screenStyle = screenSize.width.determineScreenStyle();

    return SelectionArea(
        child: Scaffold(
      backgroundColor: QppColors.oxfordBlue,
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
                : const EdgeInsets.fromLTRB(20, 0, 20, 0),
            constraints: const BoxConstraints(maxWidth: 1280),
            width: double.infinity,
            // SingleChildScrollView 生成時會把內容都做出來
            child: SingleChildScrollView(
              key: mainScrollKey,
              child: Column(
                key: const ValueKey('NFTInfoTeachMainFrameColumn'),
                children: [
                  // top margin
                  const SizedBox(
                    key: ValueKey('SizedBoxMarginTop'),
                    height: 80,
                  ),
                  // title
                  Text(
                    context.tr(QppLocales.nftInfoTeachTitle),
                    key: const ValueKey('NFTInfoTeachTitle'),
                    textAlign: TextAlign.center,
                    style: QppTextStyles.web_44pt_Display_L_Maya_blue_L,
                  ),
                  // divider
                  Container(
                    key: const ValueKey('NFTInfoTeachDivider'),
                    margin: const EdgeInsets.only(top: 23, bottom: 40),
                    height: 1,
                    color: QppColors.midnightBlue,
                  ),
                  // zone 1
                  NFTTeachInfoZone1(
                    key: k1,
                    isDesktop: screenStyle.isDesktop,
                  ),
                  const SizedBox(
                    key: ValueKey('SizeBoxDivider1'),
                    height: 64,
                  ),
                  // zone 2
                  NFTTeachInfoZone2(
                    key: k2,
                    isDesktop: screenStyle.isDesktop,
                  ),
                  const SizedBox(
                    key: ValueKey('SizeBoxDivider2'),
                    height: 64,
                  ),
                  // zone 3
                  NFTTeachInfoZone3(key: k3, isDesktop: screenStyle.isDesktop),
                  // bottom margin
                  const SizedBox(
                    key: ValueKey('SizeBoxDivider3'),
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
