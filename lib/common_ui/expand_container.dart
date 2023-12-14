import 'package:flutter/widgets.dart';
import 'package:qpp_example/common_ui/qpp_button/btn_arrow_up_down.dart';
import 'package:qpp_example/utils/qpp_color.dart';

/// 可點擊收合元件
class ExpandContainer extends StatefulWidget {
  final bool isDesktop;

  /// 上方元件
  final Widget? title;

  /// 內容元件
  final Widget? content;

  /// 上方元件背景顏色
  final Color? titleBackground;

  const ExpandContainer.desktop(
      {super.key, this.title, this.content, this.titleBackground})
      : isDesktop = true;
  const ExpandContainer.mobile(
      {super.key, this.title, this.content, this.titleBackground})
      : isDesktop = false;

  @override
  State<StatefulWidget> createState() => StateExpand();
}

class StateExpand extends State<ExpandContainer> with TickerProviderStateMixin {
// 控制 Section Title 右邊的上下箭頭(指向正確的那個箭頭)
  final arrowKey = GlobalKey<StateClickArrow>();
  late bool expanded;
  late final Animation<double> _animation;
  late final Animation<double> _curve;
  late final AnimationController _scaleAnimationController;

  @override
  void initState() {
    super.initState();
    // 是否展開
    expanded = true;

    // 動畫控制器
    _scaleAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    // 設定動畫
    _curve = CurvedAnimation(
        parent: _scaleAnimationController,
        curve: Curves.easeInOut,
        reverseCurve: Curves.easeInOut);
    // 動畫變化範圍
    _animation = Tween(begin: 1.0, end: 0.0).animate(_curve);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ExpandTitle(
        arrowKey: arrowKey,
        isDesktop: widget.isDesktop,
        title: _itemTitle,
        onTap: () {
          arrowKey.currentState?.rotate();
          setState(() {
            // forward 啟動動畫, reverse 動畫倒轉
            expanded
                ? _scaleAnimationController.forward()
                : _scaleAnimationController.reverse();
            expanded = !expanded;
          });
        },
      ),
      // size 動畫, 參考 https://github.com/YYFlutter/flutter-article/blob/master/article/animation%26motion/Flutter动画SizeTransition详解.md
      SizeTransition(
        sizeFactor: _animation,
        axis: Axis.vertical,
        child: _itemContent,
      ),
    ]);
  }

  //
  Widget get _itemTitle {
    if (widget.title != null) {
      return widget.title!;
    }
    return const SizedBox.shrink();
  }

  Widget get _itemContent {
    if (widget.content != null) {
      return widget.content!;
    }
    return const SizedBox.shrink();
  }
}

class ExpandTitle extends StatelessWidget {
  final GlobalKey arrowKey;
  final bool isDesktop;
  final Widget? title;
  final Function()? onTap;

  const ExpandTitle(
      {super.key,
      required this.arrowKey,
      required this.isDesktop,
      this.title,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Container(
        padding: _padding,
        decoration: const BoxDecoration(color: QppColors.stPatricksBlue),
        child: Row(
          children: [
            _itemTitle,
            const Expanded(child: SizedBox()),
            // 上/下箭頭
            BtnArrowUpDown(key: arrowKey, size: _arrowSize),
          ],
        ),
      ),
    );
  }

  Widget get _itemTitle {
    if (title != null) {
      return title!;
    }
    return const SizedBox.shrink();
  }

  // title 部位的 padding
  EdgeInsets get _padding {
    return isDesktop
        ? const EdgeInsets.only(left: 60.0, right: 60.0)
        : const EdgeInsets.only(left: 12.0, right: 12.0);
  }

  // 上下箭頭尺寸
  double get _arrowSize {
    return isDesktop ? 20 : 16;
  }
}
