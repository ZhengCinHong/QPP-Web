import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:qpp_example/page/nft_info_teach/nft_teach_section.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';

class NFTTeachInfoZone1 extends StatelessWidget {
  const NFTTeachInfoZone1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.tr(QppLocales.nftInfoTeachSubtitle1),
          style: QppTextStyles.web_24pt_title_L_maya_blue_C,
        ),
        const TeachInfoZone1Section1.desktop(
          child: Column(
            children: [
              Text('data'),
              Text('data'),
              Text('data'),
              Text('data'),
              Text('data'),
            ],
          ),
        )
      ],
    );
  }
}

class TeachInfoZone1Section1 extends NFTTeachSection {
  const TeachInfoZone1Section1.desktop({super.key, required super.child})
      : super.desktop();
  const TeachInfoZone1Section1.mobile({super.key, required super.child})
      : super.mobile();

  @override
  State<StatefulWidget> createState() => InfoZone1Section1State();
}

class InfoZone1Section1State extends StateTeachSection {
  @override
  String get sectionTitle => '123';
}
