import 'package:flutter/material.dart';
import 'package:qpp_example/utils/qpp_image.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';

/// 物件下方
class ItemNewsFooter extends StatelessWidget {
  const ItemNewsFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 16,
        ),
        NewsLikeBtn(),
        SizedBox(
          width: 5,
        ),
        LikeCount(),
        SizedBox(
          width: 20,
        ),
        NewsMsgBtn(),
        SizedBox(
          width: 5,
        ),
        NewsMsgCount(),
        SizedBox(
          width: 20,
        ),
        NewsShareBtn(),
      ],
    );
  }
}

/// like btn
class NewsLikeBtn extends StatefulWidget {
  const NewsLikeBtn({super.key});

  @override
  StateNewsLikeBtn createState() => StateNewsLikeBtn();
}

class StateNewsLikeBtn extends State {
  final String normalPath = QPPImages.mobile_icon_article_like_normal;
  final String likePath = QPPImages.mobile_icon_article_like_pressed;
  late String path;

  @override
  void initState() {
    super.initState();
    // TODO: 判斷是否 like
    path = normalPath;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          setState(() {
            path = path == normalPath ? likePath : normalPath;
          });
        },
        icon: Image.asset(
          path,
        ),
      ),
    );
  }
}

/// like count
class LikeCount extends StatelessWidget {
  const LikeCount({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      '100',
      style: QppTextStyles.mobile_14pt_body_category_text_L,
    );
  }
}

/// msg icon
class NewsMsgBtn extends StatelessWidget {
  const NewsMsgBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          // TODO: 點擊訊息 btn
        },
        icon: Image.asset(QPPImages.mobile_icon_article_respond_normal),
      ),
    );
  }
}

/// msg count
class NewsMsgCount extends StatelessWidget {
  const NewsMsgCount({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      '100',
      style: QppTextStyles.mobile_14pt_body_category_text_L,
    );
  }
}

/// share btn
class NewsShareBtn extends StatelessWidget {
  const NewsShareBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: () {},
        icon: Image.asset(QPPImages.mobile_icon_article_share_normal),
      ),
    );
  }
}
