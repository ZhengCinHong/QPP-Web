import 'package:flutter/material.dart';
import 'package:qpp_example/utils/qpp_color.dart';
import 'package:qpp_example/utils/qpp_image.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';
import 'package:qpp_example/utils/screen.dart';
import 'package:qpp_example/utils/shared_prefs_utils.dart';

/// 動態牆搜尋欄
class DynamicWallSearchBar extends StatelessWidget {
  const DynamicWallSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final width =
        1024.getRealWidth(screenWidth: MediaQuery.of(context).size.width);

    final loginInfo = SharedPrefs.getLoginInfo();

    return Container(
        width: width,
        padding: const EdgeInsets.symmetric(vertical: 34, horizontal: 36),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: QppColors.oxfordBlue,
        ),
        child: UserInputBox(
          imageSize: 52,
          imagePath: loginInfo?.uidImage ?? "",
          hintText: '想說些什麼？......', // TODO: - 未使用多語系
        ));
  }
}

/// 用戶輸入框
class UserInputBox extends StatelessWidget {
  const UserInputBox({
    super.key,
    required this.imagePath,
    required this.hintText,
    required this.imageSize,
  });

  final String imagePath;
  final String hintText;
  final double imageSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // 用戶頭像
        ClipOval(
          child: Image.network(
            imagePath,
            width: imageSize,
            errorBuilder: (context, error, stackTrace) => Image.asset(
              QPPImages.mobile_pic_avatar_default_normal,
              width: imageSize,
            ),
          ),
        ),
        // 間距
        const SizedBox(width: 16),
        // 輸入框
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              color: QppColors.prussianBlue,
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: QppTextStyles.mobile_16pt_title_pastel_blue,
                border: InputBorder.none,
              ),
            ),
          ),
        )
      ],
    );
  }
}
