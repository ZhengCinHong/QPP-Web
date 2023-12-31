import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qpp_example/common_ui/qpp_app_bar/view/qpp_app_bar_view.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:qpp_example/utils/qpp_color.dart';
import 'package:qpp_example/utils/qpp_image.dart';
import 'package:qpp_example/utils/screen.dart';

/// 主框架
class MainFramework extends StatelessWidget {
  const MainFramework({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenStyle = screenSize.width.determineScreenStyle();
    final isDesktopStyle = screenStyle.isDesktop;

    // 設定頁籤上方顯示內容
    return Title(
      title: context.tr(QppLocales.homeWebtitle),
      color: QppColors.platinum,
      child: Stack(
        children: [
          _MainScaffold(isDesktopStyle: isDesktopStyle, child: child),
          isDesktopStyle
              ? const SizedBox.shrink()
              : const FullScreenMenuBtnPage(),
        ],
      ),
    );
  }
}

/// 主鷹架
class _MainScaffold extends StatelessWidget {
  const _MainScaffold({
    required this.child,
    required this.isDesktopStyle,
  });

  final Widget child;

  final bool isDesktopStyle;

  @override
  Widget build(BuildContext context) {
    // debugPrint(toString());

    return SelectionArea(
      child: Scaffold(
        extendBodyBehindAppBar: true, // 設定可以在appBar後面擴充body
        backgroundColor: QppColors.oxfordBlue,
        appBar: qppAppBar(isDesktopStyle),
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                isDesktopStyle
                    ? QPPImages.desktop_bg_kv
                    : QPPImages.mobile_bg_kv,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
