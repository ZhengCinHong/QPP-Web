import 'package:flutter/widgets.dart';
import 'package:qpp_example/extension/build_context.dart';
import 'package:qpp_example/page/commodity_info/view/commodity_body_top.dart';
import 'package:qpp_example/page/commodity_info/view/commodity_vote/send_vote_button.dart';
import 'package:qpp_example/page/commodity_info/view/commodity_vote/vote_options.dart';
import 'package:qpp_example/page/commodity_info/view/commodity_vote/vote_state.dart';
import 'package:qpp_example/page/commodity_info/view/commodity_vote/vote_statistics.dart';
import 'package:qpp_example/page/commodity_info/view/info_row.dart';

/// 問券調查(投票)資訊
class VoteItemInfo extends StatelessWidget {
  const VoteItemInfo.desktop({super.key}) : isDesktop = true;
  const VoteItemInfo.mobile({super.key}) : isDesktop = false;

  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 資料區 上半部
        const CommodityBodyTop(),
        // 資料區下半部
        Container(
          constraints: const BoxConstraints(maxWidth: 1280),
          padding: EdgeInsets.only(bottom: 20, top: isDesktop ? 0 : 10),
          child: Column(
            children: [
              // 狀態
              isDesktop
                  ? const VoteItemState.desktop()
                  : const VoteItemState.mobile(),
              // 類別欄位
              isDesktop
                  ? const VoucherInfoRowInfo.desktop()
                  : const VoucherInfoRowInfo.mobile(),
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
                  ? const InfoRowDescription.desktop(isQuestionnaire: true)
                  : const InfoRowDescription.mobile(isQuestionnaire: true),
              // 目前統計
              isDesktop
                  ? const VoteStatistics.desktop()
                  : const VoteStatistics.mobile(),
              // 問券選項
              isDesktop
                  ? const VoteOptions.desktop()
                  : const VoteOptions.mobile(),
              // 送出投票按鈕
              context.isDesktopPlatform
                  ? isDesktop
                      ? const SendVoteButton.desktop()
                      : const SendVoteButton.mobile()
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ],
    );
  }
}
