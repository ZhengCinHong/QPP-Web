import 'dart:convert';
import 'package:qpp_example/api/client/response/base_client_response.dart';
import 'package:qpp_example/api/client/response/multi_language_item_data.dart';

class MultiLanguageItemIntroLinkSelectRequest {
  String createBody(String itemId) {
    return json.encode({'itemId': itemId});
  }
}

/// 搜尋物品多語系連結資訊
class MultiLanguageItemIntroLinkSelectInfoResponse extends BaseClientResponse {
  // 若無資料會跳 exception, 所以多一層轉接
  final dynamic introLinkJson;

  const MultiLanguageItemIntroLinkSelectInfoResponse(
      {required this.introLinkJson, required super.json});

  factory MultiLanguageItemIntroLinkSelectInfoResponse.fromJson(
      Map<String, dynamic> json) {
    return MultiLanguageItemIntroLinkSelectInfoResponse(
      json: json,
      introLinkJson: json['introLink'],
    );
  }

  MultiLanguageItemData get introLinkData {
    return MultiLanguageItemData.fromJson(introLinkJson);
  }
}
