import 'package:flutter/material.dart';
import 'package:qpp_example/model/nft/nft_trait.dart';
import 'package:qpp_example/page/commodity_info/view/item_nft_section/nft_section.dart';
import 'package:qpp_example/utils/qpp_color.dart';
import 'package:qpp_example/utils/qpp_image.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';

class PropertiesExpand extends NFTExpand<List> {
  const PropertiesExpand.desktop({super.key, required super.data})
      : super.desktop();
  const PropertiesExpand.mobile({super.key, required super.data})
      : super.mobile();

  @override
  Widget? get title => const PropertiesTitle();

  @override
  Widget? get content => PropertiesContent(
        data: data,
        isDesktop: isDesktop,
      );
}

class PropertiesTitle extends NFTSectionInfoTitle {
  const PropertiesTitle({super.key});

  @override
  String get iconPath => QPPImages.desktop_icon_commodity_nft_properties;

  @override
  String get title => 'Properties';
}

class PropertiesContent extends NFTSectionInfoContent<List> {
  const PropertiesContent(
      {super.key, required super.isDesktop, required super.data});

  @override
  Widget get child => GridView.builder(
      padding: listPadding,
      // 關掉 over scroll 效果
      physics: const BouncingScrollPhysics(),
      // 方向
      scrollDirection: Axis.vertical,
      // 是否根據 child 組件調整大小, 參考 https://juejin.cn/s/flutter%20gridview%20shrinkwrap
      shrinkWrap: true,
      itemCount: data.length,
      // grid 實現的規則
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          // child 間距
          crossAxisSpacing: 12,
          // child 間距
          mainAxisSpacing: 12,
          // child 高寬比
          childAspectRatio: 1.85,
          // child 最大寬度
          maxCrossAxisExtent: 215),
      itemBuilder: (context, count) {
        return ItemProperty(property: data[count]);
      });
}

/// property 元件
class ItemProperty extends StatelessWidget {
  final NFTTrait property;
  const ItemProperty({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: QppColors.stPatricksBlue,
        border: Border.all(
          color: QppColors.darkPastelBlue,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            property.traitType,
            style: QppTextStyles.web_16pt_body_platinum_L,
          ),
          Text(
            property.value,
            style: QppTextStyles.web_16pt_body_platinum_L,
          )
        ],
      ),
    );
  }
}
