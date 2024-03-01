import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qpp_example/common_ui/qpp_app_bar/model/qpp_app_bar_model.dart';
import 'package:qpp_example/common_ui/qpp_app_bar/view_model/qpp_app_bar_view_model.dart';
import 'package:qpp_example/page/home/model/home_page_model.dart';
import 'package:qpp_example/page/home/view/home_page_contact.dart';
import 'package:qpp_example/page/home/view/home_page_description.dart';
import 'package:qpp_example/page/home/view/home_page_feature.dart';
import 'package:qpp_example/page/home/view/home_page_footer.dart';
import 'package:qpp_example/page/home/view/home_page_introduce.dart';
import 'package:qpp_example/page/home/view_model/home_page_view_model.dart';

/// 首頁
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scrollController = ScrollController();

  /// 滑動到指定位置
  void scrollTo(
    StateController<MainMenu?> notifier,
    double scrollPoint,
  ) {
    Future.microtask(
      () => {
        scrollController.animateTo(
          scrollPoint,
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
        )
      },
    ).then((value) => notifier.state = null);
  }

  Future<void> precacheAssetImages() async {
    for (var element in HomePageModel.images) {
      precacheImage(AssetImage(element), context);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    precacheAssetImages();
  }

  @override
  Widget build(context) {
    return Consumer(
      builder: (context, ref, child) {
        final scrollToContext = ref.watch(scrollToContextProvider);
        final scrollToContextNotifier =
            ref.read(scrollToContextProvider.notifier);

        if (scrollToContext != null) {
          final container =
              scrollToContext.currentContext?.findRenderObject() as RenderBox;
          final scrollPoint =
              container.localToGlobal(Offset(0, scrollController.offset)).dy -
                  (Scaffold.of(context).appBarMaxHeight ?? 0);

          scrollTo(
            scrollToContextNotifier,
            scrollPoint <= 0 ? 0 : scrollPoint,
          );
        }

        return child ?? const SizedBox.shrink();
      },
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            RepaintBoundary(child: HomePageIntroduce(key: introduceKey)),
            RepaintBoundary(child: HomePageFeature(key: featureKey)),
            RepaintBoundary(child: HomePageDescription(key: descriptionKey)),
            RepaintBoundary(child: HomePageContact(key: contactKey)),
            const RepaintBoundary(
              child: HomePageFooter(key: ValueKey('HomePageFooter')),
            ),
          ],
        ),
      ),
    );
  }
}

/// 手機版首頁
class MobileHomePage extends StatefulWidget {
  const MobileHomePage({super.key});

  @override
  State<MobileHomePage> createState() => _MobileHomePageState();
}

class _MobileHomePageState extends State<MobileHomePage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  final menus = MainMenu.values;

  @override
  void initState() {
    _tabController = TabController(length: MainMenu.values.length, vsync: this);
    super.initState();
  }

  Future<void> precacheAssetImages() async {
    for (var element in HomePageModel.images) {
      precacheImage(AssetImage(element), context);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    precacheAssetImages();
  }

  @override
  Widget build(context) {
    const footerWidget = RepaintBoundary(
      child: HomePageFooter(key: ValueKey('HomePageFooter')),
    );

    return Consumer(
      builder: (context, ref, child) {
        final selectedIndex = ref.watch(selectedIndexProvider);

        _tabController.animateTo(selectedIndex);

        return child ?? const SizedBox.shrink();
      },
      child: DefaultTabController(
        length: menus.length,
        child: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: const [
            SingleChildScrollView(
              child: Column(
                children: [
                  RepaintBoundary(child: HomePageIntroduce()),
                  footerWidget,
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  RepaintBoundary(child: HomePageFeature()),
                  footerWidget,
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  RepaintBoundary(child: HomePageDescription()),
                  footerWidget,
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  RepaintBoundary(child: HomePageContact()),
                  footerWidget,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
