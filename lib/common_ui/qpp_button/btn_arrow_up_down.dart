import 'package:flutter/widgets.dart';
import 'package:qpp_example/utils/qpp_image.dart';

const String _arrowUp = QPPImages.desktop_icon_list_selection_arrow_up;
const String _arrowDown = QPPImages.desktop_icon_list_selection_arrow_down;

/// 點擊變換上下箭頭元件
/// 預設為向上, 若要預設向下請使用 [ClickArrow.defaultDown]
class BtnArrowUpDown extends StatefulWidget {
  // 箭頭大小
  final double size;
  final bool showUp;

  /// Called when state change between expanded/compress
  final Function(bool val)? callback;

  /// 外部傳入點擊事件
  final Function()? onTap;

  const BtnArrowUpDown(
      {Key? key, required this.size, this.callback, this.onTap})
      : showUp = true,
        super(key: key);
  const BtnArrowUpDown.defaultDown(
      {Key? key, required this.size, this.callback, this.onTap})
      : showUp = false,
        super(key: key);
  // 取得箭頭 path
  String get _arrowPath {
    return showUp ? _arrowUp : _arrowDown;
  }

  @override
  StateClickArrow createState() => StateClickArrow();
}

class StateClickArrow extends State<BtnArrowUpDown>
    with TickerProviderStateMixin {
  late bool _isUp;

  void _onTap() {
    setState(() {
      rotate();
    });
  }

  /// 動畫參考出處 https://blog.csdn.net/ww897532167/article/details/125280054

  late final Animation<double> _animation;
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _isUp = widget.showUp;
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _animation =
        // 若預設為往下箭頭, 結束位置反轉
        Tween<double>(begin: 0, end: widget._arrowPath == _arrowUp ? 0.5 : -0.5)
            .animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap ?? _onTap,
      child: RotationTransition(
        turns: _animation,
        child: Image.asset(
          widget._arrowPath,
          width: widget.size,
          height: widget.size,
        ),
      ),
    );
  }

  /// 旋轉
  rotate() {
    setState(() {
      _isUp ? _animationController.forward() : _animationController.reverse();
      _isUp = !_isUp;
      widget.callback?.call(_isUp);
    });
  }
}
