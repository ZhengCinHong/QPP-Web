import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qpp_example/common_ui/qpp_menu/c_menu_anchor.dart';
import 'package:qpp_example/common_view_model/auth_service/view_model/auth_service_view_model.dart';
import 'package:qpp_example/constants/server_const.dart';
import 'package:qpp_example/extension/build_context.dart';
import 'package:qpp_example/extension/string/url.dart';
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

AppBar qppAppBar(bool isDesktop) {
  return AppBar(
    automaticallyImplyLeading: false, // 關閉返回按鈕
    toolbarHeight: isDesktop ? kToolbarDesktopHeight : kToolbarMobileHeight,
    backgroundColor: QppColors.barMask,
    title: isDesktop
        ? const _QppAppBarTitle.desktop()
        : const _QppAppBarTitle.mobile(),
    titleSpacing: 0,
  );
}

// -----------------------------------------------------------------------------
/// QppAppBarTitle
// -----------------------------------------------------------------------------
class _QppAppBarTitle extends ConsumerWidget {
  const _QppAppBarTitle.desktop() : screenStyle = ScreenStyle.desktop;
  const _QppAppBarTitle.mobile() : screenStyle = ScreenStyle.mobile;

  final ScreenStyle screenStyle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // debugPrint(toString());

    final bool isDesktopStyle = screenStyle.isDesktop;

    final bool isOpenAppBarMenuBtnPage =
        ref.watch(isOpenAppBarMenuBtnPageProvider);

    final checkLoginTokenState = ref.watch(
        authServiceProvider.select((value) => value.checkLoginTokenState));

    final bool isLogin = ((SharedPrefs.getLoginInfo()?.isLogin == true) ||
        (checkLoginTokenState.data?.isSuccess == true));

    return Row(
      children: [
        // 最左邊間距
        isDesktopStyle ? const Spacer(flex: 320) : const SizedBox(width: 29),
        isDesktopStyle
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
            : Opacity(
                opacity: isOpenAppBarMenuBtnPage ? 0 : 1,
                child: const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: AnimationMenuBtn(isClose: false),
                ),
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
      onPressed: () => Uri.base.path == QppGoRouter.home
          ? null
          : ServerConst.testRouterHost.launchURL(isNewTab: false),
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

  /// 滑動到context
  void scrollToContext(BuildContext context) {
    Scrollable.ensureVisible(
      context,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint(toString());
    final bool isHorizontal = _direction == Axis.horizontal;

    return Flex(
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
                    child: Consumer(builder: (context, ref, child) {
                      final scrollToContextNotifier =
                          ref.read(scrollToContextProvider.notifier);

                      return GestureDetector(
                          onTap: () {
                            final bool isHomePage =
                                Uri.base.path == QppGoRouter.home;

                            if (isHomePage) {
                              if (e.currentContext != null) {
                                scrollToContextNotifier.state = e;
                              }
                            } else {
                              if (context.canPop()) {
                                context.pop();
                              } else {
                                context.go(QppGoRouter.home);
                              }

                              Future.delayed(
                                const Duration(milliseconds: 300),
                                () => e.currentContext != null
                                    ? scrollToContextNotifier.state = e
                                    : null,
                              );
                            }
                          }.throttleWithTimeout(timeout: 1000),
                          child: _MenuBtnText(
                            type: e,
                            isHorizontal: isHorizontal,
                            event: event,
                            fontSize: fontSize,
                          ));
                    }),
                  ),
                ),
                _MenuBtnSpacing(
                  type: e,
                  isHorizontal: isHorizontal,
                  padding: padding,
                )
              ],
            ),
          )
          .toList(),
    );
  }
}

/// 選單按鈕間距(目前horizontal是toolbar，vertical是手機樣式的首頁頁尾)
class _MenuBtnText extends StatelessWidget {
  const _MenuBtnText({
    required this.type,
    required this.isHorizontal,
    required this.event,
    required this.fontSize,
  });

  final MainMenu type;
  final bool isHorizontal;
  final PointerEvent event;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: isHorizontal ? Alignment.center : null,
      width: isHorizontal
          ? 120.getRealWidth(screenWidth: MediaQuery.of(context).size.width)
          : 120,
      height: isHorizontal ? kToolbarDesktopHeight - 10 : null,
      child: AutoSizeText(
        key: type.key,
        context.tr(type.text),
        style: TextStyle(
          color: event is PointerEnterEvent
              ? QppColors.canaryYellow
              : QppColors.white,
          fontSize: fontSize,
        ),
        softWrap: true,
        overflow: TextOverflow.clip,
      ).disabledSelectionContainer,
    );
  }
}

/// 選單按鈕間距
class _MenuBtnSpacing extends StatelessWidget {
  const _MenuBtnSpacing({
    required this.type,
    required this.isHorizontal,
    required this.padding,
  });

  final MainMenu type;
  final bool isHorizontal;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: type == MainMenu.contact
            ? double.infinity
            : (isHorizontal
                ? padding.getRealWidth(
                    screenWidth: MediaQuery.of(context).size.width)
                : double.infinity),
        maxHeight: type == MainMenu.contact
            ? double.infinity
            : (isHorizontal ? double.infinity : padding),
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
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    // 只針對非彈窗按鈕，瀏覽器拉縮時要顯示動畫。(close->menu)
    if (!widget.isClose) {
      _controller.forward(from: 1.0);
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final notifier = ref.read(isOpenAppBarMenuBtnPageProvider.notifier);
        final isOpenAppBarMenuBtnPage =
            ref.watch(isOpenAppBarMenuBtnPageProvider);

        // 處理播放動畫
        if (isOpenAppBarMenuBtnPage) {
          _controller.forward();
        } else {
          _controller.reverse();
        }

        return InkWell(
          child: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: _controller,
            size: 24,
            color: Colors.white,
          ),
          onTap: () {
            notifier.toggle();
          },
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

    final loginInfo = SharedPrefs.getLoginInfo();

    return MouseRegionCustomWidget(
      builder: (e) => CMenuAnchor(
        list: AppBarUserInfo.values,
        builder: (context, controller, child) {
          return Consumer(
            builder: (context, ref, child) {
              final isOpen = ref.watch(isOpenControllerProvider);
              final isOpenNotifier =
                  ref.read(isOpenControllerProvider.notifier);

              Future.microtask(
                () => isOpen ? controller.open() : controller.close(),
              );

              return CMouseRegion(
                onEnter: (event) => isOpenNotifier.state = true,
                onExit: (event) => isOpenNotifier.state = false,
                child: Row(
                  children: [
                    ClipOval(
                      child: Image.network(
                        loginInfo?.uidImage ?? "",
                        width: 24,
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset(
                          QPPImages.mobile_icon_actionbar_profile_login_default,
                        ),
                      ),
                    ),
                    isDesktopStyle
                        ? const SizedBox(width: 8)
                        : const SizedBox.shrink(),
                    isDesktopStyle
                        ? Text(
                            loginInfo?.hiddenUID ?? "",
                            style: e is PointerEnterEvent
                                ? QppTextStyles.mobile_14pt_body_canary_yellow_L
                                : QppTextStyles.mobile_14pt_body_white_L,
                          )
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
      ),
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
class MouseRegionCustomWidget extends StatefulWidget {
  const MouseRegionCustomWidget({
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

  @override
  State<MouseRegionCustomWidget> createState() =>
      _MouseRegionCustomWidgetState();
}

class _MouseRegionCustomWidgetState extends State<MouseRegionCustomWidget> {
  PointerEvent event = const PointerExitEvent();

  void enter() {
    setState(() {
      event = const PointerEnterEvent();
    });
  }

  void exit() {
    setState(() {
      event = const PointerExitEvent();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CMouseRegion(
      onEnter: (event) {
        widget.onEnter != null ? widget.onEnter!(event) : ();
        enter();
      },
      onExit: (event) {
        widget.onExit != null ? widget.onExit!(event) : ();
        exit();
      },
      onTap: () {
        widget.onExit != null ? widget.onTap!() : ();
        exit();
      },
      child: widget.builder(event),
    );
  }
}

// -----------------------------------------------------------------------------
/// 全螢幕選單按鈕頁面 (手機樣式才會出現)
// -----------------------------------------------------------------------------
class FullScreenMenuBtnPage extends StatefulWidget {
  const FullScreenMenuBtnPage({super.key});

  @override
  State<FullScreenMenuBtnPage> createState() => _FullScreenMenuBtnPageState();
}

class _FullScreenMenuBtnPageState extends State<FullScreenMenuBtnPage>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 800),
    vsync: this,
  );

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  late bool _isInitState;

  @override
  void initState() {
    super.initState();

    _isInitState = true;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final isOpenAppBarMenuBtnPage =
          ref.watch(isOpenAppBarMenuBtnPageProvider);
      final isOpenAppBarMenuBtnNotifier =
          ref.read(isOpenAppBarMenuBtnPageProvider.notifier);

      // 強制處理介面被回收時，參數需要重置。
      if (_isInitState) {
        _isInitState = false;

        if (isOpenAppBarMenuBtnPage) {
          Future.microtask(() {
            // 避免被銷毀時，強制設定會直接死機。
            if (!context.mounted) {
              return;
            }
            isOpenAppBarMenuBtnNotifier.toggle();
          });

          return const SizedBox.shrink();
        }
      }

      // 播放動畫
      if (isOpenAppBarMenuBtnPage) {
        _controller.reset();
        _controller.forward();
      }

      return isOpenAppBarMenuBtnPage
          ? SizeTransition(
              sizeFactor: _animation,
              axis: Axis.vertical,
              axisAlignment: -1,
              child: Stack(
                children: [
                  const Scaffold(
                    backgroundColor: Color.fromARGB(153, 0, 0, 0),
                    body: SizedBox(
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
                                bool isHomePage =
                                    Uri.base.path == QppGoRouter.home;

                                if (!isHomePage) {
                                  ServerConst.testRouterHost
                                      .launchURL(isNewTab: false);
                                }

                                /// 延遲等待跳轉完，重新抓currentContext
                                Future.delayed(
                                    Duration(
                                        milliseconds: isHomePage ? 0 : 300),
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
    });
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
