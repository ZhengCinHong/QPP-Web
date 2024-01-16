import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qpp_example/page/commodity_info/view/commodity_body_top.dart';
import 'package:qpp_example/page/commodity_info/view/commodity_info_body.dart';
import 'package:qpp_example/page/commodity_info/view/item_nft_section/nft_section_boost.dart';
import 'package:qpp_example/page/commodity_info/view/item_nft_section/nft_section_date.dart';
import 'package:qpp_example/page/commodity_info/view/item_nft_section/nft_section_levels.dart';
import 'package:qpp_example/page/commodity_info/view/item_nft_section/nft_section_properties.dart';
import 'package:qpp_example/page/commodity_info/view/item_nft_section/nft_section_stats.dart';
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
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: 6,
                shrinkWrap: true,
                primary: false,
                itemBuilder: (context, index) {
                  return switch (index) {
                    // description
                    0 => isDesktop
                        ? DescriptionExpand.desktop(
                            data: nft,
                          )
                        : DescriptionExpand.mobile(
                            data: nft,
                          ),
                    // properties
                    1 => isDesktop
                        ? PropertiesExpand.desktop(data: attr.propertiesSection)
                        : PropertiesExpand.mobile(data: attr.propertiesSection),
                    // stats
                    2 => isDesktop
                        ? StatsExpand.desktop(data: attr.statsSection)
                        : StatsExpand.mobile(data: attr.statsSection),
                    // levels
                    3 => isDesktop
                        ? LevelsExpand.desktop(data: attr.levelsSection)
                        : LevelsExpand.mobile(data: attr.levelsSection),
                    // boosts
                    4 => isDesktop
                        ? BoostExpand.desktop(data: attr.boostSection)
                        : BoostExpand.mobile(data: attr.boostSection),
                    // date
                    5 => isDesktop
                        ? DateExpand.desktop(data: attr.dateSection)
                        : DateExpand.mobile(data: attr.dateSection),
                    _ => const SizedBox.shrink()
                  };
                },
              ));
        },
      ),
    ]);
  }
}
