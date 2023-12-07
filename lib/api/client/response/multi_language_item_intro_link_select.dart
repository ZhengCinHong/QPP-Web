import 'dart:convert';
import '/api/client/response/base_client_response.dart';
import '/api/client/response/multi_language_item_data.dart';

class MultiLanguageItemIntroLinkSelectRequest {
  String createBody(String itemId) {
    return json.encode({'itemId': itemId});
  }
}

/// 搜尋物品多語系連結資訊
class MultiLanguageItemIntroLinkSelectInfoResponse extends BaseClientResponse {
  final MultiLanguageItemData introLinkData;

  const MultiLanguageItemIntroLinkSelectInfoResponse(
      {required this.introLinkData, required super.json});

  factory MultiLanguageItemIntroLinkSelectInfoResponse.fromJson(
      Map<String, dynamic> json) {
    return MultiLanguageItemIntroLinkSelectInfoResponse(
        json: json,
        introLinkData: MultiLanguageItemData.fromJson(json['introLink']));
  }
}
