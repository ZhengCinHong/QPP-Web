import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qpp_example/api/core/http_service.dart';
import 'package:qpp_example/go_router/router.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:qpp_example/utils/shared_prefs_utils.dart';

void main() async {
  SharedPrefs.init();
  WidgetsFlutterBinding.ensureInitialized();

  // 多語系套件
  await EasyLocalization.ensureInitialized();

  // 建立URL策略，用以移除頁出現http://localhost:5654/#/的#字hash
  usePathUrlStrategy(); // flutter_web_plugins

  HttpService service = HttpService.instance; // dio
  service.initDio();

  runApp(
    EasyLocalization(
      // 支援的語系, 從 QppLocales 直接取出
      supportedLocales: QppLocales.supportedLocales,
      path: 'assets/langs/langs.csv',
      assetLoader: CsvAssetLoader(),
      child: const ProviderScope(child: MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(useMaterial3: true),
      routerConfig: QppGoRouter.router,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      builder: (context, child) {
        return MediaQuery(
          // 固定字型大小
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },
    );
  }
}
