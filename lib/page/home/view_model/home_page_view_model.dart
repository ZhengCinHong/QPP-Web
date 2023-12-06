// -----------------------------------------------------------------------------
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qpp_example/page/home/model/home_page_model.dart';

/// 產品特色
// -----------------------------------------------------------------------------

/// Highlight類型
final highlightFeatureTypeProvider =
    StateProvider<HomePageFeatureInfoType?>((ref) => null);