import 'dart:math';

import 'package:flutter/material.dart';
import 'package:qpp_example/api/core/api_response.dart';

class TestNewsFeedModel extends ChangeNotifier {
  /// 測試動態牆資訊
  ApiResponse<int> newsFeedState = ApiResponse.initial();

  /// load news feed
  loadNewsFeed() {
    newsFeedState = ApiResponse.loading();
    notifyListeners();
    // 延遲 0.8 秒
    Future.delayed(const Duration(milliseconds: 800), () {
      // 隨機給數量
      int count = getRandom(15, 50);
      newsFeedState = ApiResponse.completed(count);
      notifyListeners();
    });

    notifyListeners();
  }

  int getRandom(int min, int max) {
    int result = min + Random().nextInt(max - min);
    return result;
  }
}
