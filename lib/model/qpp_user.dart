import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qpp_example/api/client/response/user_select_info.dart';
import 'package:qpp_example/constants/server_const.dart';
import 'package:qpp_example/extension/string/url.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:qpp_example/main.dart';
import 'package:qpp_example/model/enum/user/user_verification_type.dart';
import 'package:qpp_example/utils/qpp_image.dart';

class QppUser {
  final int id;
  late String name;
  late String info;
  late VerificationType verificationType;

  QppUser.create(this.id, UserSelectInfoResponse response) {
    name = response.name;
    info = response.info;
    verificationType =
        VerificationType.findTypeByValue(response.verificationType);
  }

  /// 是否為官方帳號
  bool get isOfficial => verificationType.isOfficial;

  /// 取得暱稱
  String get displayName => name.isEmpty ? QppLocales.errorPageNickname : name;

  /// 取得簡介
  String get displayInfo =>
      info.isEmpty ? QppLocales.errorPageInfoNotyet : info;

  /// 取得官方帳號 icon path
  String get officialIconPath =>
      isOfficial ? QPPImages.desktop_icon_newsfeed_official_large : '';

  /// 取得 ID
  String get displayID => id.toString();
  /// 取得個人資訊連結
 String createInformationUrl(BuildContext context) {
    // set phone number
    var result = ServerConst.information
        .modifyUrlParameter("phoneNumber", displayID)
        .modifyUrlParameter("lang", context.locale.toString())
        .modifyUrlParameter("action", 'stay')
        .modifyUrlParameter('testing', Setting().isTest.toString());
    return result;
  }
}
