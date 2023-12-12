import 'package:flutter/material.dart';
import 'package:qpp_example/model/nft/nft_trait.dart';
import 'package:qpp_example/page/commodity_info/view/item_nft_section/nft_section.dart';
import 'package:qpp_example/utils/qpp_image.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';

/// stats section
class NFTSectionStats<List> extends NFTSection {
  const NFTSectionStats({super.key, required super.data});

  @override
  State<StatefulWidget> createState() => StateStats();
}

class StateStats extends StateSection {
  @override
  Widget get sectionContent => StatsContent(stats: widget.data);

  @override
  String get sectionTitle => 'Status';

  @override
  String get sectionTitleIconPath => QPPImages.desktop_icon_commodity_nft_stats;
}

class StatsContent extends StatelessWidget {
  final List<NFTTrait> stats;
  const StatsContent({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(60, 20, 60, 20),
      child: ListView.builder(
        itemCount: stats.length,
        itemBuilder: (context, index) {
          return ItemStats(
            trait: stats[index],
          );
        },
        // 是否根據 child 組件調整大小
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
      ),
    );
  }
}

class ItemStats extends StatelessWidget {
  final NFTTrait trait;
  const ItemStats({super.key, required this.trait});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 3.0),
      child: Text(
        displayValue,
        style: QppTextStyles.web_16pt_body_platinum_L,
      ),
    );
  }

  // 組合顯示字串
  String get displayValue {
    return '${trait.traitType} ${trait.value} of ${trait.maxValue}';
  }
}
