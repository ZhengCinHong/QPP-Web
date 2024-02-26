import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qpp_example/common_ui/qpp_framework/qpp_main_framework.dart';
import 'package:qpp_example/constants/server_const.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:qpp_example/page/instructions/instructions_frame.dart';
import 'package:qpp_example/page/news_feed/view/test_news_feed_page.dart';
import 'package:qpp_example/page/nft_info_teach/nft_info_teach_main_frame.dart';
import 'package:qpp_example/universal_link/universal_link_data.dart';
import 'package:qpp_example/utils/display_url.dart';
import 'package:qpp_example/page/error_page/model/error_page_model.dart';
import 'package:qpp_example/page/user_information/view/user_information.dart'
    deferred as user_information_box;
import 'package:qpp_example/page/home/view/home_page.dart' deferred as home_box;
import 'package:qpp_example/page/commodity_info/view/commodity_info_body.dart'
    deferred as commodity_info_box;
import 'package:qpp_example/page/error_page/view/error_page.dart'
    deferred as error_box;
import 'package:qpp_example/page/nft_info_teach/nft_info_teach_scaffold.dart'
    deferred as nft_info_teach_box;
import 'package:qpp_example/page/instructions/instructions_page.dart'
    deferred as instructions_box;
import 'package:qpp_example/utils/qpp_color.dart';

/// QPP路由
class QppGoRouter {
  // -----------------------------------------------------------------------------
  // Home
  // -----------------------------------------------------------------------------
  /// 主頁
  static const String home = '/';

  /// 個人資訊頁
  static const String information = '/information';

  /// 物品資訊頁
  static const String commodityInfo = '/commodity_info';

  /// 物品出示頁
  static const String commodityWithToken = '/commodity_with_token';

  /// 跳轉頁
  static const String go = 'go';

  /// 隱私權政策頁(只有home有)
  static const String privacy = '/privacy';

  /// 使用者條款頁(只有home有)
  static const String term = '/term';

  /// nft教學頁(只有home有)
  static const String nftInfoTeach = '/nft_info_teach';

  // static const String membershipFetch = 'membership_fetch';

  // -----------------------------------------------------------------------------
  // App
  // -----------------------------------------------------------------------------
  /// 主頁
  static const String app = '/app';

  /// 個人資訊頁
  static const String appInformation = '$app$information';

  /// 物品資訊頁
  static const String appCommodityInfo = '$app$commodityInfo';

  /// 物品出示頁
  static const String appCommodityWithToken = '$app$commodityWithToken';

  /// 跳轉頁
  static const String appGo = '$app/$go';

  /// nft物品資訊頁(只有app有)
  static const String nftInfo = '$app/nft_info';

  /// 外部登入(只有app有)
  static const String vendorLogin = '$app/vendor_login';
  // 物品移轉
  static const String commodityRequest = '$app/commodity_request';
  static const String commodityRequestV2 = '$app/commodity_request_v2';

  /// 動態牆登入授權頁(只有app有)
  static const String loginAuth = 'login_auth';

  // static const String appMembershipFetch = '$app/$membershipFetch';

  /// 取語系參數
  static Locale get getLocaleFromPath {
    String lang = Uri.base.queryParameters['lang'] ?? "";
    if (lang.isNotEmpty && lang.contains('_')) {
      var keys = lang.split('_');
      // 檢查是否有支援
      Locale locale = Locale(keys[0], keys[1].toUpperCase());
      if (QppLocales.supportedLocales.contains(locale)) {
        debugPrint('Set Locale $lang');
        return locale;
      }
    }
    return const Locale('zh', 'TW');
  }

  /// 設定語系
  static void setLocale(BuildContext context) {
    Locale locale = getLocaleFromPath;
    // context 設定 locale
    context.setLocale(locale);
    // 更新網址列
    DisplayUrl.updateParam('lang', locale.toString());
  }

  // -----------------------------------------------------------------------------
  /// The route configuration.
  // -----------------------------------------------------------------------------
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        // 首頁
        path: home,
        name: home,
        builder: (context, state) {
          setLocale(context);
          return const Scaffold(
            backgroundColor: QppColors.oxfordBlue,
            body: TestNewsFeedPage(),
          );
          // MainFramework(
          //     libFuture: home_box.loadLibrary(),
          //     child: (context) {
          //       return home_box.HomePage();
          //     });
        },
      ),
      GoRoute(
        // 首頁 app path
        path: app,
        name: app,
        builder: (context, state) {
          setLocale(context);
          return MainFramework(
            libFuture: home_box.loadLibrary(),
            child: (context) {
              return home_box.HomePage();
            },
          );
        },
      ),
      GoRoute(
        // nft教學頁
        path: nftInfoTeach,
        name: nftInfoTeach,
        builder: (context, state) {
          setLocale(context);
          return NFTInfoTeachPageMainFrame(
              libFuture: nft_info_teach_box.loadLibrary(),
              routerState: state,
              child: (context) {
                return nft_info_teach_box.NFTInfoTeachScaffold(
                  state: state,
                );
              });
        },
      ),
      GoRoute(
        // 隱私權政策頁
        path: privacy,
        name: privacy,
        builder: (context, state) {
          setLocale(context);
          return InstructionsFrame(
            libFuture: instructions_box.loadLibrary(),
            child: (context) {
              return instructions_box.InstructionsPage.privacy();
            },
          );
        },
      ),
      GoRoute(
        // 使用者條款頁
        path: term,
        name: term,
        builder: (context, state) {
          setLocale(context);
          return InstructionsFrame(
            libFuture: instructions_box.loadLibrary(),
            child: (context) {
              return instructions_box.InstructionsPage.term();
            },
          );
        },
      ),
      // only app path
      GoRoute(
        path: vendorLogin,
        name: vendorLogin,
        builder: (context, state) {
          setLocale(context);
          return MainFramework(
            libFuture: error_box.loadLibrary(),
            child: (context) {
              return error_box.ErrorPage(
                type: ErrorPageType.troubleshootingInstructions,
                url: state.fullURL,
              );
            },
          );
        },
      ),
      // 物品移轉
      GoRoute(
        path: commodityRequest,
        name: commodityRequest,
        builder: (context, state) {
          setLocale(context);
          return MainFramework(
            libFuture: error_box.loadLibrary(),
            child: (context) {
              return error_box.ErrorPage(
                type: ErrorPageType.troubleshootingInstructions,
                url: state.fullURL,
              );
            },
          );
        },
      ),
      // 物品移轉
      GoRoute(
        path: commodityRequestV2,
        name: commodityRequestV2,
        builder: (context, state) {
          setLocale(context);
          return MainFramework(
            libFuture: error_box.loadLibrary(),
            child: (context) {
              return error_box.ErrorPage(
                type: ErrorPageType.troubleshootingInstructions,
                url: state.fullURL,
              );
            },
          );
        },
      ),
      // nft物品資訊頁(只有app有)
      GoRoute(
        path: nftInfo,
        name: nftInfo,
        builder: (context, state) {
          setLocale(context);
          return MainFramework(
            libFuture: commodity_info_box.loadLibrary(),
            child: (context) {
              return commodity_info_box.CommodityInfoPage(routerState: state);
            },
          );
        },
      ),
      // common path
      // 個人資訊頁
      GoRoute(
        path: information,
        name: information,
        builder: (context, state) {
          setLocale(context);
          final data =
              UniversalLinkParamData.fromJson(state.uri.queryParameters);
          return MainFramework(
            libFuture: user_information_box.loadLibrary(),
            child: (context) {
              return user_information_box.UserInformationOuterFrame(
                userID: data.phoneNumber ?? "",
                url: state.fullURL,
              );
            },
          );
        },
      ),
      // 物品資訊頁
      GoRoute(
        path: commodityInfo,
        name: commodityInfo,
        builder: (context, state) {
          setLocale(context);
          return MainFramework(
            libFuture: commodity_info_box.loadLibrary(),
            child: (context) {
              return commodity_info_box.CommodityInfoPage(routerState: state);
            },
          );
        },
      ),
      // 物品出示頁
      GoRoute(
        path: commodityWithToken,
        name: commodityWithToken,
        builder: (context, state) {
          setLocale(context);
          return MainFramework(
            libFuture: commodity_info_box.loadLibrary(),
            child: (context) =>
                commodity_info_box.CommodityInfoPage(routerState: state),
          );
        },
      ),
      // common with app path
      // 個人資訊頁 app path
      GoRoute(
        path: appInformation,
        name: appInformation,
        builder: (context, state) {
          setLocale(context);
          final data =
              UniversalLinkParamData.fromJson(state.uri.queryParameters);
          return MainFramework(
            libFuture: user_information_box.loadLibrary(),
            child: (context) {
              return user_information_box.UserInformationOuterFrame(
                userID: data.phoneNumber ?? "",
                url: state.fullURL,
              );
            },
          );
        },
      ),
      // 物品資訊頁 app path
      GoRoute(
        path: appCommodityInfo,
        name: appCommodityInfo,
        builder: (context, state) {
          setLocale(context);
          return MainFramework(
            libFuture: commodity_info_box.loadLibrary(),
            child: (context) {
              return commodity_info_box.CommodityInfoPage(routerState: state);
            },
          );
        },
      ),
      // 物品出示頁 app path
      GoRoute(
        path: appCommodityWithToken,
        name: appCommodityWithToken,
        builder: (context, state) {
          setLocale(context);
          return MainFramework(
            libFuture: commodity_info_box.loadLibrary(),
            child: (context) =>
                commodity_info_box.CommodityInfoPage(routerState: state),
          );
        },
      ),
    ],
    errorBuilder: (context, state) {
      // 錯誤頁面
      setLocale(context);
      return MainFramework(
        libFuture: error_box.loadLibrary(),
        child: (context) {
          return error_box.ErrorPage(
              type: ErrorPageType.urlIsWrong, url: state.fullURL);
        },
      );
    },
  );
}

extension GoRouterStateExtension on GoRouterState {
  /// 完整網址
  String get fullURL => ServerConst.routerHost + uri.toString();
}
