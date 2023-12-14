import 'package:flutter/material.dart';
import 'package:qpp_example/page/commodity_info/view/info_row.dart';
import 'package:qpp_example/page/commodity_info/view/commodity_body_top.dart';

/// 一般物品資訊
class NormalItemInfo extends StatelessWidget {
  final bool isDesktop;
  const NormalItemInfo.desktop({super.key}) : isDesktop = true;
  const NormalItemInfo.mobile({super.key}) : isDesktop = false;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // 資料區 上半部
      const CommodityBodyTop(),
      // 資料區下半部
      Container(
          constraints: const BoxConstraints(maxWidth: 1280),
          width: double.infinity,
          padding: EdgeInsets.only(bottom: 20, top: isDesktop ? 0 : 10),
          child: Column(
            children: [
              // 類別欄位
              isDesktop
                  ? const InfoRowInfo.desktop()
                  : const InfoRowInfo.mobile(),
              // 創建者欄位
              isDesktop
                  ? const InfoRowCreator.desktop()
                  : const InfoRowCreator.mobile(),
              // 連結欄位
              isDesktop
                  ? const InfoRowIntroLink.desktop()
                  : const InfoRowIntroLink.mobile(),
              // 說明欄位
              isDesktop
                  ? const InfoRowDescription.desktop()
                  : const InfoRowDescription.mobile(),
            ],
          )),
    ]);
  }
}
