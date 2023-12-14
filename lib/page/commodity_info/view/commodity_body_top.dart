import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qpp_example/api/core/api_response.dart';
import 'package:qpp_example/common_ui/qpp_image/item_image.dart';
import 'package:qpp_example/model/nft/qpp_nft.dart';
import 'package:qpp_example/model/qpp_item.dart';
import 'package:qpp_example/model/vote/qpp_vote.dart';
import 'package:qpp_example/page/commodity_info/view/commodity_info_body.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';
import 'package:qpp_example/utils/qpp_image.dart';

/// 物品容器上半部區塊 (物品圖片, 名稱)
class CommodityBodyTop extends StatelessWidget {
  const CommodityBodyTop({super.key});

  @override
  Widget build(BuildContext context) {
    return // 資料區 上半部
        Container(
      margin: const EdgeInsets.only(bottom: 0),
      constraints: const BoxConstraints(maxWidth: 1280, maxHeight: 292),
      width: double.infinity,
      height: double.infinity,
      // 上半部 bg
      decoration: const _ContainerDecoration(),
      child: Column(children: [
        // 物品圖片
        const ItemImgPhoto(),
        Expanded(child: // 物品名稱
            Center(
          child: Consumer(builder: (context, ref, _) {
            // 一般物品
            ApiResponse<QppItem> itemInfoState =
                ref.watch(itemSelectInfoProvider).itemSelectInfoState;
            // 問券
            ApiResponse<QppVote> voteItemInfoState =
                ref.watch(itemSelectInfoProvider).voteDataState;
            // NFT 物品
            ApiResponse<QppNFT> nftMetaState =
                ref.watch(itemSelectInfoProvider).nftMetaDataState;

            if (itemInfoState.isCompleted) {
              return content(itemInfoState.data?.name ?? "");
            } else if (voteItemInfoState.isCompleted) {
              return content(voteItemInfoState.data?.itemName ?? "");
            } else if (nftMetaState.isCompleted) {
              return content(nftMetaState.data?.name ?? "");
            } else {
              return const SizedBox();
            }
          }),
        )),
      ]),
    );
  }

  Widget content(String name) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Text(
        name,
        style: QppTextStyles.web_20pt_title_m_white_C,
      ),
    );
  }
}

/// 容器 Decoration
class _ContainerDecoration extends BoxDecoration {
  const _ContainerDecoration();
  @override
  DecorationImage? get image {
    return const DecorationImage(
        // 背景圖
        image:
            AssetImage(QPPImages.desktop_pic_commodity_largepic_sample_general),
        fit: BoxFit.none);
  }
}
