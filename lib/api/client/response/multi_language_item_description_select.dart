import 'dart:convert';
import 'package:qpp_example/api/client/response/base_client_response.dart';
import 'package:qpp_example/api/client/response/multi_language_item_data.dart';

class MultiLanguageItemDescriptionSelectRequest {
  String createBody(String itemId) {
    return json.encode({'itemId': itemId});
  }
}

/// 搜尋物品多語系說明資訊
class MultiLanguageItemDescriptionSelectInfoResponse
    extends BaseClientResponse {
  // 若無資料會跳 exception, 所以多一層轉接
  final dynamic descriptionJson;

  const MultiLanguageItemDescriptionSelectInfoResponse(
      {required this.descriptionJson, required super.json});

  factory MultiLanguageItemDescriptionSelectInfoResponse.fromJson(
      Map<String, dynamic> json) {
    return MultiLanguageItemDescriptionSelectInfoResponse(
        json: json, descriptionJson: json['description']);
  }

  MultiLanguageItemData get descriptionData {
    return MultiLanguageItemData.fromJson(descriptionJson);
  }
}
