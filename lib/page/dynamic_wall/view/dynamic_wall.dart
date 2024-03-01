import 'package:flutter/material.dart';
import 'package:qpp_example/page/dynamic_wall/model/dynamic_wall_model.dart';
import 'package:qpp_example/page/dynamic_wall/view/dynamic_wall_article_framework.dart';
import 'package:qpp_example/page/dynamic_wall/view/dynamic_wall_search_bar.dart';

/// 動態牆
class DynamicWall extends StatelessWidget {
  const DynamicWall({super.key});

  @override
  Widget build(context) {
    // 其他項目數量
    const otherItemCount = 1;

    final data = DynamicWallModel();
    final aritcles = data.articles;

    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: ListView.builder(
        itemCount: aritcles.length + otherItemCount,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.only(bottom: 24),
            alignment: Alignment.center,
            child: switch (index) {
              0 => const DynamicWallSearchBar(),
              _ => DynamicWallArticleFrameWork(
                  aritcle: aritcles[index - otherItemCount],
                ),
            },
          );
        },
      ),
    );
  }
}
