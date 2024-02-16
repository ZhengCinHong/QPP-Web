import 'package:flutter/material.dart';

/// Instructions Page 載入用
class InstructionsFrame extends StatelessWidget {
  final WidgetBuilder child;
  final Future libFuture;

  const InstructionsFrame(
      {super.key, required this.child, required this.libFuture});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: libFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return child.call(context);
          }
          return const Material(child: Center(child: Text('Loading...')));
        });
  }
}
