// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

/// 顯示的網址
class DisplayUrl {
  /// 更新網址 params
  static updateParam(String key, String value) {
    // final decodeQuery = Uri.decodeComponent(Uri.base.query);
    // Uri.base.
    // final encodePath = Uri.encodeComponent(decodeQuery);

    final baseUri = Uri.base;
    final uri = Uri(
      scheme: baseUri.scheme,
      host: baseUri.host,
      path: baseUri.path,
      query: Uri.encodeFull(baseUri.query),
    );

    // 先檢查是否有 query
    if (uri.queryParameters.isNotEmpty) {
      // params 字串
      String params = uri.toString().split('?')[1];

      // 有 query, 檢查是否有 lang parameter
      if (uri.queryParameters.containsKey(key)) {
        // 有 lang parameter
        String lang = uri.queryParameters[key].toString();
        int startIndex = params.indexOf(key);
        int endIndex = startIndex + 'lang'.length + lang.length + 1;
        params = params.replaceRange(startIndex, endIndex, 'lang=$value');
      } else {
        // 沒有 lang parameter
        params += '&lang=$value';
      }
      // window.history.pushState({}, '', '${Uri.base.path}?$params');
      setQuery('${uri.path}?$params');
    } else {
      // 沒有 query, 加上去
      // window.history.pushState({}, '', '${Uri.base.path}?lang=$value');
      setQuery('${uri.path}?lang=$value');
    }
  }

  static void setQuery(String query) {
    // Future.delayed(const Duration(milliseconds: 100), () {
    window.history.replaceState({}, '', query);
    // });
  }
}
