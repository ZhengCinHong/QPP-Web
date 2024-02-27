import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qpp_example/extension/string/text.dart';
import 'package:qpp_example/page/news_feed/view/item_news_content.dart';
import 'package:qpp_example/page/news_feed/view/item_news_feed_footer.dart';
import 'package:qpp_example/page/news_feed/view/item_news_feed_header.dart';
import 'package:qpp_example/utils/qpp_color.dart';
import 'package:qpp_example/utils/qpp_image.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';

Widget testItemNewsFeed(BuildContext context, int index) {
  return ItemNews(
    index: index,
  );
}

class ItemNews extends StatelessWidget {
  final int index;
  const ItemNews({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: QppColors.prussianBlue,
      child: Column(children: [
        const SizedBox(
          height: 12,
        ),
        const ItemNewsHeader(),
        const SizedBox(
          height: 12,
        ),
        ItemNewsContent(data: getContent(index)),
        const SizedBox(
          height: 12,
        ),
        const ItemNewsFooter(),
        const SizedBox(
          height: 16,
        ),
      ]),
    );
  }
}

/// 測試物件
TestNewsContentData getContent(int index) {
  switch (index % 4) {
    case 0:
      return TestNewsContentData.create(0);
    case 1:
      return TestNewsContentData.create(1);
    case 2:
      return TestNewsContentData.create(2);
    default:
      return TestNewsContentData.create(3);
  }
}

class TestNewsContentData {
  final String content;
  final List<String> imgList;
  TestNewsContentData(this.content, this.imgList);

  factory TestNewsContentData.create(index) {
    return switch (index) {
      // 文字 多
      0 => TestNewsContentData(
          '恭喜 貝爾蓋茲 在星城獲得了大獎！獲得 88,888,888 遊戲幣！恭喜 貝爾蓋茲 在星城獲得了大獎！獲得 88,888,888 遊戲幣！恭喜 貝爾蓋茲 在星城獲得了大獎！獲得 88,888,888 遊戲幣！恭喜 貝爾蓋茲 在星城獲得了大獎！獲得 88,888,888 遊戲幣！恭喜 貝爾蓋茲 在星城獲得了大獎！獲得 88,888,888 遊戲幣！恭喜 貝爾蓋茲 在星城獲得了大獎！獲得 88,888,888 遊戲幣！恭喜 貝爾蓋茲 在星城獲得了大獎！獲得 88,888,888 遊戲幣！恭喜 貝爾蓋茲 在星城獲得了大獎！獲得 88,888,888 遊戲幣！恭喜 貝爾蓋茲 在星城獲得了大獎！獲得 88,888,888 遊戲幣！恭喜 貝爾蓋茲 在星城獲得了大獎！獲得 88,888,888 遊戲幣！恭喜 貝爾蓋茲 在星城獲得了大獎！獲得 88,888,888 遊戲幣！恭喜 貝爾蓋茲 在星城獲得了大獎！獲得 88,888,888 遊戲幣！恭喜 貝爾蓋茲 在星城獲得了大獎！獲得 88,888,888 遊戲幣！恭喜 貝爾蓋茲 在星城獲得了大獎！獲得 88,888,888 遊戲幣！恭喜 貝爾蓋茲 在星城獲得了大獎！獲得 88,888,888 遊戲幣！',
          []),
      // 文字 少
      1 => TestNewsContentData('恭喜 貝爾蓋茲 在星城獲得了大獎！獲得 88,888,888 遊戲幣！', []),
      // 文字 多 + 圖
      2 => TestNewsContentData(
            '又獲得了一場Super Win! 星城online我大概玩了二個多月，現在等級312，目前總共花了不到新台幣5000元，目前還剩下星幣約800,000，好遊戲真心推薦！又獲得了一場Super Win! 星城online我大概玩了二個多月，現在等級312，目前總共花了不到新台幣5000元，目前還剩下星幣約800,000，好遊戲真心推薦！星城online我大概玩了二個多月，現在等級312，又獲得了一場Super Win! 星城online我大概玩了二個多月，現在等級312，目前總共花了不到新台幣5000元，目前還剩下星幣約800,000，好遊戲真心推薦！又獲得了一場Super Win! 星城online我大概玩了二個多月，現在等級312，目前總共花了不到新台幣5000元，目前還剩下星幣約800,000，好遊戲真心推薦！又獲得了一場Super Win! 星城online我大概玩了二個多月，現在等級312，目前總共花了不到新台幣5000元，目前還剩下星幣約800,000，好遊戲真心推薦！',
            [
              'https://firebasestorage.googleapis.com/v0/b/qppwebdev.appspot.com/o/test1.jpg?alt=media&token=755ec8a4-4d50-45e4-90f9-8058233dbda1'
            ]),
      // 文字 少 + 圖
      _ => TestNewsContentData(
            '恭喜 All-in King 在星城獲得了大獎！獲得 88,888,888 遊戲幣！恭喜 All-in King 在星城獲得了大獎！',
            [
              'https://firebasestorage.googleapis.com/v0/b/qppwebdev.appspot.com/o/test3.jpg?alt=media&token=4cdcbeb3-243b-43c2-a51d-c05d538670e5'
            ]),
    };
  }
}

/// img link
/// https://drive.google.com/file/d/1WZPuoh9_P_urI_2W1xwqEOO1UnII-FVI/view?usp=share_link
