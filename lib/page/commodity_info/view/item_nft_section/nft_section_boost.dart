import 'package:flutter/material.dart';
import 'package:qpp_example/model/nft/nft_trait.dart';
import 'package:qpp_example/page/commodity_info/view/item_nft_section/nft_section.dart';
import 'package:qpp_example/utils/qpp_color.dart';
import 'package:qpp_example/utils/qpp_image.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';

/// boost section
class NFTSectionBoost extends NFTSection {
  const NFTSectionBoost.desktop({super.key, required super.data})
      : super.desktop();
  const NFTSectionBoost.mobile({super.key, required super.data})
      : super.mobile();

  @override
  State<StatefulWidget> createState() => StateBoost();
}

class StateBoost extends StateSection {
  @override
  Widget get sectionContent => BoostContent(boosts: widget.data);

  @override
  String get sectionTitle => 'Boosts';

  @override
  String get sectionTitleIconPath =>
      QPPImages.desktop_icon_commodity_nft_boosts;
}

class BoostContent extends StatelessWidget {
  final List<NFTTrait> boosts;
  const BoostContent({super.key, required this.boosts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: boosts.length,
        itemBuilder: (context, index) {
          return ItemBoost(boost: boosts[index]);
        });
  }
}

class ItemBoost extends StatelessWidget {
  final NFTTrait boost;
  const ItemBoost({super.key, required this.boost});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.fromLTRB(20, 13, 20, 13),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: QppColors.stPatricksBlue,
        border: Border.all(
          color: QppColors.darkPastelBlue,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        _display,
        style: QppTextStyles.web_16pt_body_platinum_L,
      ),
    );
  }

  // 取得顯示字串
  String get _display {
    return '${boost.traitType} + ${boost.value}$_lastDisplay';
  }

  // 判斷最後是否要加上百分比
  String get _lastDisplay {
    if (boost.displayType == "boost_percentage") {
      return "%";
    }
    return "";
  }
}
