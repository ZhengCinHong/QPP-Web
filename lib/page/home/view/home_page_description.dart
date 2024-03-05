import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:qpp_example/page/home/model/home_page_model.dart';
import 'package:qpp_example/page/home/view_model/home_page_view_model.dart';
import 'package:qpp_example/utils/qpp_color.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';
import 'package:qpp_example/utils/screen.dart';

/// 首頁 - 使用說明
class HomePageDescription extends StatelessWidget {
  const HomePageDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final ScreenStyle screenStyle = constraints.screenStyle;

        return switch (screenStyle) {
          ScreenStyle.desktop => const Row(
              children: [
                Expanded(child: _PhoneDescription.desktop()),
                Expanded(child: _DirectoryAndForumDescription.desktop())
              ],
            ),
          _ => const Column(
              children: [
                _PhoneDescription.mobile(),
                _DirectoryAndForumDescription.mobile()
              ],
            ),
        };
      },
    );
  }
}

/// 手機說明(第一區塊)
class _PhoneDescription extends StatelessWidget {
  const _PhoneDescription.desktop() : screenStyle = ScreenStyle.desktop;
  const _PhoneDescription.mobile() : screenStyle = ScreenStyle.mobile;

  final ScreenStyle screenStyle;

  @override
  Widget build(BuildContext context) {
    // 获取屏幕信息
    final height = MediaQuery.of(context).size.height;
    final isDesktopStyle = screenStyle.isDesktop;
    const type = HomePageDescriptionType.phone;

    return Consumer(
      builder: (context, ref, child) {
        final hoveredTypeNotifier = ref.read(hoveredTypeProvider.notifier);

        return MouseRegion(
          onEnter: (event) =>
              {print(type.toString()), hoveredTypeNotifier.state = type},
          onExit: (event) => hoveredTypeNotifier.state = null,
          child: child,
        );
      },
      child: SizedBox(
        height: isDesktopStyle ? height : height * 3 / 4,
        child: Stack(
          children: [
            _BgWidget(
              type,
              screenStyle: screenStyle,
            ),
            Column(
              children: [
                Expanded(
                  flex: isDesktopStyle ? 1 : 2,
                  child: Container(
                    color: QppColors.barMask,
                    padding: isDesktopStyle
                        ? null //const EdgeInsets.only(left: 104, right: 10)
                        : const EdgeInsets.symmetric(horizontal: 53.5),
                    alignment: Alignment.center,
                    child: Flex(
                      direction:
                          isDesktopStyle ? Axis.horizontal : Axis.vertical,
                      mainAxisAlignment: isDesktopStyle
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.center,
                      children: [
                        isDesktopStyle
                            ? const Spacer(flex: 104)
                            : const SizedBox.shrink(),
                        Image.asset(
                          key: const ValueKey(HomePageModel.descriptionBgImage),
                          HomePageModel.descriptionBgImage,
                          cacheWidth: 148,
                          cacheHeight: 46,
                        ),
                        const SizedBox(height: 16, width: 36),
                        Flexible(
                          flex: isDesktopStyle ? 504 : 0,
                          child: Text(
                            context.tr(QppLocales.homeSection3Title),
                            style: isDesktopStyle
                                ? QppTextStyles.web_24pt_title_L_white_L
                                : QppTextStyles.mobile_16pt_title_white_bold_L,
                            textAlign: isDesktopStyle ? null : TextAlign.center,
                          ),
                        ),
                        isDesktopStyle
                            ? const Spacer(flex: 87)
                            : const SizedBox.shrink()
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: isDesktopStyle
                      ? const _Content.desktop(type: type)
                      : const _Content.mobile(type: type),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// 通訊錄與討論區說明(第二、三區塊)
class _DirectoryAndForumDescription extends StatelessWidget {
  const _DirectoryAndForumDescription.desktop()
      : screenStyle = ScreenStyle.desktop;
  const _DirectoryAndForumDescription.mobile()
      : screenStyle = ScreenStyle.mobile;

  final ScreenStyle screenStyle;

  @override
  Widget build(BuildContext context) {
    // 获取屏幕信息
    final height = MediaQuery.of(context).size.height;
    final isDesktopStyle = screenStyle.isDesktop;

    return SizedBox(
      height: isDesktopStyle ? height : (height * 3 / 4) * 2,
      child: Column(children: [
        Expanded(
          child: isDesktopStyle
              ? const _Content.desktop(type: HomePageDescriptionType.directory)
              : const _Content.mobile(type: HomePageDescriptionType.directory),
        ),
        Expanded(
          child: isDesktopStyle
              ? const _Content.desktop(type: HomePageDescriptionType.forum)
              : const _Content.mobile(type: HomePageDescriptionType.forum),
        ),
      ]),
    );
  }
}

/// 內容
class _Content extends StatelessWidget {
  const _Content.desktop({required this.type})
      : screenStyle = ScreenStyle.desktop;
  const _Content.mobile({required this.type})
      : screenStyle = ScreenStyle.mobile;

  final HomePageDescriptionType type;
  final ScreenStyle screenStyle;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final hoveredTypeNotifier = ref.read(hoveredTypeProvider.notifier);

      return MouseRegion(
        onEnter: (event) => type == HomePageDescriptionType.phone // 手機板塊在外層實現了，這邊就不需要了，不然會有衝突
            ? null
            : hoveredTypeNotifier.state = type,
        onExit: (event) => type == HomePageDescriptionType.phone // 手機板塊在外層實現了，這邊就不需要了，不然會有衝突
            ? null
            : hoveredTypeNotifier.state = null,
        child: screenStyle.isDesktop
            ? DesktopStyleContent(
                key: ValueKey(type),
                type,
              )
            : MobileStyleContent(
                key: ValueKey(type),
                type,
              ),
      );
    });
  }
}

/// 桌面樣式內容
class DesktopStyleContent extends StatelessWidget {
  const DesktopStyleContent(this.type, {super.key});

  final HomePageDescriptionType type;

  @override
  Widget build(BuildContext context) {
    final bg = _Bg(ScreenStyle.desktop, type: type);

    return Row(children: [
      type.conetntOfRight ? bg : const SizedBox.shrink(),
      Expanded(
        child: LayoutBuilder(
          builder: (context, BoxConstraints constraints) {
            final horizontal = constraints.maxWidth * 0.163;

            return Container(
              color: QppColors.oxfordBlue,
              padding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: horizontal),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: AutoSizeText(
                      context.tr(type.title),
                      style: QppTextStyles.web_24pt_title_L_bold_white_L,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Flexible(
                    child: AutoSizeText(
                      context.tr(type.directions),
                      style: QppTextStyles.web_16pt_body_white_L,
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
      type.conetntOfRight ? const SizedBox.shrink() : bg,
    ]);
  }
}

/// 手機樣式內容
class MobileStyleContent extends StatelessWidget {
  const MobileStyleContent(this.type, {super.key});

  final HomePageDescriptionType type;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      _Bg(ScreenStyle.mobile, type: type, flex: 2),
      Expanded(
        child: Container(
          color: QppColors.oxfordBlue,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: AutoSizeText(
                  context.tr(type.title),
                  style: QppTextStyles.mobile_18pt_title_m_bold_sky_white_C,
                  softWrap: true,
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 15),
              Flexible(
                flex: 2,
                child: AutoSizeText(
                  context.tr(type.directions),
                  style: QppTextStyles.mobile_14pt_body_white_C,
                  softWrap: true,
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    ]);
  }
}

class _Bg extends StatelessWidget {
  const _Bg(this.screenStyle, {required this.type, this.flex = 1});

  final HomePageDescriptionType type;
  final ScreenStyle screenStyle;
  final int flex;

  @override
  Widget build(BuildContext context) {
    final bool isShowBackground = type != HomePageDescriptionType.phone;

    return Expanded(
      flex: (screenStyle.isDesktop || isShowBackground) ? flex : 0,
      child: _BgWidget(
        type,
        screenStyle: screenStyle,
        isShowBackground: isShowBackground,
      ),
    );
  }
}

class _BgWidget extends StatelessWidget {
  const _BgWidget(
    this.type, {
    required this.screenStyle,
    this.isShowBackground = true,
  });

  final HomePageDescriptionType type;
  final ScreenStyle screenStyle;
  final bool isShowBackground;

  @override
  Widget build(BuildContext context) {
    var cacheSize = type.getCacheSize(screenStyle);

    return screenStyle == ScreenStyle.desktop
        ? Consumer(
            builder: (context, ref, child) {
              final hoveredType = ref.watch(hoveredTypeProvider);

              return LayoutBuilder(builder: (context, constraints) {
                final height = constraints.maxHeight;
                final width = constraints.maxWidth;

                return ClipRect(
                  child: AnimatedContainer(
                    height: isShowBackground ? null : 0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    transform: Matrix4.identity()
                      ..translate(width / 2, height / 2) // 将中心点移动到容器的中心
                      ..scale(hoveredType == type ? 1.1 : 1.0)
                      ..translate(-width / 2, -height / 2), // 将中心点移回容器的中心
                    child: Center(child: child),
                  ),
                );
              });
            },
            child: Container(
              key: ValueKey(type.image),
              decoration: BoxDecoration(
                image: isShowBackground
                    ? DecorationImage(
                        image: ResizeImage(
                          AssetImage(type.image),
                          width: cacheSize.width.toInt(),
                          height: cacheSize.height.toInt(),
                        ),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
            ),
          )
        : Container(
            key: ValueKey(type.image),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: ResizeImage(
                  AssetImage(type.image),
                  width: cacheSize.width.toInt(),
                  height: cacheSize.height.toInt(),
                ),
                fit: BoxFit.cover,
              ),
            ),
          );
  }
}
