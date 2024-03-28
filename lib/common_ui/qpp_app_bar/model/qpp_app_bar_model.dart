import 'package:flutter/material.dart';
import 'package:qpp_example/common_ui/qpp_menu/c_menu_anchor.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:qpp_example/utils/qpp_image.dart';

// 要滾動到位置的全局鍵
final GlobalKey introduceKey = GlobalKey();
final GlobalKey featureKey = GlobalKey();
final GlobalKey descriptionKey = GlobalKey();
final GlobalKey contactKey = GlobalKey();

/// 主頁選單
enum MainMenu {
  /// 介紹
  introduce,

  /// 特色
  feature,

  /// 說明
  description,

  /// 聯絡我們
  contact;

  String get text {
    return switch (this) {
      MainMenu.introduce => QppLocales.menuProductIntro,
      MainMenu.feature => QppLocales.menuProductFeature,
      MainMenu.description => QppLocales.menuUsageInstruction,
      MainMenu.contact => QppLocales.menuContactUS,
    };
  }

  BuildContext? get currentContext {
    return switch (this) {
      MainMenu.introduce => introduceKey.currentContext,
      MainMenu.feature => featureKey.currentContext,
      MainMenu.description => descriptionKey.currentContext,
      MainMenu.contact => contactKey.currentContext
    };
  }

  Key get key => Key(text);
}

/// AppBar用戶資訊
enum AppBarUserInfo implements CMeunAnchorData {
  /// 登出
  logout;

  @override
  String get title {
    return switch (this) { AppBarUserInfo.logout => QppLocales.alertLogout };
  }

  @override
  String? image(bool isHighlight) {
    return isHighlight
        ? QPPImages.mobile_icon_actionbar_list_logout_pressed
        : QPPImages.mobile_icon_actionbar_list_logout_normal;
  }
}
