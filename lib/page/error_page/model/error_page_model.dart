import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qpp_example/localization/qpp_locales.dart';

enum ErrorPageType {
  /// 網址錯誤
  urlIsWrong,

  /// 故障(連動問題)排除說明
  troubleshootingInstructions;

  /// 手機平台按鈕上方字串
  String get mobileText {
    return switch (this) {
      ErrorPageType.urlIsWrong => QppLocales.errorPageOpenDownloadQpp,
      ErrorPageType.troubleshootingInstructions =>
        QppLocales.vendorLoginOpenDownloadQpp,
    };
  }

  /// 多語系內容字串
  String getContentTr(BuildContext context, bool isDesktopPlatform) {
    return switch (this) {
      ErrorPageType.urlIsWrong => context.tr(QppLocales.errorPageText1),
      ErrorPageType.troubleshootingInstructions =>
        '${context.tr(QppLocales.goTitle)}\n\n${context.tr(QppLocales.goText1)}\n\n${context.tr(QppLocales.goText2)}}\n\n${context.tr(isDesktopPlatform ? QppLocales.goText3Pc : QppLocales.goText3Mb)}',
    };
  }
}
