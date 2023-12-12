import 'package:flutter/material.dart';
import 'package:qpp_example/model/nft/nft_trait.dart';
import 'package:qpp_example/page/commodity_info/view/item_nft_section/nft_section.dart';
import 'package:qpp_example/utils/qpp_color.dart';
import 'package:qpp_example/utils/qpp_image.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';

/// properties section
class NFTSectionProperties<List> extends NFTSection {
  const NFTSectionProperties({super.key, required super.data});

  @override
  State<StatefulWidget> createState() => StateProperties();
}

class StateProperties extends StateSection {
  @override
  Widget get sectionContent => PropertiesContent(properties: widget.data);

  @override
  String get sectionTitle => 'Properties';

  @override
  String get sectionTitleIconPath =>
      QPPImages.desktop_icon_commodity_nft_properties;
}

class PropertiesContent extends StatelessWidget {
  final List<NFTTrait> properties;
  const PropertiesContent({super.key, required this.properties});

  @override
  Widget build(BuildContext context) {
    return PropertiesGrid(properties: properties);
  }
}

class PropertiesGrid extends StatelessWidget {
  final List<NFTTrait> properties;
  const PropertiesGrid({super.key, required this.properties});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(60, 20, 60, 20),
      child: GridView.builder(
          // 方向
          scrollDirection: Axis.vertical,
          // 是否根據 child 組件調整大小, 參考 https://juejin.cn/s/flutter%20gridview%20shrinkwrap
          shrinkWrap: true,
          itemCount: properties.length,
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
            return ItemProperty(property: properties[count]);
          }),
    );
  }
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
