import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qpp_example/common_ui/qpp_app_bar/model/qpp_app_bar_model.dart';
import 'package:qpp_example/page/home/view_model/home_page_view_model.dart';

/// 是否顯示全螢幕選單Provider
final ChangeNotifierProvider<FullScreenMenuPageStateNotifier>
    fullScreenMenuPageStateProvider =
    ChangeNotifierProvider((ref) => FullScreenMenuPageStateNotifier());

/// 是否顯示全螢幕選單Notifier
class FullScreenMenuPageStateNotifier extends ChangeNotifier {
  FullScreenMenuPageStyle state = FullScreenMenuPageStyle.hide;

  /// 點擊觸發
  void tapToggle() {
    FullScreenMenuPageStyle? state;

    switch (this.state) {
      case FullScreenMenuPageStyle.show:
        state = FullScreenMenuPageStyle.animateToHidden;
        break;
      case FullScreenMenuPageStyle.hide:
        state = FullScreenMenuPageStyle.animateToShow;
        break;
      default:
        break;
    }

    if (state != null) {
      this.state = state;
      notifyListeners();
    }
  }

  /// 動畫完成
  void animationComplete() {
    FullScreenMenuPageStyle? state;

    switch (this.state) {
      case FullScreenMenuPageStyle.animateToHidden:
        state = FullScreenMenuPageStyle.hide;
        break;
      case FullScreenMenuPageStyle.animateToShow:
        state = FullScreenMenuPageStyle.show;
        break;
      default:
        break;
    }

    if (state != null) {
      this.state = state;
      notifyListeners();
    }
  }

  /// 重置
  void reset({bool isNotifyListeners = true}) {
    state = FullScreenMenuPageStyle.hide;

    if (isNotifyListeners) {
      notifyListeners();
    }
  }
}

/// 主頁選單
enum FullScreenMenuPageStyle {
  /// 隱藏
  hide,

  /// 顯示
  show,

  /// 開啟動畫
  animateToShow,

  /// 關閉動畫
  animateToHidden;

  /// 是否顯示
  bool get isSrcMenuVisible {
    return switch (this) {
      FullScreenMenuPageStyle.show ||
      FullScreenMenuPageStyle.animateToShow =>
        false,
      FullScreenMenuPageStyle.animateToHidden ||
      FullScreenMenuPageStyle.hide =>
        true,
    };
  }
}

/// 滑鼠狀態Notifier
class MouseRegionStateNotifier extends StateNotifier<PointerEvent> {
  MouseRegionStateNotifier() : super(const PointerExitEvent());

  void onEnter() {
    state = const PointerEnterEvent();
  }

  void onExit() {
    state = const PointerExitEvent();
  }
}

/// 滑動到context位置
final scrollToContextProvider = StateProvider<MainMenu?>((ref) => null);

/// 選擇主頁選單
void selectedMainMenu(
  MainMenu type, {
  required WidgetRef ref,
  required bool isDesktopPlatform,
}) {
  final scrollToContextNotifier = ref.read(scrollToContextProvider.notifier);
  final selectedIndexNotiifer = ref.watch(selectedIndexProvider.notifier);

  isDesktopPlatform
      ? scrollToContextNotifier.state = type
      : selectedIndexNotiifer.state = type.index;
}
