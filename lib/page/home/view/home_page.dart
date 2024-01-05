import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qpp_example/common_ui/qpp_app_bar/model/qpp_app_bar_model.dart';
import 'package:qpp_example/common_ui/qpp_app_bar/view_model/qpp_app_bar_view_model.dart';
import 'package:qpp_example/page/home/view/home_page_contact.dart';
import 'package:qpp_example/page/home/view/home_page_description.dart';
import 'package:qpp_example/page/home/view/home_page_feature.dart';
import 'package:qpp_example/page/home/view/home_page_footer.dart';
import 'package:qpp_example/page/home/view/home_page_introduce.dart';

/// 首頁
class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ScrollController scrollController = ScrollController();

  void scrollTo(
    StateController<MainMenu?> notifier,
    ScrollController scrollController,
    double scrollPoint,
  ) {
    Future.microtask(() => {
          scrollController.animateTo(
            scrollPoint,
            duration: const Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn,
          )
        }).then((value) => notifier.state = null);
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

          scrollTo(scrollToContextNotifier, scrollController,
              scrollPoint <= 0 ? 0 : scrollPoint);

          print({scrollToContext.currentContext, scrollPoint});
        }

        return SingleChildScrollView(
            controller: scrollController, child: child);
      },
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: 5,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return switch (index) {
            0 => HomePageIntroduce(key: introduceKey),
            1 => HomePageFeature(key: featureKey),
            2 => HomePageDescription(key: descriptionKey),
            3 => HomePageContact(key: contactKey),
            _ => const HomePageFooter(),
          };
        },
      ),
    );
  }
}
