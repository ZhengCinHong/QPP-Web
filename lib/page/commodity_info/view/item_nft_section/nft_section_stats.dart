import 'package:flutter/material.dart';
import 'package:qpp_example/model/nft/nft_trait.dart';
import 'package:qpp_example/page/commodity_info/view/item_nft_section/nft_section.dart';
import 'package:qpp_example/utils/qpp_image.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';

/// stats section
class StatsExpand extends NFTExpand<List> {
  const StatsExpand.desktop({super.key, required super.data}) : super.desktop();
  const StatsExpand.mobile({super.key, required super.data}) : super.mobile();
  @override
  Widget? get title => const StatsTitle();

  @override
  Widget? get content => StatsContent(isDesktop: isDesktop, data: data);
}

class StatsTitle extends NFTSectionInfoTitle {
  const StatsTitle({super.key});

  @override
  String get title => 'Status';

  @override
  String get iconPath => QPPImages.desktop_icon_commodity_nft_stats;
}

class StatsContent extends NFTSectionInfoContent<List> {
  const StatsContent(
      {super.key, required super.isDesktop, required super.data});

  @override
  Widget get child => ListView.builder(
        // 關掉 over scroll 效果
        physics: const BouncingScrollPhysics(),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ItemStats(
            trait: data[index],
          );
        },
        // 是否根據 child 組件調整大小
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
      );
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
    if (trait.maxValue.isNotEmpty) {
      return '${trait.traitType} ${trait.value} of ${trait.maxValue}';
    }
    return '${trait.traitType} ${trait.value}';
  }
}
