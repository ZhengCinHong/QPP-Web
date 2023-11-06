import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qpp_example/api/core/http_service.dart';
import 'package:qpp_example/go_router/router.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';

void main() async {
  // 多語系套件
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  // 建立URL策略，用以移除頁出現http://localhost:5654/#/的#字hash
  usePathUrlStrategy(); // flutter_web_plugins

  HttpService service = HttpService.instance; // dio
  service.initDio();

  runApp(EasyLocalization(
      supportedLocales: QppLocales.supportedLocales,
      startLocale: const Locale('zh', 'TW'),
      fallbackLocale: const Locale('zh', 'TW'),
      path: 'assets/langs/langs.csv',
      assetLoader: CsvAssetLoader(),
      child: const ProviderScope(child: MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // context.setLocale(const Locale('zh', 'TW'));
    print('on buid locale ${context.locale.toString()}');
    return MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: router,
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates);
  }
}
