import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qpp_example/page/commodity_info/view/commodity_body_top.dart';
import 'package:qpp_example/page/commodity_info/view/commodity_info_body.dart';
import 'package:qpp_example/page/commodity_info/view/item_nft_section/nft_section_boost.dart';
import 'package:qpp_example/page/commodity_info/view/item_nft_section/nft_section_date.dart';
import 'package:qpp_example/page/commodity_info/view/item_nft_section/nft_section_levels.dart';
import 'package:qpp_example/page/commodity_info/view/item_nft_section/nft_section_properties.dart';
import 'package:qpp_example/page/commodity_info/view/item_nft_section/nft_section_stats.dart';
import 'package:qpp_example/page/commodity_info/view/mobile_info_divider.dart';
import 'package:qpp_example/page/commodity_info/view/item_nft_section/nft_section_description.dart';
import 'package:qpp_example/utils/qpp_color.dart';

/// NFT 物品資訊
class NFTItemInfo extends StatelessWidget {
  final bool isDesktop;
  const NFTItemInfo.desktop({super.key}) : isDesktop = true;
  const NFTItemInfo.mobile({super.key}) : isDesktop = false;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // 資料區 上半部
      const CommodityBodyTop(),
      // 若為 Mobile 版面, 要顯示黑色分隔線
      MobileInfoDivider(
        isMobile: !isDesktop,
      ),
      // 資料區下半部
      Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          var nft = ref.watch(itemSelectInfoProvider).nftMetaDataState.data;
          var attr = nft!.attributes;

          return Container(
              color: QppColors.oxfordBlue,
              constraints: const BoxConstraints(maxWidth: 1280),
              width: double.infinity,
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  // description
                  NFTSectionDescription(
                    data: nft,
                  ),
                  // properties
                  NFTSectionProperties(data: attr.propertiesSection),
                  // stats
                  NFTSectionStats(data: attr.statsSection),
                  // levels
                  NFTSectionLevels(data: attr.levelsSection),
                  // boosts
                  NFTSectionBoost(data: attr.boostSection),
                  // date
                  NFTSectionDate(data: attr.dateSection),
                ],
              ));
        },
      ),
    ]);
  }
}
