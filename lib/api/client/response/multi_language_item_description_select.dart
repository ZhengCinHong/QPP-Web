import 'dart:convert';
import '/api/client/response/base_client_response.dart';
import '/api/client/response/multi_language_item_data.dart';

class MultiLanguageItemDescriptionSelectRequest {
  String createBody(String itemId) {
    return json.encode({'itemId': itemId});
  }
}

/// 搜尋物品多語系說明資訊
class MultiLanguageItemDescriptionSelectInfoResponse
    extends BaseClientResponse {
  final MultiLanguageItemData descriptionData;

  const MultiLanguageItemDescriptionSelectInfoResponse(
      {required this.descriptionData, required super.json});

  factory MultiLanguageItemDescriptionSelectInfoResponse.fromJson(
      Map<String, dynamic> json) {
    return MultiLanguageItemDescriptionSelectInfoResponse(
        json: json,
        descriptionData: MultiLanguageItemData.fromJson(json['description']));
  }
}
