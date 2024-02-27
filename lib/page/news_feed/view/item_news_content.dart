import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qpp_example/common_ui/qpp_text/read_more_text.dart';
import 'package:qpp_example/extension/string/url.dart';
import 'package:qpp_example/page/news_feed/view/test_item_news_feed.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';

class ItemNewsContent extends StatelessWidget {
  final TestNewsContentData data;
  const ItemNewsContent({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: (data.imgList.isNotEmpty)
          ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              NewsContentText(content: data.content),
              const SizedBox(
                height: 12,
              ),
              Image.network(data.imgList.first)
            ])
          : NewsContentText(content: data.content),
    );
  }
}

/// 文字內容
class NewsContentText extends StatelessWidget {
  final String content;
  const NewsContentText({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      content,
      textAlign: TextAlign.start,
      trimLines: 5,
      trimMode: TrimMode.Line,
      trimExpandedText: ' ',
      trimCollapsedText: context.tr('commodity_info_more'),
      style: QppTextStyles.mobile_14pt_body_platinum_L,
      moreStyle: QppTextStyles.web_16pt_body_category_text_L,
      linkTextStyle: QppTextStyles.web_16pt_body_linktext_L,
      onLinkPressed: (String url) {
        // 打開連結
        url.launchURL();
      },
    );
  }
}
