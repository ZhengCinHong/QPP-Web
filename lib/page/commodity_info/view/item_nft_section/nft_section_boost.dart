import 'package:flutter/material.dart';
import 'package:qpp_example/model/nft/nft_trait.dart';
import 'package:qpp_example/page/commodity_info/view/item_nft_section/nft_section.dart';
import 'package:qpp_example/utils/qpp_color.dart';
import 'package:qpp_example/utils/qpp_image.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';

/// boost section
class BoostExpand extends NFTExpand<List> {
  const BoostExpand.desktop({super.key, required super.data}) : super.desktop();
  const BoostExpand.mobile({super.key, required super.data}) : super.mobile();
  @override
  Widget? get title => const BoostTitle();

  @override
  Widget? get content => BoostContent(isDesktop: isDesktop, data: data);
}

class BoostTitle extends NFTSectionInfoTitle {
  const BoostTitle({super.key});

  @override
  String get title => 'Boosts';

  @override
  String get iconPath => QPPImages.desktop_icon_commodity_nft_boosts;
}

class BoostContent extends NFTSectionInfoContent<List> {
  const BoostContent(
      {super.key, required super.isDesktop, required super.data});

  @override
  Widget get child => ListView.builder(
      // 關掉 over scroll 效果
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: data.length,
      itemBuilder: (context, index) {
        return ItemBoost(boost: data[index]);
      });
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
