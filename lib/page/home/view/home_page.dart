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

/// 首頁
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scrollController = ScrollController();
  final global = GlobalKey();

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
        key: global,
        controller: scrollController,
        child: Column(
          children: [
            RepaintBoundary(child: HomePageIntroduce(key: introduceKey)),
            RepaintBoundary(child: HomePageFeature(key: featureKey)),
            RepaintBoundary(child: HomePageDescription(key: descriptionKey)),
            RepaintBoundary(child: HomePageContact(key: contactKey)),
            const HomePageFooter(key: ValueKey('HomePageFooter')),
          ],
        ),
      ),
    );
  }
}
