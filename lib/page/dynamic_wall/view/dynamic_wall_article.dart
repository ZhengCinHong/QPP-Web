import 'package:flutter/material.dart';
import 'package:qpp_example/common_ui/qpp_action_button/qpp_action_button.dart';
import 'package:qpp_example/page/dynamic_wall/model/dynamic_wall_model.dart';
import 'package:qpp_example/utils/qpp_image.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';

/// 動態牆文章
class DynamicWallArticle extends StatelessWidget {
  const DynamicWallArticle({super.key, required this.aritcle});

  final DynamicWallArticleModel aritcle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 文章用戶
        AritcleUser(aritcle: aritcle),
        // 文章內容
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            aritcle.content,
            style: QppTextStyles.mobile_16pt_title_pastel_blue,
          ),
        ),
        // 文章內容圖片
        Image.network(aritcle.contentImage),
        // 動作按鈕
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Wrap(
            spacing: 20,
            children: DynamicWallActionButtonType.values
                .map(
                  (e) => ActionButton(
                    icon: e.icon,
                    content: aritcle.getActionButtonContent(type: e),
                  ),
                )
                .toList(),
          ),
        )
      ],
    );
  }
}

/// 文章用戶
class AritcleUser extends StatelessWidget {
  const AritcleUser({super.key, required this.aritcle});

  final DynamicWallArticleModel aritcle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // 用戶頭像
        ClipOval(
          child: Image.network(
            aritcle.imagePath,
            width: 52,
            errorBuilder: (context, error, stackTrace) => Image.asset(
              QPPImages.mobile_pic_avatar_default_normal,
              width: 52,
            ),
          ),
        ),
        // 間距
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 名稱
            Text(
              aritcle.name,
              style: QppTextStyles.mobile_16pt_title_pastel_blue,
            ),
            // 間距
            const SizedBox(height: 6),
            // Date
            Row(
              children: [
                Text(
                  aritcle.date,
                  style: QppTextStyles.mobile_14pt_body_category_text_L,
                ),
                const SizedBox(width: 6),
                Image.asset(QPPImages.mobile_icon_newsfeed_article_public),
              ],
            )
          ],
        )
      ],
    );
  }
}
