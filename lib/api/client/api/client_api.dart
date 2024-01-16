import 'package:dio/dio.dart' hide Headers;
import 'package:qpp_example/api/core/http_service.dart';
import 'package:qpp_example/api/client/response/item_select.dart';
import 'package:qpp_example/api/client/response/multi_language_item_description_select.dart';
import 'package:qpp_example/api/client/response/multi_language_item_intro_link_select.dart';
import 'package:qpp_example/api/client/response/user_select_info.dart';
import 'package:qpp_example/constants/server_const.dart';
import 'package:retrofit/retrofit.dart';

part 'client_api.g.dart';

@RestApi()
abstract class ClientApi {
  @Deprecated('取得 client 請使用 ClientApiClient.client')
  factory ClientApi(Dio dio, {String baseUrl}) = _ClientApi;

  /// 商品列表資訊_查詢
  @POST("ItemSelect")
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json',
  })
  Future<ItemSelectInfoResponse> postItemSelect(@Body() itemIds);

  /// 商品多語系說明資訊_查詢
  @POST("MultiLanguageItemDescriptionSelect")
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json',
  })
  Future<MultiLanguageItemDescriptionSelectInfoResponse>
      postMultiLanguageItemDescriptionSelect(@Body() itemId);

  /// 商品多語系說明資訊_查詢
  @POST("MultiLanguageItemIntroLinkSelect")
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json',
  })
  Future<MultiLanguageItemIntroLinkSelectInfoResponse>
      postMultiLanguageItemIntroLinkSelect(@Body() itemId);

  /// 用戶資訊_查詢
  @POST("UserSelectInfo")
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json',
  })
  Future<UserSelectInfoResponse> postUserSelect(@Body() userId);
}

class ClientApiClient {
  /// 取得 client
  static ClientApi get client {
    Dio dio = HttpService.instance.dio;
    // 判斷是否用測試url
    dio.options.baseUrl = ServerConst.clientApiUrl;
    // ignore: deprecated_member_use_from_same_package
    return ClientApi(dio);
  }
}
