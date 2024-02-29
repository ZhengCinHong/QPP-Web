import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qpp_example/api/core/api_response.dart';
import 'package:qpp_example/page/news_feed/view/empty_news_feed.dart';
import 'package:qpp_example/page/news_feed/view/test_item_news_feed.dart';
import 'package:qpp_example/page/news_feed/view_model/test_news_feed_view_model.dart';

/// 資料 provider
late ChangeNotifierProvider<TestNewsFeedModel> newsFeedProvider;

/// 測試用 動態牆
class TestNewsFeedPage extends StatefulWidget {
  const TestNewsFeedPage({super.key});

  @override
  StateTestNewsFeedPage createState() => StateTestNewsFeedPage();
}

class StateTestNewsFeedPage extends State {
  // 下拉刷新控制
  late EasyRefreshController _easyRefreshController;
  // 加載更多控制
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // 下拉刷新用
    _easyRefreshController = EasyRefreshController(
        controlFinishLoad: false, controlFinishRefresh: true);
    // model 初始化
    newsFeedProvider = ChangeNotifierProvider<TestNewsFeedModel>((ref) {
      // 開始取資料
      Future.microtask(() => ref.notifier.loadNewsFeed());
      return TestNewsFeedModel();
    });
  }

  @override
  Widget build(BuildContext context) {
    print('list build');
    return
        // 下拉刷新元件
        Consumer(
      builder: (context, ref, child) {
        // 狀態
        ApiResponse<int> newsFeedState =
            ref.watch(newsFeedProvider).newsFeedState;

        Future<void> onRefresh() async {
          print('>>> onRefresh');
          Future.microtask(() => ref.read(newsFeedProvider).refreshNewsFeed());
          if (newsFeedState.isCompleted) {
            // 刷新完成, 隱藏 icon
            _easyRefreshController.finishRefresh(IndicatorResult.success);
          }
        }

        Future<void> loadMore() async {
          print('>>> onLoad');
          Future.microtask(() => ref.read(newsFeedProvider).loadMoreNewsFeed());
        }

        // 加載更多用
        _scrollController.addListener(() {
          /// _scrollController.position.pixels 是当前像素点位置
          /// _scrollController.position.maxScrollExtent 当前列表最大可滚动位置
          /// 如果二者相等 , 那么就触发上拉加载更多机制
          if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent) {
            /// 触发上拉加载更多机制
            loadMore();
          }
        });

        return EasyRefresh(
          header: ClassicHeader(
            showText: false,
            pullIconBuilder: (context, state, animation) {
              // 自訂圓形進度條
              return const SizedBox(
                  width: 25, height: 25, child: CircularProgressIndicator());
            },
          ),
          footer: const NotLoadFooter(maxOverOffset: 0),
          controller: _easyRefreshController,
          onLoad: () async {
            _easyRefreshController.finishLoad();
          },
          onRefresh: onRefresh,
          child:
              // newsFeedState.isCompleted
              //     ?
              ListView.separated(
                  controller: _scrollController,
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 8,
                      ),
                  itemCount: ref.watch(newsFeedProvider).itemCount,
                  // newsFeedState.data!,
                  itemBuilder: testItemNewsFeed),
          // : const EmptyNewsFeed(),
        );
      },
    );
  }
}
