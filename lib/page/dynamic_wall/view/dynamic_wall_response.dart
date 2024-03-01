import 'package:flutter/material.dart';
import 'package:qpp_example/common_ui/qpp_action_button/qpp_action_button.dart';
import 'package:qpp_example/page/dynamic_wall/model/dynamic_wall_model.dart';
import 'package:qpp_example/utils/qpp_image.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';

/// 動態牆回覆
class DynamicWallResponse extends StatelessWidget {
  const DynamicWallResponse({super.key, required this.response});

  final DynamicWallResponseModel response;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 文章用戶
        ResponseUser(response: response),
        Padding(
          padding: const EdgeInsets.only(left: 60), // 60: 頭像加上間距寬度
          child: ReplyActionBar(response: response),
        ),
      ],
    );
  }
}

/// 回覆用戶
class ResponseUser extends StatelessWidget {
  const ResponseUser({super.key, required this.response});

  final DynamicWallResponseModel response;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // 用戶頭像
        ClipOval(
          child: Image.network(
            response.imagePath,
            width: 44,
            errorBuilder: (context, error, stackTrace) => Image.asset(
              QPPImages.mobile_pic_avatar_default_normal,
              width: 44,
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
              response.name,
              style: QppTextStyles.web_16pt_body_white_L,
            ),
            // 間距
            const SizedBox(height: 2),
            // 內容
            Text(
              response.msg,
              style: QppTextStyles.mobile_16pt_title_pastel_blue,
            ),
          ],
        )
      ],
    );
  }
}

/// 回覆操作欄
class ReplyActionBar extends StatelessWidget {
  const ReplyActionBar({super.key, required this.response});

  final DynamicWallResponseModel response;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // 點讚按鈕
        ActionButton(
          spacing: 2,
          iconSize: 20,
          icon: DynamicWallActionButtonType.like.icon,
          content: response.likes.toString(),
        ),
        // 回覆(文字)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GestureDetector(
            onTap: () => print('reply'),
            child: const Text(
              '回覆',
              style: QppTextStyles.mobile_14pt_body_pastel_blue_L,
            ), // TODO: - 未使用多語系
          ),
        ),
        // 回覆Icon(...)
        Image.asset(
          width: 20,
          QPPImages.mobile_icon_respond_function_normal,
        ),
        const Spacer(),
        // Date
        Text(
          response.date,
          style: QppTextStyles.mobile_14pt_body_category_text_R,
        )
      ],
    );
  }
}
