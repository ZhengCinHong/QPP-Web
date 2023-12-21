/// 網址工具
class UrlGenerator {
  /// QR Code 及按鈕 網址處理
  static String getQRCodeUrl(String url) {
    // 先檢查參數
    var result = nftTypeCheck(url);
    if (result.contains('action=')) {
      return result;
    }
    Uri origin = Uri.parse(result);
    Map<String, String> params = Map.from(origin.queryParameters);
    // TODO: 目前強制加入 testing = true
    params.addAll({'action': 'download', 'testing': 'true'});
    // TODO: 目前為測試站台, host 先強制給原站
    String host = 'qpptec.com';
    Uri generated = Uri(
      scheme: origin.scheme,
      host: host,
      path: origin.path,
      queryParameters: params,
    );
    return generated.toString();
  }

  /// 檢查 nft 的 url 參數, 強制將 nft 資訊的 type 轉回 nft_info
  static String nftTypeCheck(String url) {
    // 類型是一般物品 但是 帶的參數是 metadataID
    if (url.contains('metadataID') && url.contains('commodity_info')) {
      print(url.replaceAll('commodity_info', 'nft_info'));
      return url.replaceAll('commodity_info', 'nft_info');
    }
    return url;
  }
}
