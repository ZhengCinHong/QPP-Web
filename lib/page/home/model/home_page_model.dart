import 'package:qpp_example/constants/server_const.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:qpp_example/utils/qpp_image.dart';

class HomePageModel {
  /// 產品介紹QPP文字圖片
  static const introduceQppTextImage = QPPImages.desktop_image_qpp_text;
  /// 產品介紹手機圖片
  static const introducePicKvImage = QPPImages.desktop_pic_kv;
  /// 產品介紹即刻登入Icon
  static const introduceKvRegisteredIcon = QPPImages.desktop_icon_kv_registered;
  /// 產品介紹雙向下箭頭
  static const introduceArrowdonDoubleIcon = QPPImages.desktop_icon_arrowdown_double;

  /// 產品特色背景圖
  static const featureBgImages = [
    QPPImages.desktop_bg_area_01,
    QPPImages.mobile_bg_area_01
  ];

  /// 產品特色左側Image
  static const featureLeftImage = QPPImages.desktop_pic_area_01;

  /// 使用說明背景圖
  static const descriptionBgImage = QPPImages.desktop_image_qpp_logo_01;

  /// 聯繫我們背景圖(桌面樣式)
  static const contactDesktopBgImage = QPPImages.desktop_bg_area_03;

  /// 聯繫我們背景圖(手機樣式)
  static const contactMobileBgImage = QPPImages.mobile_bg_area_03;

  /// 聯繫我們官方Icon
  static const contactOfficialIcon = QPPImages.desktop_icon_area_04_official;

  /// 聯繫我們益處圖片
  static const constBenefitImage = QPPImages.desktop_bg_area_03_box;

  /// footer Logo圖片
  static const footerLogoImages = [
    QPPImages.desktop_pic_qpp_logo_03,
    QPPImages.mobile_pic_qpp_logo_03
  ];

  /// 首頁所有圖片
  static List<String> images = featureBgImages +
      [
        introduceQppTextImage,
        introducePicKvImage,
        introduceKvRegisteredIcon,
        introduceArrowdonDoubleIcon,
        featureLeftImage,
        descriptionBgImage,
        contactDesktopBgImage,
        contactMobileBgImage,
        contactOfficialIcon,
        constBenefitImage
      ] +
      footerLogoImages +
      PlayStoreType.values.map((e) => e.image).toList() +
      HomePageFeatureInfoType.values.map((e) => e.image).toList() +
      HomePageDescriptionType.values.map((e) => e.image).toList();
}

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

  String get image {
    switch (this) {
      case HomePageDescriptionType.phone:
        return QPPImages.desktop_pic_area_02_01;
      case HomePageDescriptionType.directory:
        return QPPImages.desktop_pic_area_02_02;
      case HomePageDescriptionType.forum:
        return QPPImages.desktop_pic_area_02_03;
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
