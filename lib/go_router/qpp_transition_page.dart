import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qpp_example/common_ui/qpp_transition_view/qpp_transition_view.dart';

/// QPP過渡動畫
class QPPTransitionPage extends NoTransitionPage<void> {
  QPPTransitionPage({
    required Widget child,
  }) : super(
          child: Stack(children: [child, const QPPTransitionView()]),
        );
}
