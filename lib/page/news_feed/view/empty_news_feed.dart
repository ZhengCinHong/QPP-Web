import 'package:flutter/material.dart';
import 'package:qpp_example/utils/qpp_image.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';

class EmptyNewsFeed extends StatelessWidget {
  const EmptyNewsFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: double.infinity,
      width: double.infinity,
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        child: Column(
          children: [
            Image.asset(QPPImages.pic_empty_default),
            const SizedBox(
              height: 20,
            ),
            const Text(
              '尚無動態牆紀錄',
              style: QppTextStyles.mobile_16pt_title_pastel_blue,
            ),
          ],
        ),
      ),
    );
  }
}
