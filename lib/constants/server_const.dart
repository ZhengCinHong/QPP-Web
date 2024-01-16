import 'package:qpp_example/main.dart';

// kReleaseMode 若在 release -> true / 若在 debug & profile -> false
// server 常數放置
class ServerConst {
  /// TODO: 先改成目前站點
  // static const routerHost = "https://qpptec.com";
  // static const routerHost = "https://webside-dev.qpptec.com";
  static final routerHost = Setting().baseHref;

  /// 測試用連結
  // static final testRouterHost = "${Setting().baseHref}/";

  /// 依照裝置跳轉Google Play Store or Apple App Store
  static const appStoreUrl = 'https://qpptec.com/app/go';

  /// Google Play Store Url
  static const googlePlayStoreUrl =
      'https://play.google.com/store/apps/details?id=com.qpptec.QPP';

  /// Apple App Store Url
  static const appleStoreUrl = 'https://apps.apple.com/tw/app/qpp/id1501319938';

  /// 隱私權網址
  static final privacyPolicyUrl = "$routerHost/privacy";

  /// 使用條款網址
  static final termsOfUseUrl =
      "$routerHost/term"; // "${routerHost}term?lang=%s";

  /// 信箱顯示字串
  static const mailStr = 'info@qpptec.com';

  /// 信箱
  static const mailUrl = 'mailto:$mailStr';

  /// AppLink url
  static const appLinkUrl = "https://qpptec.com/app/";

  /// Storage api 位址 正式 / 測試
  static final storage = Setting().isTest
      ? "https://storage.googleapis.com/qpp_blockchain_test/"
      : "https://storage.googleapis.com/qpp_blockchain/";

  /// Client API- 正式 / 測試
  static final clientApiUrl = Setting().isTest
      ? "https://dev2-api.qpptec.com/client/"
      : "https://pro2-api.qpptec.com/client/";

  /// local api, 正式 拿掉 stage
  static final localApiUrl = Setting().isTest
      ? "https://stage.qpptec.com/api/"
      : "https://qpptec.com/api/";
}
