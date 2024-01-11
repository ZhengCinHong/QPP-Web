import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qpp_example/common_ui/qpp_button/dialog_action_button.dart';
import 'package:qpp_example/common_ui/qpp_dialog/c_actions_dialog.dart';
import 'package:qpp_example/common_ui/qpp_dialog/c_image_dialog.dart';
import 'package:qpp_example/common_ui/qpp_dialog/open_qpp_dialog.dart';
import 'package:qpp_example/common_ui/qpp_dialog/qrcode_dialog.dart';
import 'package:qpp_example/common_view_model/auth_service/view_model/auth_service_view_model.dart';
import 'package:qpp_example/extension/build_context.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:qpp_example/utils/qpp_image.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';
import 'package:qpp_example/utils/screen.dart';
import 'package:qpp_example/utils/shared_prefs_utils.dart';

extension DialogContext on BuildContext {
  /// 目前對話框是否正在顯示
  bool get isThereCurrentDialogShowing =>
      ModalRoute.of(this)?.isCurrent != true;
}

/// 對話框擴充
extension DialogVoid on void {
  /// 顯示登入投票對話框
  void showloginVoteDialog(
    BuildContext context, {
    required ScreenStyle screenStyle,
    required String url,
    required Function? closeCallBack,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        final text = context.tr(QppLocales.commodityInfoVoteLogin);
        final subText = context.tr(QppLocales.commodityInfoVoteLoginP);
        final timerText =
            '${context.tr(QppLocales.commodityInfoCountdown)}%s${context.tr(QppLocales.commodityInfoSeconds)}';

        // showDialog要加上center不然他不知道位置，會導致設定的寬高的失效
        return Center(
          child: context.isDesktopPlatform
              ? QRCodeDialog(
                  text: text,
                  subText: subText,
                  url: url,
                  timerText: timerText,
                )
              : OpenQppDialog(
                  text: text,
                  subText: subText,
                  url: url,
                  timerText: timerText,
                ),
        );
      },
    ).then((value) {
      if (closeCallBack != null) {
        closeCallBack();
      }
    });
  }

  /// 顯示投票成功對話框
  void showVoteSuccessDialog(
    BuildContext context, {
    required ScreenStyle screenStyle,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        final isDesktopStyle = screenStyle.isDesktop;

        // showDialog要加上center不然他不知道位置，會導致設定的寬高的失效
        return Center(
          child: CImageDialog(
            screenStyle: screenStyle,
            height: isDesktopStyle ? 403 : 379,
            width: isDesktopStyle ? 780 : 327,
            image: QPPImages.pic_successful,
            text: context.tr(QppLocales.commodityInfoVoteSuccess),
            textStyle: isDesktopStyle
                ? QppTextStyles.web_36pt_Display_s_maya_blue_C
                : QppTextStyles.mobile_20pt_title_L_maya_blue_L,
            subText: context.tr(QppLocales.commodityInfoVoteSuccessP),
          ),
        );
      },
    );
  }

  /// 顯示投票失敗對話框
  void showVoteFailureDialog(
    BuildContext context, {
    required ScreenStyle screenStyle,
    required String subText,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        final isDesktopStyle = screenStyle.isDesktop;

        // showDialog要加上center不然他不知道位置，會導致設定的寬高的失效
        return Center(
          child: CImageDialog(
            screenStyle: screenStyle,
            height: isDesktopStyle ? 403 : 379,
            width: isDesktopStyle ? 780 : 327,
            image: QPPImages.pic_fail,
            text: context.tr(QppLocales.commodityInfoVoteCannot),
            textStyle: isDesktopStyle
                ? QppTextStyles.web_36pt_Display_s_outrageous_orange_C
                : QppTextStyles.mobile_20pt_title_L_outrageous_orange_L,
            subText: context.tr(subText),
          ),
        );
      },
    );
  }

  /// 顯示登出對話框
  void showLogoutDialog(
    BuildContext context, {
    required ScreenStyle screenStyle,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        final isDesktopStyle = screenStyle.isDesktop;

        return Consumer(builder: (context, ref, child) {
          // showDialog要加上center不然他不知道位置，會導致設定的寬高的失效
          return Center(
            child: CActionsDialog(
              height: isDesktopStyle ? 217 : 210,
              width: isDesktopStyle ? 540 : 327,
              text: context.tr(QppLocales.alertLogout),
              subText: context.tr(QppLocales.alertLogoutTip),
              actions: [
                CDialogAction(
                  style: CDialogActionStyle.cancel,
                  callback: () => context.pop(),
                ),
                CDialogAction(
                  style: CDialogActionStyle.logout,
                  callback: () {
                    ref
                        .read(authServiceProvider.notifier)
                        .logout(SharedPrefs.getLoginInfo()?.voteToken ?? "");
                    context.pop();
                  },
                )
              ],
            ),
          );
        });
      },
    );
  }
}
