import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qpp_example/utils/qpp_image.dart';

/// QPP過場畫面
class QPPTransitionView extends StatefulWidget {
  const QPPTransitionView({super.key});

  @override
  State<QPPTransitionView> createState() => _QPPTransitionViewState();
}

class _QPPTransitionViewState extends State<QPPTransitionView>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  bool animationIsCompleted = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          animationIsCompleted = true;
        });
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return animationIsCompleted
        ? const SizedBox.shrink()
        : Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF12162e), Color(0xFF12162e)],
              ),
            ),
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return LayoutBuilder(builder: (context, constraints) {
                  final centerY = constraints.maxWidth / 2;
                  final originY = -120 + centerY;

                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        left: Tween<double>(begin: originY, end: centerY - 62)
                            .animate(_controller)
                            .value,
                        child: Image.asset(
                          QPPImages.pic_animation_icon,
                          fit: BoxFit.cover,
                          width: 62,
                        ),
                      ),
                      Positioned(
                        right: Tween<double>(begin: originY, end: centerY - 83)
                            .animate(_controller)
                            .value,
                        child: Image.asset(
                          QPPImages.pic_animation_qpp,
                          width: 83,
                        ),
                      ),
                    ],
                  );
                });
              },
            ),
          );
  }
}
