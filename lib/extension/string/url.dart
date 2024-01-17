import 'package:url_launcher/url_launcher.dart';

extension UrlExtension on String {
  /// 啟動URL
  launchURL({bool isNewTab = true}) async {
    final Uri url = Uri.parse(this);

    if (!await launchUrl(url,
        webOnlyWindowName: isNewTab ? '_blank' : '_self')) {
      throw Exception('Could not launch $url');
    }
  }

  // 修改URL参数的函数
  String modifyUrlParameter(String paramName, String paramValue) {
    Uri uri = Uri.parse(this);
    Map<String, String> queryParameters = Map.from(uri.queryParameters);
    queryParameters[paramName] = paramValue;
    // 使用replace方法创建一个新的Uri对象，其中更新了参数
    Uri modifiedUri = uri.replace(queryParameters: queryParameters);
    // 将Uri对象转换为字符串并返回
    return modifiedUri.toString();
  }

  /// 檢查 nft 的 url 參數, 強制將 nft 資訊的 type 轉回 nft_info
  String nftTypeCheck() {
    // 類型是一般物品 但是 帶的參數是 metadataID
    if (contains('metadataID') && contains('commodity_info')) {
      return replaceAll('commodity_info', 'nft_info');
    }
    return this;
  }
}
