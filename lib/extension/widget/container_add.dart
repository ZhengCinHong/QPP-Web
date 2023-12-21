import 'package:flutter/widgets.dart';

/// 容器新增的方法
extension ContainerAddFunction on Container {
  Container addDesktopBgKvBackgroundImage() {
    const decorationImage = DecorationImage(
      image: AssetImage('assets/desktop-bg-kv-2.png'),
      fit: BoxFit.cover,
    );

    return Container(
      decoration: const BoxDecoration(
        image: decorationImage,
      ),
      child: this,
    );
  }
}
