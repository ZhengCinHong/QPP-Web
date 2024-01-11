import 'package:flutter/material.dart';
import 'package:qpp_example/model/nft/nft_trait.dart';
import 'package:qpp_example/page/commodity_info/view/item_nft_section/nft_section.dart';
import 'package:qpp_example/utils/qpp_color.dart';
import 'package:qpp_example/utils/qpp_image.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';

class LevelsExpand extends NFTExpand<List> {
  const LevelsExpand.desktop({super.key, required super.data})
      : super.desktop();
  const LevelsExpand.mobile({super.key, required super.data}) : super.mobile();

  @override
  Widget? get title => const LevelsTitle();

  @override
  Widget? get content => LevelsContent(
        data: data,
        isDesktop: isDesktop,
      );
}

class LevelsTitle extends NFTSectionInfoTitle {
  const LevelsTitle({super.key});

  @override
  String get iconPath => QPPImages.desktop_icon_commodity_nft_levels;

  @override
  String get title => 'Levels';
}

class LevelsContent extends NFTSectionInfoContent<List> {
  const LevelsContent(
      {super.key, required super.isDesktop, required super.data});

  @override
  Widget get child {
    var level = getLevel();
    var upgrade = getUpgrade();
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ItemLevelsText(level: level),
      ItemLevelsIndicator(level: level),
      ItemLevelsUpgrade(upgrade: upgrade),
    ]);
  }

  // 取得顯示 level 的 trait
  NFTTrait? getLevel() {
    for (NFTTrait trait in data) {
      if (trait.traitType == 'LV' || trait.traitType == '等級') {
        return trait;
      }
    }
    return null;
  }

  NFTTrait? getUpgrade() {
    for (NFTTrait trait in data) {
      if (trait.traitType == '突破次數') {
        return trait;
      }
    }
    return null;
  }
}

// 顯示 LV 字串
class ItemLevelsText extends StatelessWidget {
  final NFTTrait? level;
  const ItemLevelsText({super.key, this.level});

  @override
  Widget build(BuildContext context) {
    if (level == null) {
      return const SizedBox.shrink();
    }
    return Text(
      displayLevel,
      style: QppTextStyles.web_16pt_body_platinum_L,
    );
  }

  String get displayLevel {
    return '${level!.traitType} ${level!.value} of ${level!.maxValue}';
  }
}

// 顯示 LV 進度指示器
class ItemLevelsIndicator extends StatelessWidget {
  final NFTTrait? level;
  const ItemLevelsIndicator({super.key, this.level});

  @override
  Widget build(BuildContext context) {
    if (level == null) {
      return const SizedBox.shrink();
    }
    // 四週要圓角, 用 container
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 15, 0, 15),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(2)),
      child: LinearProgressIndicator(
        minHeight: 12,
        backgroundColor: QppColors.midnightBlue,
        valueColor: const AlwaysStoppedAnimation(QppColors.mayaBlue),
        value: value,
      ),
    );
  }

  //
  double get value {
    return int.parse(level!.value) / int.parse(level!.maxValue);
  }
}

// 顯示 突破次數
class ItemLevelsUpgrade extends StatelessWidget {
  final NFTTrait? upgrade;
  const ItemLevelsUpgrade({super.key, this.upgrade});

  @override
  Widget build(BuildContext context) {
    if (upgrade == null) {
      return const SizedBox.shrink();
    }
    return Text(
      displayLevel,
      style: QppTextStyles.web_16pt_body_platinum_L,
    );
  }

  String get displayLevel {
    return '${upgrade!.traitType} ${upgrade!.value} ';
  }
}
