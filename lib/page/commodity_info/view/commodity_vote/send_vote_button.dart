import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qpp_example/common_ui/qpp_button/c_button.dart';
import 'package:qpp_example/common_view_model/auth_service/view_model/auth_service_view_model.dart';
import 'package:qpp_example/extension/build_context.dart';
import 'package:qpp_example/extension/throttle_debounce.dart';
import 'package:qpp_example/extension/void/dialog_void.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:qpp_example/model/enum/item/vote_type.dart';
import 'package:qpp_example/model/vote/qpp_vote.dart';
import 'package:qpp_example/page/commodity_info/model/vote_model.dart';
import 'package:qpp_example/page/commodity_info/view/commodity_info_body.dart';
import 'package:qpp_example/utils/qpp_color.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';
import 'package:qpp_example/utils/screen.dart';
import 'package:qpp_example/utils/shared_prefs_utils.dart';

/// 送出投票按鈕
class SendVoteButton extends StatelessWidget {
  const SendVoteButton.desktop({super.key}) : screenStyle = ScreenStyle.desktop;
  const SendVoteButton.mobile({super.key}) : screenStyle = ScreenStyle.mobile;

  final ScreenStyle screenStyle;

  @override
  Widget build(BuildContext context) {
    final isDesktopStyle = screenStyle.isDesktop;

    return Consumer(
      builder: (context, ref, child) {
        final QppVote? qppVote = ref.watch(
            itemSelectInfoProvider.select((value) => value.voteDataState.data));

        /// 是選項成功(代表都已經選擇)
        final isOptionsSuccess =
            qppVote?.voteArrayData != null && qppVote?.haveOptionError == false;

        /// 是選項錯誤陣列
        final isOptionErrorArray = ref.watch(
            itemSelectInfoProvider.select((value) => value.isOptionErrorArray));

        /// 投票狀態(是否已投票，是否成功)
        final votedState = ref
            .watch(itemSelectInfoProvider.select((value) => value.votedState));

        /// 是第一次登入
        final isFirstLogin = ref.watch(
            itemSelectInfoProvider.select((value) => value.isFirstLogin));

        /// 拿取Login Token
        final getLoginTokenState = ref.watch(
            authServiceProvider.select((value) => value.getLoginTokenState));

        /// 確認登入狀態
        final checkLoginTokenState = ref.watch(
            authServiceProvider.select((value) => value.checkLoginTokenState));

        /// 是確認登入成功
        final isCheckLoginSuccess =
            checkLoginTokenState.data?.isSuccess == true;

        /// 投票Token
        final String? voteToken =
            ref.watch(authServiceProvider.select((value) => value.voteToken));

        final bool isLogin = SharedPrefs.getLoginInfo()?.isLogin == true;

        /// 判斷是否有對話框正在顯示
        final bool isThereCurrentDialogShowing =
            context.isThereCurrentDialogShowing;

        /// 顯示登入Dialog
        void showLoginDialog() {
          // 如果彈窗已存在，先關閉彈窗
          if (isThereCurrentDialogShowing) {
            context.pop();
          }
          showloginVoteDialog(context,
              screenStyle: screenStyle,
              url: getLoginTokenState.data?.content, closeCallBack: () {
            // 關閉確認登入Timer
            ref.read(authServiceProvider.notifier).cancelTimer();
          });
        }

        Future.microtask(() {
          // 成功取得login toke顯示Login dialog
          if (getLoginTokenState.isCompleted && !isLogin) {
            showLoginDialog();
          } else if (isCheckLoginSuccess && isFirstLogin) {
            // 關閉登入QRCode對話框
            context.pop();

            // 更新是否為第一次登入的值(不打通知更新畫面)
            ref.read(itemSelectInfoProvider.notifier).isFirstLogin = false;

            // 發送投票
            if (voteToken != null && qppVote != null) {
              ref
                  .read(itemSelectInfoProvider.notifier)
                  .sendUserVote(qppVote.item, voteToken);
            }
          } else if (votedState.$1 && isFirstLogin) {
            // 如果彈窗已存在，先關閉彈窗
            if (isThereCurrentDialogShowing) {
              context.pop();
            }

            // 顯示對話框
            if (votedState.$2.displayDialog) {
              votedState.$2 == VotedState.success
                  ? showVoteSuccessDialog(context, screenStyle: screenStyle)
                  : showVoteFailureDialog(context,
                      screenStyle: screenStyle, subText: votedState.$2.message);
            }
          }
        });

        return isLogin || qppVote?.voteType != VoteType.inProgress
            ? const SizedBox.shrink()
            : Padding(
                padding: EdgeInsets.symmetric(
                    vertical: context.isDesktopPlatform ? 36 : 16),
                child: Column(
                  children: [
                    isOptionErrorArray.contains(true) && !isOptionsSuccess
                        ? Text(
                            context.tr(QppLocales.commodityInfoVoteYet),
                            style: isDesktopStyle
                                ? QppTextStyles.web_16pt_body_red_L
                                : QppTextStyles
                                    .mobile_14pt_body_outrageous_orange_L,
                          )
                        : const SizedBox.shrink(),
                    const SizedBox(height: 16),
                    CButton.rectangle(
                      width: isDesktopStyle ? 360 : 291,
                      height: isDesktopStyle ? 52 : 44,
                      color: QppColors.mayaBlue,
                      text: context.tr(QppLocales.commodityInfoVoteSubmit),
                      textStyle: isDesktopStyle
                          ? QppTextStyles.web_20pt_title_m_oxford_blue_C
                          : QppTextStyles.mobile_18pt_title_m_oxford_blue_C,
                      onTap: () {
                        if (isOptionsSuccess) {
                          if (getLoginTokenState.isCompleted) {
                            if (!isLogin) {
                              showLoginDialog();
                            }
                          } else {
                            ref.read(authServiceProvider.notifier).getLoginToken(
                                '${context.locale.languageCode}-${context.locale.countryCode}');
                          }
                        } else {
                          ref
                              .watch(itemSelectInfoProvider.notifier)
                              .setupErrorOptions();
                        }
                      }.throttle(),
                    ),
                  ],
                ),
              );
      },
    );
  }
}
