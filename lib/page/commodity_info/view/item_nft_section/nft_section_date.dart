import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qpp_example/model/nft/nft_trait.dart';
import 'package:qpp_example/page/commodity_info/view/item_nft_section/nft_section.dart';
import 'package:qpp_example/utils/qpp_image.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';

class DateExpand extends NFTExpand<List> {
  // final List<NFTTrait> data;
  const DateExpand.desktop({super.key, required super.data}) : super.desktop();
  const DateExpand.mobile({super.key, required super.data}) : super.mobile();

  @override
  Widget? get title => const DateTitle();

  @override
  Widget? get content => DateContent(isDesktop: isDesktop, data: data);
}

class DateTitle extends NFTSectionInfoTitle {
  const DateTitle({super.key});

  @override
  String get title => 'Date';

  @override
  String get iconPath => QPPImages.desktop_icon_commodity_nft_date;
}

class DateContent extends NFTSectionInfoContent<List> {
  const DateContent({super.key, required super.isDesktop, required super.data});

  @override
  Widget get child => ListView.builder(
      padding: listPadding,
      // 關掉 over scroll 效果
      // physics: const BouncingScrollPhysics(),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: data.length,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      prototypeItem: ItemDate(date: data[0]),
      itemBuilder: (context, index) {
        return ItemDate(date: data[index]);
      });
}

class ItemDate extends StatelessWidget {
  final NFTTrait date;
  const ItemDate({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 6, bottom: 6),
      child: Text(
        displayDate,
        style: QppTextStyles.web_16pt_body_platinum_L,
      ),
    );
  }

  String get displayDate {
    var timeStamp = int.parse(date.value);
    var duration = Duration(seconds: timeStamp);
    var dt = DateTime.fromMillisecondsSinceEpoch(duration.inMilliseconds);
    var dtString = DateFormat('yyyy/MM/dd').format(dt).toString();
    return '${date.traitType} $dtString';
  }
}
