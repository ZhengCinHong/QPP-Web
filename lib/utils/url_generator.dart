/// 網址工具
class UrlGenerator {
  static String getQRCodeUrl(String url) {
    if (url.contains('action=')) {
      return url;
    }
    Uri origin = Uri.parse(url);
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
}
