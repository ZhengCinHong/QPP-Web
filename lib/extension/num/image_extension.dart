import 'package:flutter/widgets.dart';

extension ImageExtension on num {

  /// 快取大小
  int cacheSize(BuildContext context) {
    return (this * MediaQuery.of(context).devicePixelRatio).round();
  }
}
