import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qpp_example/api/core/api_response.dart';
import 'package:qpp_example/page/news_feed/view/empty_news_feed.dart';
import 'package:qpp_example/page/news_feed/view/test_item_news_feed.dart';
import 'package:qpp_example/page/news_feed/view_model/test_news_feed_view_model.dart';

late ChangeNotifierProvider<TestNewsFeedModel> newsFeedProvider;

/// 測試用 動態牆
class TestNewsFeedPage extends StatefulWidget {
  const TestNewsFeedPage({super.key});

  @override
  StateTestNewsFeedPage createState() => StateTestNewsFeedPage();
}

class StateTestNewsFeedPage extends State {
  @override
  void initState() {
    super.initState();
    // model 初始化
    newsFeedProvider = ChangeNotifierProvider<TestNewsFeedModel>((ref) {
      // 開始取資料
      Future.microtask(() => ref.notifier.loadNewsFeed());
      return TestNewsFeedModel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return
        // 下拉刷新元件
        Consumer(
      builder: (context, ref, child) {
        // 狀態
        ApiResponse<int> newsFeedState =
            ref.watch(newsFeedProvider).newsFeedState;
        return EasyRefresh(
          onRefresh: _onRefresh,
          child: newsFeedState.isCompleted
              ? ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 8,
                      ),
                  itemCount: newsFeedState.data!,
                  itemBuilder: testItemNewsFeed)
              : const EmptyNewsFeed(),
        );
      },
    );
  }
}

Future<void> _onRefresh() async {
  print('>>> onRefresh');
  await Future.delayed(const Duration(microseconds: 200));
}
