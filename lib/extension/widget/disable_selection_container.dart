import 'package:flutter/material.dart';

extension DisableSelectionContainer on Widget {
  /// 移除選取容器
  Widget get disabledSelectionContainer =>
      SelectionContainer.disabled(child: this);
}
