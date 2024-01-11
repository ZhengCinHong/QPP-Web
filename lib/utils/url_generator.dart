/// 網址工具
class UrlGenerator {
  /// QR Code 及按鈕 網址處理(打開 APP)
  static String getQRCodeUrl(String url) {
    // 先檢查參數
    var result = nftTypeCheck(url);
    // action 要給 download, firebase 才會連結至 app
    var checkAction = modifyUrlParameter(result, "action", "download");
    // TODO: 目前強制加入 testing = true
    var checkTesting = modifyUrlParameter(checkAction, "testing", "true");
    Uri origin = Uri.parse(checkTesting);
    // TODO: 目前為測試站台, host 先強制給原站
    String host = 'qpptec.com';
    Uri generated = Uri(
      scheme: origin.scheme,
      host: host,
      path: origin.path,
      queryParameters: origin.queryParameters,
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

  // 修改URL参数的函数
  static String modifyUrlParameter(
      String url, String paramName, String paramValue) {
    Uri uri = Uri.parse(url);
    Map<String, String> queryParameters = Map.from(uri.queryParameters);
    queryParameters[paramName] = paramValue;
    // 使用replace方法创建一个新的Uri对象，其中更新了参数
    Uri modifiedUri = uri.replace(queryParameters: queryParameters);
    // 将Uri对象转换为字符串并返回
    return modifiedUri.toString();
  }
}
