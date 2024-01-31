import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:qpp_example/model/enum/item/nft_info_teach_anchor.dart';
import 'package:qpp_example/universal_link/universal_link_data.dart';
import 'package:qpp_example/utils/qpp_color.dart';

/// NFT 教學頁
class NFTInfoTeachPageMainFrame extends StatelessWidget {
  final GoRouterState routerState;
  final WidgetBuilder child;
  final Future libFuture;
  const NFTInfoTeachPageMainFrame(
      {super.key,
      required this.libFuture,
      required this.routerState,
      required this.child});

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
    return FutureBuilder(
        future: libFuture,
        builder: (context, snapshot) {
          // 設定頁籤上方顯示內容
          return Title(
              title: context.tr(QppLocales.homeWebtitle),
              color: QppColors.platinum,
              child: child.call(context));
        });
  }
}
