import 'package:flutter/widgets.dart';
import 'package:qpp_example/page/commodity_info/view/commodity_body_top.dart';
import 'package:qpp_example/page/commodity_info/view/commodity_vote/vote_state.dart';
import 'package:qpp_example/page/commodity_info/view/info_row.dart';

/// 問券調查(投票)資訊
class VoteItemInfo extends StatelessWidget {
  const VoteItemInfo.desktop({super.key}) : isDesktop = true;
  const VoteItemInfo.mobile({super.key}) : isDesktop = false;

  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // 資料區 上半部
      const CommodityBodyTop(),
      isDesktop ? const VoteItemState.desktop() : const VoteItemState.mobile(),
      // 資料區下半部
      Container(
          constraints: const BoxConstraints(maxWidth: 1280),
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
