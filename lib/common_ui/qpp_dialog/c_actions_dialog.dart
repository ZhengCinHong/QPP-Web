import 'package:flutter/material.dart';
import 'package:qpp_example/common_ui/qpp_button/dialog_action_button.dart';
import 'package:qpp_example/common_ui/qpp_dialog/c_dialog.dart';
import 'package:qpp_example/extension/build_context.dart';
import 'package:qpp_example/utils/qpp_color.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';

/// 客製化動作對話框
///
/// Note:
/// - 基本標題與內容以及動作按鈕
/// - Web參考: https://app.zeplin.io/project/65372215fc0b981fe82c00f0/screen/6540938bc2f07c20a7efe56b
/// - Mobile參考: https://app.zeplin.io/project/65372215fc0b981fe82c00f0/screen/6541c1beadfd2f2035d7a2d6
class CActionsDialog extends StatelessWidget {
  const CActionsDialog({
    super.key,
    required this.text,
    required this.subText,
    required this.actions,
    required this.height,
    required this.width,
  });

  final String text;
  final String subText;
  final List<CDialogAction> actions;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    final isDesktopPlatform = context.isDesktopPlatform;

    return Container(
      padding: EdgeInsets.only(
        top: isDesktopPlatform ? 25 : 36,
        bottom: 24,
      ),
      constraints: BoxConstraints(maxHeight: height, maxWidth: width),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: QppColors.prussianBlue,
      ),
      child: Column(
        crossAxisAlignment: isDesktopPlatform
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          _CommonPaddingWidget(
            child: Padding(
              padding: EdgeInsets.only(bottom: isDesktopPlatform ? 16 : 17),
              child: CDialogTitle(
                text: text,
                style: isDesktopPlatform
                    ? QppTextStyles.web_24pt_title_L_white_L
                    : QppTextStyles.web_20pt_title_m_white_C,
                alignment:
                    isDesktopPlatform ? Alignment.centerLeft : Alignment.center,
                isShowCloseButton: isDesktopPlatform,
              ),
            ),
          ),
          isDesktopPlatform
              ? UnconstrainedBox(
                  child: Container(
                      height: 1, width: width, color: QppColors.midnightBlue),
                )
              : const SizedBox.shrink(),
          _CommonPaddingWidget(
            child: Column(
              crossAxisAlignment: isDesktopPlatform
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: isDesktopPlatform ? 16 : 0,
                      bottom: isDesktopPlatform ? 28 : 41),
                  child: Text(
                    subText,
                    style: isDesktopPlatform
                        ? QppTextStyles.mobile_16pt_title_pastel_blue
                        : QppTextStyles.mobile_14pt_body_pastel_blue_L,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: (isDesktopPlatform
                          ? <Widget>[const Spacer()]
                          : <Widget>[]) +
                      actions
                          .map(
                            (e) => Padding(
                              padding: EdgeInsets.only(
                                  left: isDesktopPlatform ? 16 : 0),
                              child: DialogActionButton(
                                style: e.style,
                                height: 44,
                                width: isDesktopPlatform ? 124 : 140,
                                onTap: e.callback,
                              ),
                            ),
                          )
                          .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 共用padding
class _CommonPaddingWidget extends StatelessWidget {
  const _CommonPaddingWidget({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isDesktopPlatform = context.isDesktopPlatform;

    return Padding(
      padding: EdgeInsets.only(
        left: isDesktopPlatform ? 28 : 16,
        right: isDesktopPlatform ? 28 : 16,
      ),
      child: child,
    );
  }
}
