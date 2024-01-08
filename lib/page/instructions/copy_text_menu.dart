import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:qpp_example/extension/string/text.dart';
import 'package:qpp_example/utils/qpp_image.dart';

class CopyTextMenu extends StatefulWidget {
  final String tipText;
  final TextStyle tipTextStyle;
  final DecorationImage tipBackgroundImage;
  final ScrollController scrollController;

  const CopyTextMenu({
    super.key,
    required this.tipText,
    required this.tipTextStyle,
    required this.scrollController,
  }) : tipBackgroundImage = const DecorationImage(
          image: AssetImage(QPPImages.bg_dialog),
          fit: BoxFit.fill,
        );

  @override
  // ignore: library_private_types_in_public_api
  CopyTextMenuState createState() => CopyTextMenuState();
}

class CopyTextMenuState extends State<CopyTextMenu>
    with SingleTickerProviderStateMixin {
  late GlobalKey _key;
  late Offset _buttonPosition;
  late Size _buttonSize;
  late OverlayEntry _overlayEntry;

  bool _isMenuOpen = false;
  Timer? _timer;

  /// 顯示提示
  void showTip(GlobalKey key) {
    _key = key;

    if (!_isMenuOpen) {
      _openMenu();
      _startTimer();
    }
  }

  @override
  void initState() {
    // 滾動時位移彈出視窗
    widget.scrollController.addListener(_onScrollControllerValueChanged);
    super.initState();
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScrollControllerValueChanged);
    _closeMenu();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }

  // 滾動變化事件
  void _onScrollControllerValueChanged() {
    if (_isMenuOpen == false || !mounted) {
      return;
    }
    Overlay.of(context).setState(() {
      // 強制更新 OverlayEntry 狀態
    });
  }
}

/// 其他私有方法
extension _CopyTextMenuStatePrivateFunctions on CopyTextMenuState {
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
      _buttonSize = renderBox.size;
      _buttonPosition = renderBox.localToGlobal(Offset.zero);
    }
  }

  void _closeMenu() {
    if (_isMenuOpen == true) {
      _overlayEntry.remove();
    }
    _isMenuOpen = !_isMenuOpen;
  }

  void _openMenu() async {
    _overlayEntry = _overlayEntryBuilder();
    Overlay.of(context).insert(_overlayEntry);
    _isMenuOpen = !_isMenuOpen;
  }

  // 創建彈窗
  OverlayEntry _overlayEntryBuilder() {
    const textPadding = EdgeInsets.fromLTRB(32, 8, 32, 14);

    final size = widget.tipText.size(widget.tipTextStyle);

    return OverlayEntry(
      builder: (context) {
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            // 尋找按鈕
            _findButton();

            final defaultTipMaxWidth = constraints.biggest.width / 3;
            final tipWidth = min(defaultTipMaxWidth, size.width);
            final tipHeight = widget.tipText
                .size(widget.tipTextStyle, maxWidth: tipWidth)
                .height;

            // 寬與高
            final width = tipWidth + textPadding.left + textPadding.right;
            final height = tipHeight + textPadding.top + textPadding.bottom;

            final top = _buttonPosition.dy - height;
            final left = _buttonPosition.dx -
                ((tipWidth / 2) + textPadding.left) +
                (_buttonSize.width / 2);

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
            final tipPoint = Point(left - offset, top);

            return Container(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(
                  top: tipPoint.y.toDouble(),
                  left: tipPoint.x.toDouble(),
                ),
                child: Container(
                  width: width,
                  padding: textPadding,
                  decoration: BoxDecoration(
                    image: widget.tipBackgroundImage,
                  ),
                  child: Material(
                    color: Colors.white.withOpacity(0),
                    textStyle: widget.tipTextStyle,
                    child: Text(
                      widget.tipText,
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
