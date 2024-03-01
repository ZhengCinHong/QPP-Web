import 'package:flutter/material.dart';
import 'package:qpp_example/page/dynamic_wall/model/dynamic_wall_model.dart';
import 'package:qpp_example/page/dynamic_wall/view/dynamic_wall_article.dart';
import 'package:qpp_example/page/dynamic_wall/view/dynamic_wall_response.dart';
import 'package:qpp_example/page/dynamic_wall/view/dynamic_wall_search_bar.dart';
import 'package:qpp_example/utils/qpp_color.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';
import 'package:qpp_example/utils/screen.dart';
import 'package:qpp_example/utils/shared_prefs_utils.dart';

// 動態牆文章框架
class DynamicWallArticleFrameWork extends StatelessWidget {
  const DynamicWallArticleFrameWork({super.key, required this.aritcle});

  final DynamicWallArticleModel aritcle;

  @override
  Widget build(BuildContext context) {
    final width =
        1024.getRealWidth(screenWidth: MediaQuery.of(context).size.width);

    final loginInfo = SharedPrefs.getLoginInfo();

    // 其他項目數量
    const otherItemCount = 3;

    final responses = aritcle.responses;

    final total = aritcle.responses.length + otherItemCount;

    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 35),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: QppColors.oxfordBlue,
      ),
      child: ListView.separated(
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            color: QppColors.midnightBlue,
          );
        },
        shrinkWrap: true,
        itemCount: total,
        itemBuilder: (context, index) {
          final last = total - 1;

          switch (index) {
            case 0:
              return DynamicWallArticle(aritcle: aritcle);
            case 1:
              return const Text(
                '查看之前的留言', // TODO: - 未使用多語系
                style: QppTextStyles.web_16pt_title_maya_blue_L,
              );
            default:
              if (index == last) {
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 23),
                  height: 92,
                  child: Row(
                    children: [
                      Expanded(
                        child: UserInputBox(
                          imageSize: 44,
                          imagePath: loginInfo?.uidImage ?? "",
                          hintText: '留言......', // TODO: - 未使用多語系
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 32,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: QppColors.babyBlueEyes,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return DynamicWallResponse(response: responses[index - 2]);
              }
          }
        },
      ),
    );
  }
}
