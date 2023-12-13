import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qpp_example/model/nft/nft_trait.dart';
import 'package:qpp_example/page/commodity_info/view/item_nft_section/nft_section.dart';
import 'package:qpp_example/utils/qpp_image.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';

class NFTSectionDate extends NFTSection {
  const NFTSectionDate.desktop({super.key, required super.data})
      : super.desktop();
  const NFTSectionDate.mobile({super.key, required super.data})
      : super.mobile();

  @override
  State<StatefulWidget> createState() => StateDate();
}

class StateDate extends StateSection {
  @override
  Widget get sectionContent => DateContent(dates: widget.data);

  @override
  String get sectionTitle => 'Date';

  @override
  String get sectionTitleIconPath => QPPImages.desktop_icon_commodity_nft_date;
}

class DateContent extends StatelessWidget {
  final List<NFTTrait> dates;
  const DateContent({super.key, required this.dates});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(60, 20, 60, 20),
      child: ListView.builder(
          itemCount: dates.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return ItemDate(date: dates[index]);
          }),
    );
  }
}

class ItemDate extends StatelessWidget {
  final NFTTrait date;
  const ItemDate({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
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
