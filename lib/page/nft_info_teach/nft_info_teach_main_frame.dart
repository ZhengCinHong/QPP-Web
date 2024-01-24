import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:qpp_example/model/enum/item/nft_info_teach_anchor.dart';
import 'package:qpp_example/page/nft_info_teach/nft_info_teach_scaffold.dart'
    deferred as nft_info_teach_box;
import 'package:qpp_example/universal_link/universal_link_data.dart';
import 'package:qpp_example/utils/qpp_color.dart';

/// NFT 教學頁
class NFTInfoTeachPageMainFrame extends StatelessWidget {
  final GoRouterState routerState;
  final WidgetBuilder child;
  const NFTInfoTeachPageMainFrame({
    super.key,
    required this.routerState,
    required this.child
  });

  NFTInfoTeachAnchor findAnchor() {
    // 取得 link 參數資料
    UniversalLinkParamData universalLinkParamData =
        UniversalLinkParamData.fromJson(routerState.uri.queryParameters);
    if (universalLinkParamData.anchor != null) {
      return NFTInfoTeachAnchor.findTypeByValue(universalLinkParamData.anchor!);
    }
    return NFTInfoTeachAnchor.none;
  }

  Future<void> loadContent() async {
    await nft_info_teach_box.loadLibrary();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadContent(),
        builder: (context, snapshot) {
          // 設定頁籤上方顯示內容
          return Title(
              title: context.tr(QppLocales.homeWebtitle),
              color: QppColors.platinum,
              child: child.call(context)
              // (context) {
              //   return nft_info_teach_box.NFTInfoTeachScaffold(
              //     anchor: findAnchor(),
              //   );
              // }.call(context)
              );
        });
  }
}
