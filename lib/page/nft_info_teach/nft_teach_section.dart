import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qpp_example/common_ui/qpp_button/btn_arrow_up_down.dart';
import 'package:qpp_example/utils/qpp_color.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';

/// NFT 教學 Section 抽象類
abstract class NFTTeachSection<T> extends StatefulWidget {
  final Widget child;
  final bool isDesktop;

  const NFTTeachSection.desktop({Key? key, required this.child})
      : isDesktop = true,
        super(key: key);
  const NFTTeachSection.mobile({Key? key, required this.child})
      : isDesktop = false,
        super(key: key);
}

/// NFTTeachStateSection 抽象類
abstract class StateTeachSection extends State<NFTTeachSection>
    with TickerProviderStateMixin {
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
    return Container(
      decoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          color: QppColors.prussianBlue,
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      // color: QppColors.prussianBlue,
      padding: contentPadding,
      child: Column(children: [
        NFTTeachInfoSectionItemTitle(
          arrowKey: arrowKey,
          // section title
          title: sectionTitle,
          isDesktop: widget.isDesktop,
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
          child: Container(child: widget.child),
        ),
      ]),
    );
  }

  /// 上方 section title
  String get sectionTitle;

  bool get isDesktop {
    return widget.isDesktop;
  }

  EdgeInsets get contentPadding {
    return widget.isDesktop
        ? const EdgeInsets.fromLTRB(37, 30, 58, 40)
        : const EdgeInsets.fromLTRB(25, 24, 25, 32);
  }
}

/// NFT Section title 元件
class NFTTeachInfoSectionItemTitle extends StatelessWidget {
  // title
  final String title;

  final GlobalKey arrowKey;

  final bool isDesktop;

  final Function()? onTap;

  const NFTTeachInfoSectionItemTitle(
      {Key? key,
      required this.arrowKey,
      required this.title,
      required this.isDesktop,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Container(
        // height: 44.0,
        decoration: const BoxDecoration(color: QppColors.stPatricksBlue),
        child: Row(
          children: [
            Text(
              title,
              style: QppTextStyles.web_20pt_title_bold_m_white_C,
            ),
            const Expanded(child: SizedBox()),
            // 上/下箭頭
            BtnArrowUpDown(key: arrowKey, size: _arrowSize),
          ],
        ),
      ),
    );
  }

  double get _arrowSize {
    return isDesktop ? 20 : 16;
  }
}
