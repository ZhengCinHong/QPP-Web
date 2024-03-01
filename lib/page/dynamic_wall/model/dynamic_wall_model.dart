import 'package:qpp_example/utils/qpp_image.dart';

/// 動態牆動作按鈕類型
enum DynamicWallActionButtonType {
  like,
  message,
  share;

  String get icon => switch (this) {
        like => QPPImages.mobile_icon_article_like_normal,
        message => QPPImages.mobile_icon_article_respond_normal,
        share => QPPImages.mobile_icon_article_share_normal,
      };

  String get pressedIcon => switch (this) {
        like => QPPImages.mobile_icon_article_like_pressed,
        message => QPPImages.mobile_icon_article_respond_pressed,
        share => QPPImages.mobile_icon_article_share_pressed,
      };
}

/// 動態牆Model
class DynamicWallModel {
  List<DynamicWallArticleModel> get articles => Iterable.generate(
        3,
        (index) => DynamicWallArticleModel(
          date: DateTime.now().toString(),
          name: index.toString(),
          content:
              "又獲得了一場Super Win! 星城online我大概玩了二個多月，現在等級312，目前總共花了不到新台幣5000元，目前還剩下星幣約800,000，好遊戲真心推薦！又獲得了一場Super Win! 星城online我大概玩了二個多月，現在等級312，目前總共花了不到新台幣5000元，目前還剩下星幣約800,000，好遊戲真心推薦！星城online我大概玩了二個多月，現在等級312，目前......",
          likes: index,
        ),
      ).toList();
}

/// 動態牆文章
class DynamicWallArticleModel {
  DynamicWallArticleModel({
    this.imagePath = "",
    required this.date,
    required this.name,
    required this.content,
    required this.likes,
  });

  String imagePath;
  String date;
  String name;
  String content;
  String contentImage = 'https://i.imgur.com/kLM9U2Z.jpeg';
  int likes = 100;
  List<DynamicWallResponseModel> get responses => Iterable.generate(
        10,
        ((index) => DynamicWallResponseModel(
            name: index.toString(),
            likes: index,
            msg: 'msg: $index',
            date: DateTime.now().toString())),
      ).toList();

  String getActionButtonContent({required DynamicWallActionButtonType type}) {
    return switch (type) {
      DynamicWallActionButtonType.like => likes.toString(),
      DynamicWallActionButtonType.message => responses.length.toString(),
      DynamicWallActionButtonType.share => '',
    };
  }
}

/// 動態牆回覆
class DynamicWallResponseModel {
  DynamicWallResponseModel({
    this.imagePath = "",
    required this.name,
    required this.msg,
    required this.likes,
    required this.date,
  });

  String imagePath;
  String name;
  String msg;
  int likes;
  String date;
}
