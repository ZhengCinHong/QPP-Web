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
}
