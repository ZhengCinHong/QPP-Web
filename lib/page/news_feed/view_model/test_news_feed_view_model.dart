import 'dart:math';

import 'package:flutter/material.dart';
import 'package:qpp_example/api/core/api_response.dart';

class TestNewsFeedModel extends ChangeNotifier {
  /// 測試動態牆資訊
  ApiResponse<int> newsFeedState = ApiResponse.initial();

  ///
  var itemCount = 0;

  refreshNewsFeed() {
    newsFeedState = ApiResponse.loading();
    notifyListeners();
    // 延遲 0.8 秒
    Future.delayed(const Duration(milliseconds: 800), () {
      // 隨機給數量
      int count = getRandom(5, 10);
      itemCount = count;
      print('data count: $itemCount');
      newsFeedState = ApiResponse.completed(count);
      notifyListeners();
    });
  }

  /// load news feed
  loadNewsFeed() {
    newsFeedState = ApiResponse.loading();
    notifyListeners();
    // 延遲 0.8 秒
    Future.delayed(const Duration(milliseconds: 800), () {
      // 隨機給數量
      int count = getRandom(5, 10);
      itemCount += count;
      print('data count: $itemCount');
      newsFeedState = ApiResponse.completed(count);
      notifyListeners();
    });

    notifyListeners();
  }

  loadMoreNewsFeed() {
    if (newsFeedState.isCompleted || newsFeedState.isError) {
      loadNewsFeed();
    }
  }

  /// 取得範圍隨機數
  int getRandom(int min, int max) {
    int result = min + Random().nextInt(max - min);
    return result;
  }
}
