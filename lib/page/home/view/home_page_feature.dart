import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qpp_example/common_ui/qpp_app_bar/view/qpp_app_bar_view.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:qpp_example/page/home/model/home_page_model.dart';
import 'package:qpp_example/page/home/view_model/home_page_view_model.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';
import 'package:qpp_example/utils/screen.dart';

/// 首頁 - 特色
class HomePageFeature extends StatelessWidget {
  const HomePageFeature({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        /// 螢幕樣式
        final ScreenStyle screenStyle = constraints.screenStyle;
        final bool isDesktopStyle = screenStyle.isDesktop;
        final int flex = isDesktopStyle ? 1 : 0;
        final double topAndBottomSpacing = isDesktopStyle ? 200 : 80;
        const double leftAndRightSpacing = 24;
        final String image = isDesktopStyle
            ? HomePageModel.featureBgImages[0]
            : HomePageModel.featureBgImages[1];

        return Container(
          key: ValueKey(image),
          width: constraints.maxWidth,
          padding: EdgeInsets.only(
            top: topAndBottomSpacing,
            bottom: topAndBottomSpacing,
            left: leftAndRightSpacing,
            right: leftAndRightSpacing,
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),
          ),
          child: Flex(
            direction: isDesktopStyle ? Axis.horizontal : Axis.vertical,
            crossAxisAlignment: isDesktopStyle
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: [
              Expanded(
                  flex: flex,
                  child: isDesktopStyle
                      ? const _Left(ScreenStyle.desktop)
                      : const _Left(ScreenStyle.mobile)),
              const SizedBox(height: 24, width: 24),
              Expanded(
                flex: flex,
                child: isDesktopStyle
                    ? const _FeatureInfo.desktop()
                    : const _FeatureInfo.mobile(),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// 左側Widget
class _Left extends StatelessWidget {
  const _Left(this.screenStyle);

  final ScreenStyle screenStyle;

  @override
  Widget build(BuildContext context) {
    final isDesktopStyle = screenStyle.isDesktop;

    return Column(
      children: [
        Text(
          context.tr(QppLocales.homeSection2Title),
          style: isDesktopStyle
              ? QppTextStyles.web_36pt_Display_s_dark_oxford_blue_L
              : QppTextStyles.web_24pt_title_L_black_C,
          textAlign: TextAlign.center,
        ),
        isDesktopStyle
            ? Image.asset(
                key: const ValueKey(HomePageModel.featureLeftImage),
                HomePageModel.featureLeftImage)
            : const SizedBox(),
      ],
    );
  }
}

/// 特色資訊
class _FeatureInfo extends StatelessWidget {
  const _FeatureInfo.desktop() : screenStyle = ScreenStyle.desktop;
  const _FeatureInfo.mobile() : screenStyle = ScreenStyle.mobile;

  final ScreenStyle screenStyle;

  final types = HomePageFeatureInfoType.values;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: types.length,
      itemBuilder: (context, index) {
        return _FeatureInfoItem(screenStyle, type: types[index]);
      },
    );
  }
}

// 特色資訊Item
class _FeatureInfoItem extends StatelessWidget {
  const _FeatureInfoItem(this.screenStyle, {required this.type});

  final HomePageFeatureInfoType type;
  final ScreenStyle screenStyle;

  @override
  Widget build(BuildContext context) {
    // debugPrint(toString());

    final isDesktopStyle = screenStyle.isDesktop;
    final flex = isDesktopStyle ? 1 : 0;

    return Consumer(
      builder: (context, ref, child) {
        final tapFeatureType = ref.watch(highlightFeatureTypeProvider);
        final tapFeatureTypeNotifier =
            ref.read(highlightFeatureTypeProvider.notifier);

        final isHighlight = tapFeatureType == type;
        return CMouseRegion(
          onEnter: (event) => tapFeatureTypeNotifier.state = type,
          onExit: (event) => tapFeatureTypeNotifier.state = null,
          onTap: () => tapFeatureTypeNotifier.state = type,
          child: Padding(
            padding: EdgeInsets.only(
                bottom: type == HomePageFeatureInfoType.more
                    ? 0
                    : isDesktopStyle
                        ? 50
                        : 44),
            child: Flex(
              direction: isDesktopStyle ? Axis.horizontal : Axis.vertical,
              children: [
                Image.asset(
                  key: ValueKey(type.image),
                  isHighlight ? type.highlightImage : type.image,
                  width: 50,
                  height: 50,
                  cacheWidth: 50,
                  cacheHeight: 50,
                ),
                const SizedBox(height: 16, width: 27),
                Expanded(
                  flex: flex,
                  child: Column(
                    crossAxisAlignment: isDesktopStyle
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.center,
                    children: [
                      Text(
                        context.tr(type.title),
                        style: isHighlight
                            ? isDesktopStyle
                                ? QppTextStyles.web_24pt_title_L_skyblue_L
                                : QppTextStyles
                                    .mobile_18pt_title_m_bold_sky_blue_C
                            : isDesktopStyle
                                ? QppTextStyles.web_24pt_title_L_ash_gray_L
                                : QppTextStyles
                                    .mobile_18pt_title_m_ash_gray_medium_C,
                      ),
                      SizedBox(height: isDesktopStyle ? 12 : 16),
                      Text(
                        context.tr(type.directions),
                        textAlign:
                            isDesktopStyle ? TextAlign.start : TextAlign.center,
                        style: isHighlight
                            ? isDesktopStyle
                                ? QppTextStyles.web_16pt_body_black_L
                                : QppTextStyles.mobile_14pt_body_ash_black_C
                            : isDesktopStyle
                                ? QppTextStyles.web_16pt_body_ash_gray_L
                                : QppTextStyles.mobile_14pt_body_ash_gray_C,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
