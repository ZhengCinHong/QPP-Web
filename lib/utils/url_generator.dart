import 'package:qpp_example/extension/string/url.dart';
import 'package:qpp_example/main.dart';

/// 網址工具
class UrlGenerator {
  /// QR Code 及按鈕 網址處理(打開 APP)
  static String getQRCodeUrl(String url) {
    // 先檢查參數
    var result = url.nftTypeCheck();
    // action 要給 download, firebase 才會連結至 app
    var checkAction = result.modifyUrlParameter("action", "download");
    // line 強制用外部瀏覽器開啟
    var checkOpen = checkAction.modifyUrlParameter("openExternalBrowser", "1");
    Uri origin = Uri.parse(checkOpen);
    // host 強制給原站
    String scheme = 'https';
    String host = 'qpptec.com';
    // 有 port 要拿掉, 不然會被當成 path 塞進去
    String path = (Setting().port != null)
        ? origin.path.replaceAll(Setting().port.toString(), '')
        : origin.path;
    Uri generated = Uri(
      scheme: scheme,
      host: host,
      path: path,
      queryParameters: origin.queryParameters,
    );
    print('test generated ${generated.toString()}');
    return generated.toString();
  }

  
}
