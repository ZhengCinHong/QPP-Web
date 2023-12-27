import 'package:flutter/material.dart';
import 'package:qpp_example/page/home/view/home_page_contact.dart';
import 'package:qpp_example/page/home/view/home_page_description.dart';
import 'package:qpp_example/page/home/view/home_page_feature.dart';
import 'package:qpp_example/page/home/view/home_page_footer.dart';
import 'package:qpp_example/page/home/view/home_page_introduce.dart';

// 要滾動到位置的全局鍵
final GlobalKey introduceKey = GlobalKey();
final GlobalKey featureKey = GlobalKey();
final GlobalKey descriptionKey = GlobalKey();
final GlobalKey contactKey = GlobalKey();

/// 首頁
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: 5,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return switch (index) {
            0 => HomePageIntroduce(key: introduceKey),
            1 => HomePageFeature(key: featureKey),
            2 => HomePageDescription(key: descriptionKey),
            3 => HomePageContact(key: contactKey),
            4 => const HomePageFooter(),
            _ => const SizedBox.shrink(),
          };
        },
      ),
    );
  }
}
