import 'package:dio/dio.dart';
import 'package:qpp_example/api/nft/nft_meta_data_response.dart';
import 'package:qpp_example/constants/server_const.dart';
import 'package:retrofit/retrofit.dart';

part 'nft_meta_api.g.dart';

/// 取得 NFT 物品資訊
@RestApi()
abstract class NftMetaApi {
  @Deprecated('取得 client 請使用 NftMetaApi.client')
  factory NftMetaApi(Dio dio, {String baseUrl}) = _NftMetaApi;

  // NFTMetadata/UC:101:2486.json
  /// 取得 NFT 物品資訊
  @GET('NFTMetadata/{nftID}.json')
  Future<NftMetaDataResponse> getNFTMeta(@Path('nftID') String nftID);
}

class NftMetaApiClient {
  /// 取得 client
  static NftMetaApi get client {
    Dio dio = Dio();
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.receiveTimeout = const Duration(seconds: 8);
    dio.options.baseUrl = ServerConst.storage;
    // ignore: deprecated_member_use_from_same_package
    return NftMetaApi(dio);
  }
}
