import 'package:flutter/material.dart';
import 'package:qpp_example/extension/string/text.dart';
import 'package:qpp_example/utils/qpp_image.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';

/// 物件上方
class ItemNewsHeader extends StatelessWidget {
  final int index;
  const ItemNewsHeader({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 16,
        ),
        NewsUserImg(),
        const SizedBox(
          width: 12,
        ),
        NewsUserNamePostInfo(
          index: index,
        ),
        const Spacer(),
        NewsBtnMore(),
        const SizedBox(
          width: 16,
        ),
      ],
    );
  }
}

/// 用戶圖片
class NewsUserImg extends StatelessWidget {
  final String? path;

  const NewsUserImg({super.key, this.path});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 36,
      height: 36,
      clipBehavior: Clip.antiAlias,
      // decoration 負責切形狀
      decoration: const BoxDecoration(shape: BoxShape.circle),
      // 只用 Container 切圓會溢出, 這邊加上 ClipOval 強制把圖片切圓
      // mobile_pic_avatar_default_normal
      child: _userImg(path),
    );
  }
}

Widget _userImg(String? path) {
  if (path.isNullOrEmpty) {
    return Image.asset(
      QPPImages.mobile_pic_avatar_default_normal,
      fit: BoxFit.cover,
    );
  }
  // TODO: 錯誤處理需要在 model 做完
  return Image.network(
    path!,
    filterQuality: FilterQuality.high,
    fit: BoxFit.cover,
  );
}

/// 用戶名稱, post date, 觀看權限
class NewsUserNamePostInfo extends StatelessWidget {
  final int index;
  const NewsUserNamePostInfo({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'User $index',
          style: QppTextStyles.mobile_14pt_body_linktext_L,
        ),
        const SizedBox(
          height: 2,
        ),
        // post date, 觀看權限
        Row(
          children: [
            const Text('2024/02/26・',
                style: QppTextStyles.mobile_12pt_body_category_text_L),
            Image.asset(
              QPPImages.mobile_icon_newsfeed_article_public,
              width: 12,
              height: 12,
            ),
          ],
        ),
      ],
    );
  }
}

class NewsBtnMore extends StatefulWidget {
  const NewsBtnMore({super.key});

  @override
  StateNewsBtnMore createState() => StateNewsBtnMore();
}

class StateNewsBtnMore extends State {
  final String normalPath = QPPImages.mobile_icon_article_function_normal;
  final String onPressedPath = QPPImages.mobile_icon_article_function_pressed;
  late String path;
  @override
  void initState() {
    super.initState();
    path = normalPath;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 28,
      height: 28,
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          setState(() {
            path = path == normalPath ? onPressedPath : normalPath;
          });
        },
        icon: Image.asset(
          path,
        ),
      ),
    );
  }
}
