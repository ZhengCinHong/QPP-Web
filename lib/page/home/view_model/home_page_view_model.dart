import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qpp_example/page/home/model/home_page_model.dart';

// -----------------------------------------------------------------------------
/// TabBar
// -----------------------------------------------------------------------------

/// 選擇的index
final selectedIndexProvider = StateProvider<int>((ref) => 0);

// -----------------------------------------------------------------------------
/// 產品特色
// -----------------------------------------------------------------------------

/// Highlight類型
final highlightFeatureTypeProvider =
    StateProvider<HomePageFeatureInfoType?>((ref) => null);

// -----------------------------------------------------------------------------
/// 產品說明
// -----------------------------------------------------------------------------

/// 是否懸停在哪個類型上
final hoveredTypeProvider =
    StateProvider<HomePageDescriptionType?>((ref) => null);
