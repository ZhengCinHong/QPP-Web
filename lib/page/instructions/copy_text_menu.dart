import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:qpp_example/extension/string/text.dart';

class CopyTextMenu extends StatefulWidget {
  final String text;
  final TextStyle textStyle;

  final String tipText;
  final TextStyle tipTextStyle;

  final DecorationImage tipBackgroundImage;

  final ScrollController scrollController;

  final VoidCallback onTap;

  const CopyTextMenu({
    super.key,
    required this.text,
    required this.textStyle,
    required this.tipText,
    required this.tipTextStyle,
    required this.scrollController,
    required this.onTap,
  }) : tipBackgroundImage = const DecorationImage(
          image: AssetImage('assets/bg-dialog.png'),
          fit: BoxFit.fill,
        );

  @override
  // ignore: library_private_types_in_public_api
  _CopyTextMenuState createState() => _CopyTextMenuState();
}

class _CopyTextMenuState extends State<CopyTextMenu>
    with SingleTickerProviderStateMixin {
  late GlobalKey _key;
  bool isMenuOpen = false;
  late Offset buttonPosition;
  late Size buttonSize;
  late OverlayEntry _overlayEntry;
  late Point tipPoint;
  Timer? _timer;

  @override
  void initState() {
    _key = LabeledGlobalKey("copy_text_button");

    // 滾動時位移彈出視窗
    widget.scrollController.addListener(() {
      if (isMenuOpen == false) {
        return;
      }
      Overlay.of(context).setState(() {
        // 強制更新 OverlayEntry 狀態
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _closeMenu();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _key,
      child: InkWell(
        child: Text(
          widget.text,
          style: widget.textStyle,
        ),
        onTap: () {
          if (!isMenuOpen) {
            widget.onTap();
            _openMenu();
            _startTimer();
          }
        },
      ),
    );
  }
}

/// 其他私有方法
extension _CopyTextMenuStatePrivateFunctions on _CopyTextMenuState {
  // 啟動 Timer
  void _startTimer() {
    const duration = Duration(seconds: 2);
    _timer?.cancel();

    _timer = Timer.periodic(duration, (timer) {
      _closeMenu();
      _timer?.cancel();
    });
  }

  void _findButton() {
    final renderObject = _key.currentContext?.findRenderObject();
    if (renderObject != null) {
      RenderBox renderBox = renderObject as RenderBox;
      buttonSize = renderBox.size;
      buttonPosition = renderBox.localToGlobal(Offset.zero);
    }
  }

  void _closeMenu() {
    if (isMenuOpen == true) {
      _overlayEntry.remove();
    }
    isMenuOpen = !isMenuOpen;
  }

  void _openMenu() async {
    _overlayEntry = _overlayEntryBuilder();
    Overlay.of(context).insert(_overlayEntry);
    isMenuOpen = !isMenuOpen;
  }

  // 創建彈窗
  OverlayEntry _overlayEntryBuilder() {
    const arrowSize = Size(17, 17 / 2);
    const textPadding = EdgeInsets.fromLTRB(32, 8, 32, 14);

    final size = widget.tipText.size(widget.tipTextStyle);
    final textHieght =
        size.height + textPadding.bottom + textPadding.top + arrowSize.height;

    // 寬與高
    final width = size.width + textPadding.left + textPadding.right;
    final height = size.height + textPadding.top + textPadding.bottom;

    return OverlayEntry(
      builder: (context) {
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            _findButton();

            final top = buttonPosition.dy - textHieght;
            final left = buttonPosition.dx -
                ((size.width / 2) + textPadding.left) +
                (buttonSize.width / 2);

            // 計算彈出視窗是否被左右遮擋
            double offset = 0;
            if ((left + width) > constraints.biggest.width) {
              offset =
                  (left + width + 5) - constraints.biggest.width; // 5 為 padding
            }
            if (left < 0) {
              offset = left - 5; // 5 為 padding
            }

            // 記錄目前點擊資訊
            tipPoint = Point(left - offset, top);

            return Container(
              alignment: Alignment.topLeft,
              child: Material(
                color: Colors.white.withOpacity(0),
                child: Container(
                  margin: EdgeInsets.only(
                    top: tipPoint.y.toDouble(),
                    left: tipPoint.x.toDouble(),
                  ),
                  child: Container(
                    width: width,
                    height: height,
                    padding: textPadding,
                    decoration: BoxDecoration(
                      image: widget.tipBackgroundImage,
                    ),
                    child: Text(
                      widget.tipText,
                      style: widget.tipTextStyle,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
