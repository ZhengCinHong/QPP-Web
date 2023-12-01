import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qpp_example/common_ui/qpp_transition_view/qpp_transition_view.dart';

class FadeTransitionPage extends CustomTransitionPage<void> {
  FadeTransitionPage({
    required Widget child,
  }) : super(
          transitionsBuilder: (c, animation, a2, child) => FadeTransition(
            opacity: animation.drive(_curveTween),
            child: child,
          ),
          child: Stack(children: [child, const QPPTransitionView()]),
        );

  static final _curveTween = CurveTween(curve: Curves.easeIn);
}
