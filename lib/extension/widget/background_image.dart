import 'package:flutter/material.dart';

/// 新增背景圖
extension ContainerAddFunction on Widget {
  Container addBackgroundImage(String image) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
      child: this,
    );
  }
}
