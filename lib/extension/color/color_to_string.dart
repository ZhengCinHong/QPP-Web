import 'package:flutter/material.dart';

/// 顏色轉成 hex 字串
extension ColorToHexString on Color {
  String toHexString() =>
      '#${(value & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}';
}
