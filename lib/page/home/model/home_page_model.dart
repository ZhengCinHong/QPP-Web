import 'package:qpp_example/constants/server_const.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:qpp_example/utils/qpp_image.dart';
import 'package:qpp_example/utils/screen.dart';

// -----------------------------------------------------------------------------
/// 應用程式商店類型
// -----------------------------------------------------------------------------
enum PlayStoreType {
  google,
  apple;

  String get image {
    return switch (this) {
      PlayStoreType.google => QPPImages.desktop_pic_platform_googleplay,
      PlayStoreType.apple => QPPImages.desktop_pic_platform_appstore
    };
  }

  String get url {
    return switch (this) {
      PlayStoreType.google => ServerConst.googlePlayStoreUrl,
      PlayStoreType.apple => ServerConst.appleStoreUrl
    };
  }
}

// -----------------------------------------------------------------------------
/// 特色資訊類型
// -----------------------------------------------------------------------------
enum HomePageFeatureInfoType {
  /// 虛寶
  virtual,

  /// 身份識別
  identification,

  /// 票券
  voucher,

  /// 更多
  more;

  String get title {
    switch (this) {
      case HomePageFeatureInfoType.virtual:
        return QppLocales.homeSection2Item1Title;
      case HomePageFeatureInfoType.identification:
        return QppLocales.homeSection2Item2Title;
      case HomePageFeatureInfoType.voucher:
        return QppLocales.homeSection2Item3Title;
      case HomePageFeatureInfoType.more:
        return QppLocales.homeSection2Item4Title;
    }
  }

  String get directions {
    switch (this) {
      case HomePageFeatureInfoType.virtual:
        return QppLocales.homeSection2Item1P;
      case HomePageFeatureInfoType.identification:
        return QppLocales.homeSection2Item2P;
      case HomePageFeatureInfoType.voucher:
        return QppLocales.homeSection2Item3P;
      case HomePageFeatureInfoType.more:
        return QppLocales.homeSection2Item4P;
    }
  }

  String get image {
    switch (this) {
      case HomePageFeatureInfoType.virtual:
        return QPPImages.desktop_icon_area_01_01_normal;
      case HomePageFeatureInfoType.identification:
        return QPPImages.desktop_icon_area_01_02_nomal;
      case HomePageFeatureInfoType.voucher:
        return QPPImages.desktop_icon_area_01_03_normal;
      case HomePageFeatureInfoType.more:
        return QPPImages.desktop_icon_area_01_04_normal;
    }
  }

  String get highlightImage {
    switch (this) {
      case HomePageFeatureInfoType.virtual:
        return QPPImages.desktop_icon_area_01_01_pressed;
      case HomePageFeatureInfoType.identification:
        return QPPImages.desktop_icon_area_01_02_pressed;
      case HomePageFeatureInfoType.voucher:
        return QPPImages.desktop_icon_area_01_03_pressed;
      case HomePageFeatureInfoType.more:
        return QPPImages.desktop_icon_area_01_04_pressed;
    }
  }
}

// -----------------------------------------------------------------------------
/// 使用說明類型
// -----------------------------------------------------------------------------
enum HomePageDescriptionType {
  /// 手機
  phone,

  /// 通訊錄
  directory,

  /// 討論區
  forum;

  String get title {
    switch (this) {
      case HomePageDescriptionType.phone:
        return QppLocales.homeSection4Brik1Title;
      case HomePageDescriptionType.directory:
        return QppLocales.homeSection4Brik2Title;
      case HomePageDescriptionType.forum:
        return QppLocales.homeSection4Brik3Title;
    }
  }

  String get directions {
    switch (this) {
      case HomePageDescriptionType.phone:
        return QppLocales.homeSection4Brik1P;
      case HomePageDescriptionType.directory:
        return QppLocales.homeSection4Brik2P;
      case HomePageDescriptionType.forum:
        return QppLocales.homeSection4Brik3P;
    }
  }

  String image(ScreenStyle screenStyle) {
    final isDesktopStyle = screenStyle.isDesktop;

    switch (this) {
      case HomePageDescriptionType.phone:
        return  isDesktopStyle ? QPPImages.desktop_pic_area_02_01 : QPPImages.mobile_pic_area_02_01;
      case HomePageDescriptionType.directory:
        return isDesktopStyle ? QPPImages.desktop_pic_area_02_02 : QPPImages.mobile_pic_area_02_02;
      case HomePageDescriptionType.forum:
        return isDesktopStyle ? QPPImages.desktop_pic_area_02_03 : QPPImages.mobile_pic_area_02_03;
    }
  }

  /// 內容在右邊
  bool get conetntOfRight {
    switch (this) {
      case HomePageDescriptionType.phone || HomePageDescriptionType.forum:
        return true;
      case HomePageDescriptionType.directory:
        return false;
    }
  }
}

// -----------------------------------------------------------------------------
/// 聯絡我們類型
// -----------------------------------------------------------------------------
enum HomePageContactType {
  first,
  second,
  third;

  String get title {
    switch (this) {
      case HomePageContactType.first:
        return QppLocales.homeDigibagList1Name;
      case HomePageContactType.second:
        return QppLocales.homeDigibagList2Name;
      case HomePageContactType.third:
        return QppLocales.homeDigibagList3Name;
    }
  }

  String get directions {
    switch (this) {
      case HomePageContactType.first:
        return QppLocales.homeDigibagList1P;
      case HomePageContactType.second:
        return QppLocales.homeDigibagList2P;
      case HomePageContactType.third:
        return QppLocales.homeDigibagList3P;
    }
  }

  /// 內容在上方
  bool get contentOfTop {
    switch (this) {
      case HomePageContactType.first || HomePageContactType.third:
        return true;
      case HomePageContactType.second:
        return false;
    }
  }
}

// -----------------------------------------------------------------------------
/// 頁尾
// -----------------------------------------------------------------------------

/// 頁尾標題類型
enum HomePageFooterTitleType {
  /// 條款
  terms,

  /// 下載
  download;

  String get text => switch (this) {
        HomePageFooterTitleType.terms => QppLocales.footerTerms,
        HomePageFooterTitleType.download => QppLocales.footerDownload,
      };
}

// /// 頁尾連結類型
enum HomePageFooterLinkType {
  /// 隱私權政策
  privacyPolicy,

  /// 使用者條款
  termsOfUse,

  appleStore,

  googlePlay;

  String get text => switch (this) {
        HomePageFooterLinkType.privacyPolicy => QppLocales.footerPrivacyPolicy,
        HomePageFooterLinkType.termsOfUse => QppLocales.footerTermsOfService,
        HomePageFooterLinkType.appleStore => 'Apple Store',
        HomePageFooterLinkType.googlePlay => 'Google Play',
      };

  String get link => switch (this) {
        HomePageFooterLinkType.privacyPolicy => ServerConst.privacyPolicyUrl,
        HomePageFooterLinkType.termsOfUse => ServerConst.termsOfUseUrl,
        HomePageFooterLinkType.appleStore => ServerConst.appleStoreUrl,
        HomePageFooterLinkType.googlePlay => ServerConst.googlePlayStoreUrl,
      };
}
