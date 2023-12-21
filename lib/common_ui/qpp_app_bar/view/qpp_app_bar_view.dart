import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qpp_example/common_ui/qpp_menu/c_menu_anchor.dart';
import 'package:qpp_example/common_view_model/auth_service/view_model/auth_service_view_model.dart';
import 'package:qpp_example/extension/build_context.dart';
import 'package:qpp_example/extension/void/dialog_void.dart';
import 'package:qpp_example/extension/throttle_debounce.dart';
import 'package:qpp_example/common_ui/qpp_app_bar/model/qpp_app_bar_model.dart';
import 'package:qpp_example/common_ui/qpp_app_bar/view_model/qpp_app_bar_view_model.dart';
import 'package:qpp_example/extension/widget/disable_selection_container.dart';
import 'package:qpp_example/go_router/router.dart';
import 'package:qpp_example/utils/display_url.dart';
import 'package:qpp_example/utils/qpp_color.dart';
import 'package:qpp_example/model/enum/language.dart';
import 'package:qpp_example/constants/qpp_contanst.dart';
import 'package:qpp_example/utils/qpp_image.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';
import 'package:qpp_example/utils/screen.dart';
import 'package:qpp_example/utils/shared_prefs_utils.dart';

AppBar qppAppBar(ScreenStyle screenStyle) {
  return AppBar(
    automaticallyImplyLeading: false, // 關閉返回按鈕
    toolbarHeight:
        screenStyle.isDesktop ? kToolbarDesktopHeight : kToolbarMobileHeight,
    backgroundColor: QppColors.barMask,
    title: screenStyle.isDesktop
        ? const _QppAppBarTitle(ScreenStyle.desktop)
        : const _QppAppBarTitle(ScreenStyle.mobile),
    titleSpacing: 0,
  );
}

// -----------------------------------------------------------------------------
/// QppAppBarTitle
// -----------------------------------------------------------------------------
class _QppAppBarTitle extends ConsumerWidget {
  const _QppAppBarTitle(this.screenStyle);

  final ScreenStyle screenStyle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // debugPrint(toString());

    final bool isDesktopStyle = screenStyle.isDesktop;

    final bool isOpenAppBarMenuBtnPage =
        ref.watch(isOpenAppBarMenuBtnPageProvider);

    final checkLoginTokenState = ref.watch(
        authServiceProvider.select((value) => value.checkLoginTokenState));

    final bool isLogin = ((SharedPrefs.getLoginInfo()?.isLogin ?? false) ||
        (checkLoginTokenState.data?.isSuccess ?? false));

    return Row(
      children: [
        // 最左邊間距
        isDesktopStyle ? const Spacer(flex: 320) : const SizedBox(width: 29),
        isOpenAppBarMenuBtnPage
            ? const SizedBox.shrink()
            : isDesktopStyle
                ? const _Logo(ScreenStyle.desktop)
                : const _Logo(ScreenStyle.mobile),
        // QPP -> Button 間距
        Spacer(
            flex: isDesktopStyle
                ? isLogin
                    ? 362
                    : 527
                : 210),
        // 選單按鈕
        isDesktopStyle
            ? const MenuBtns.horizontal(padding: 73, fontSize: 18)
            : const SizedBox.shrink(),
        isLogin
            ? Container(
                constraints: const BoxConstraints(minWidth: 20, maxWidth: 64))
            : const SizedBox.shrink(),
        // 用戶資訊
        isLogin
            ? isDesktopStyle
                ? const _UserInfo(ScreenStyle.desktop)
                : const _UserInfo(ScreenStyle.mobile)
            : const SizedBox.shrink(),
        Spacer(
            flex: isDesktopStyle
                ? isLogin
                    ? 48
                    : 64
                : 20),
        // 語系
        isDesktopStyle
            ? const LanguageDropdownMenu(ScreenStyle.desktop)
            : const LanguageDropdownMenu(ScreenStyle.mobile),
        // 三條 or 最右邊間距
        isDesktopStyle
            ? const Flexible(child: SizedBox.shrink())
            : const Padding(
                padding: EdgeInsets.only(left: 10),
                child: AnimationMenuBtn(isClose: false),
              ),
        isDesktopStyle ? const Spacer(flex: 319) : const SizedBox(width: 24)
      ],
    );
  }
}

// -----------------------------------------------------------------------------
/// QPP Logo
// -----------------------------------------------------------------------------
class _Logo extends StatelessWidget {
  const _Logo(this.screenStyle);

  final ScreenStyle screenStyle;

  @override
  Widget build(BuildContext context) {
    final bool isDesktopStyle = screenStyle.isDesktop;

    return IconButton(
      icon: Image.asset(
        QPPImages.desktop_image_qpp_logo_01,
        width: isDesktopStyle ? 147.2 : 89,
        height: isDesktopStyle ? 44.4 : 27.4,
      ),
      onPressed: () => context.canPop()
          ? context.goNamed(QppGoRouter.app)
          : context.goNamed(QppGoRouter.home), // 要在修改，現在只有error畫面會跳到home
    );
  }
}

// -----------------------------------------------------------------------------
/// 選單按鈕(Row)
/// - Note: 產品介紹...等
// -----------------------------------------------------------------------------
class MenuBtns extends StatelessWidget {
  /// 垂直
  const MenuBtns.vertical({
    super.key,
    required this.padding,
    required this.fontSize,
  }) : _direction = Axis.vertical;

  /// 水平
  const MenuBtns.horizontal({
    super.key,
    required this.padding,
    required this.fontSize,
  }) : _direction = Axis.horizontal;

  final Axis _direction;
  final double padding;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    // debugPrint(toString());
    final bool isHorizontal = _direction == Axis.horizontal;

    return Container(
      constraints: const BoxConstraints(maxWidth: 699),
      child: Flex(
        crossAxisAlignment:
            isHorizontal ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        direction: _direction,
        children: MainMenu.values
            .map(
              (e) => Flex(
                direction: isHorizontal ? Axis.horizontal : Axis.vertical,
                children: [
                  MouseRegionCustomWidget(
                    builder: (event) => MouseRegion(
                      cursor: SystemMouseCursors.click, // 改鼠標樣式
                      child: GestureDetector(
                        onTap: () {
                          bool isInHomePage =
                              ModalRoute.of(context)?.isFirst ?? false;
    
                          if (isInHomePage) {
                            Scrollable.ensureVisible(
                              e.currentContext!,
                              duration: const Duration(seconds: 1),
                            );
                          } else {
                            context.pop();
    
                            Future.delayed(
                              const Duration(milliseconds: 300),
                              () => Scrollable.ensureVisible(
                                e.currentContext!,
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          }
                        }.throttleWithTimeout(timeout: 2000),
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 120),
                          child: AutoSizeText(
                            key: e.key,
                            context.tr(e.text),
                            style: TextStyle(
                              color: event is PointerEnterEvent
                                  ? QppColors.canaryYellow
                                  : QppColors.white,
                              fontSize: fontSize,
                            ),
                            maxLines: 2,
                          ).disabledSelectionContainer,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(
                        maxWidth: e == MainMenu.contact
                            ? 0
                            : (isHorizontal ? padding : 0),
                        maxHeight: e == MainMenu.contact
                            ? 0
                            : (isHorizontal ? 0 : padding)),
                  )
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
/// animationMenuBtn(三條or關閉)
// -----------------------------------------------------------------------------
class AnimationMenuBtn extends StatefulWidget {
  const AnimationMenuBtn({super.key, required this.isClose});

  final bool isClose;

  @override
  State<StatefulWidget> createState() => _AnimationMenuBtn();
}

class _AnimationMenuBtn extends State<AnimationMenuBtn>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );

  int _count = 0;
  final int _targetCount = 1;

  @override
  void initState() {
    super.initState();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _count++;
        if (_count < _targetCount) {
          _controller.reset();
          _controller.forward();
        }
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose(); // 要在super.dispose()之前處置Ticker
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: -_controller.value * 2 * pi,
          child: Consumer(builder: (context, ref, child) {
            final notifier = ref.read(isOpenAppBarMenuBtnPageProvider.notifier);

            return IconButton(
              iconSize: 24,
              onPressed: () => notifier.toggle(),
              icon: widget.isClose || _count < _targetCount
                  ? Image.asset('assets/mobile-icon-actionbar-close-normal.png')
                  : Image.asset(QPPImages.mobile_icon_actionbar_list_normal),
            );
          }),
        );
      },
    );
  }
}

// -----------------------------------------------------------------------------
/// 使用者資訊
// -----------------------------------------------------------------------------
class _UserInfo extends StatelessWidget {
  const _UserInfo(this.screenStyle);

  final ScreenStyle screenStyle;

  @override
  Widget build(BuildContext context) {
    debugPrint(toString());

    final isDesktopStyle = screenStyle.isDesktop;

    // 控制器狀態Provider
    final StateProvider<bool> isOpenControllerProvider =
        StateProvider((ref) => false);

    return CMenuAnchor(
      list: AppBarUserInfo.values,
      builder: (context, controller, child) {
        return Consumer(
          builder: (context, ref, child) {
            final isOpen = ref.watch(isOpenControllerProvider);
            final isOpenNotifier = ref.read(isOpenControllerProvider.notifier);

            final loginInfo = SharedPrefs.getLoginInfo();

            Future.microtask(
              () => isOpen ? controller.open() : controller.close(),
            );

            return CMouseRegion(
              onEnter: (event) => isOpenNotifier.state = true,
              onExit: (event) => isOpenNotifier.state = false,
              child: Row(
                children: [
                  ClipOval(
                    child: Image.network(loginInfo?.uidImage ?? "", width: 24),
                  ),
                  isDesktopStyle
                      ? const SizedBox(width: 8)
                      : const SizedBox.shrink(),
                  isDesktopStyle
                      ? Text(loginInfo?.uid ?? "",
                          style: QppTextStyles.mobile_14pt_body_white_L)
                      : const SizedBox.shrink(),
                  isDesktopStyle
                      ? Row(children: [
                          const SizedBox(width: 4),
                          Image.asset(QPPImages.desktop_icon_arrowdown)
                        ])
                      : const SizedBox.shrink(),
                ],
              ),
            );
          },
        );
      },
      isOpenControllerProvider: isOpenControllerProvider,
      onTap: (BuildContext context, _) =>
          showLogoutDialog(context, screenStyle: screenStyle),
    );
  }
}

// -----------------------------------------------------------------------------
/// 語系下拉選單
// -----------------------------------------------------------------------------
class LanguageDropdownMenu extends StatelessWidget {
  const LanguageDropdownMenu(this.screenStyle, {super.key});

  final ScreenStyle screenStyle;

  @override
  Widget build(BuildContext context) {
    // debugPrint(toString());

    final isDesktopStyle = screenStyle.isDesktop;

    // 控制器狀態Provider
    final StateProvider<bool> isOpenControllerProvider =
        StateProvider((ref) => false);

    return CMenuAnchor(
      list: Language.values,
      builder: (context, controller, child) {
        return Consumer(
          builder: (context, ref, child) {
            final isOpen = ref.watch(isOpenControllerProvider);
            final isOpenNotifier = ref.read(isOpenControllerProvider.notifier);

            if (context.isDesktopPlatform) {
              Future.microtask(() {
                // 避免被銷毀時，強制設定會直接死機。
                if (!context.mounted) {
                  return;
                }

                isOpen ? controller.open() : controller.close();
              });
            }

            return CMouseRegion(
              onEnter: (event) => isOpenNotifier.state = true,
              onExit: (event) => isOpenNotifier.state = false,
              child: child,
            );
          },
          child: IconButton(
            onPressed: () =>
                controller.isOpen ? controller.close() : controller.open(),
            icon: Row(
              children: [
                Image.asset(QPPImages.mobile_icon_actionbar_language_normal),
                isDesktopStyle
                    ? Row(children: [
                        const SizedBox(width: 4),
                        Image.asset(QPPImages.desktop_icon_arrowdown)
                      ])
                    : const SizedBox.shrink()
              ],
            ),
          ),
        );
      },
      isOpenControllerProvider: isOpenControllerProvider,
      onTap: (BuildContext context, CMeunAnchorData e) {
        var locale = (e as Language).locale;
        // context 設定 locale
        context.setLocale(locale);
        // 更新網址列
        DisplayUrl.updateParam('lang', locale.toString());
      },
    );
  }
}

// -----------------------------------------------------------------------------
/// 判斷手勢是否在元件上
// -----------------------------------------------------------------------------
class MouseRegionCustomWidget extends ConsumerWidget {
  MouseRegionCustomWidget({
    super.key,
    required this.builder,
    this.onEnter,
    this.onExit,
    this.onTap,
  });

  final Widget Function(PointerEvent isHovered) builder;

  final void Function(PointerEnterEvent event)? onEnter;

  final void Function(PointerExitEvent event)? onExit;

  final void Function()? onTap;

  /// 滑鼠狀態Provider
  final StateNotifierProvider<MouseRegionStateNotifier, PointerEvent>
      mouseRegionProvider =
      StateNotifierProvider((ref) => MouseRegionStateNotifier());

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // debugPrint(toString());

    final notifier = ref.read(mouseRegionProvider.notifier);

    final PointerEvent event = ref.watch(mouseRegionProvider);

    return CMouseRegion(
      onEnter: (event) {
        onEnter != null ? onEnter!(event) : ();
        notifier.onEnter();
      },
      onExit: (event) {
        onExit != null ? onExit!(event) : ();
        notifier.onExit();
      },
      onTap: () {
        onExit != null ? onTap!() : ();
        notifier.onExit();
      },
      child: builder(event),
    );
  }
}

// -----------------------------------------------------------------------------
/// 全螢幕選單按鈕頁面 (手機樣式才會出現)
// -----------------------------------------------------------------------------
class FullScreenMenuBtnPage extends ConsumerWidget {
  const FullScreenMenuBtnPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isOpenAppBarMenuBtnPage =
        ref.watch(isOpenAppBarMenuBtnPageProvider);
    final isOpenAppBarMenuBtnNotifier =
        ref.read(isOpenAppBarMenuBtnPageProvider.notifier);

    return isOpenAppBarMenuBtnPage
        ? ColoredBox(
            color: const Color.fromARGB(255, 23, 57, 117).withOpacity(0.9),
            child: Stack(
              children: [
                const SizedBox(
                  height: kToolbarMobileHeight,
                  child: Row(
                    children: [
                      // 最左邊間距
                      SizedBox(width: 29),
                      _Logo(ScreenStyle.mobile),
                      Spacer(),
                      // 三條 or 最右邊間距
                      AnimationMenuBtn(isClose: true),
                      SizedBox(width: 24)
                    ],
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: MainMenu.values
                        .map(
                          (e) => TextButton(
                            onPressed: () {
                              isOpenAppBarMenuBtnNotifier.toggle();

                              BuildContext? currentContext = e.currentContext;
                              bool isHomePage = currentContext != null;

                              if (!isHomePage) {
                                context.goNamed(QppGoRouter.home);
                              }

                              /// 延遲等待跳轉完，重新抓currentContext
                              Future.delayed(
                                  Duration(milliseconds: isHomePage ? 0 : 300),
                                  () {
                                currentContext = e.currentContext;
                                if (currentContext != null) {
                                  Scrollable.ensureVisible(currentContext!,
                                      duration: const Duration(seconds: 1));
                                }
                              });
                            }.throttleWithTimeout(timeout: 2000),
                            child: Padding(
                              padding: const EdgeInsets.all(25),
                              child: Text(
                                context.tr(e.text),
                                style: QppTextStyles.web_20pt_title_m_white_C,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}

/// 客製化滑鼠區域
///
/// - Note: 將手機平台變成點擊手勢
class CMouseRegion extends StatelessWidget {
  const CMouseRegion({
    super.key,
    this.child,
    this.onEnter,
    this.onExit,
    this.onHover,
    this.onTap,
  });

  final Widget? child;
  final void Function(PointerEnterEvent)? onEnter;
  final void Function(PointerExitEvent)? onExit;
  final void Function(PointerHoverEvent)? onHover;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return context.isDesktopPlatform
        ? MouseRegion(
            onEnter: (event) => onEnter != null ? onEnter!(event) : null,
            onExit: (event) => onExit != null ? onExit!(event) : null,
            onHover: (event) => onHover != null ? onHover!(event) : null,
            child: child,
          )
        : GestureDetector(
            onTap: () => onTap != null ? onTap!() : null, child: child);
  }
}
