import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qpp_example/common_ui/qpp_button/c_button.dart';
import 'package:qpp_example/extension/build_context.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:qpp_example/utils/qpp_color.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';

/// 客製化對話框動作
class CDialogAction {
  const CDialogAction({required this.style, required this.callback});

  final CDialogActionStyle style;
  final void Function()? callback;
}

enum CDialogActionStyle {
  /// 確定
  confirm,

  /// 取消
  cancel,

  /// 登出
  logout;

  String text(BuildContext context) => switch (this) {
        CDialogActionStyle.confirm => context.tr(QppLocales.alertConfirm),
        CDialogActionStyle.cancel => context.tr(QppLocales.alertCancel),
        CDialogActionStyle.logout => context.tr(QppLocales.alertLogout)
      };

  TextStyle get textstyle {
    return switch (this) {
      CDialogActionStyle.confirm ||
      CDialogActionStyle.cancel =>
        QppTextStyles.mobile_16pt_title_white_bold_L,
      CDialogActionStyle.logout => QppTextStyles.web_16pt_body_maya_blue_R
    };
  }

  Color get borderColor {
    return switch (this) {
      CDialogActionStyle.confirm ||
      CDialogActionStyle.cancel =>
        QppColors.darkPastelBlue,
      CDialogActionStyle.logout => QppColors.mayaBlue
    };
  }
}

/// 對話框動作按鈕
class DialogActionButton extends StatelessWidget {
  const DialogActionButton({
    super.key,
    required this.style,
    required this.height,
    required this.width,
    this.onTap,
  });

  final CDialogActionStyle style;
  final double height;
  final double width;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return CButton.rectangle(
      width: width,
      height: height,
      border: Border.all(color: style.borderColor),
      text: style.text(context),
      textStyle: style.textstyle,
      onTap: onTap,
    );
  }
}
