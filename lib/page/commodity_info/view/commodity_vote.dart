import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qpp_example/common_ui/qpp_button/open_qpp_button.dart';
import 'package:qpp_example/common_view_model/auth_service/view_model/auth_service_view_model.dart';
import 'package:qpp_example/extension/build_context.dart';
import 'package:qpp_example/extension/throttle_debounce.dart';
import 'package:qpp_example/extension/void/dialog_void.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:qpp_example/page/commodity_info/view/commodity_body_top.dart';
import 'package:qpp_example/page/commodity_info/view/commodity_info_body.dart';
import 'package:qpp_example/page/commodity_info/view/commodity_vote/vote_options.dart';
import 'package:qpp_example/page/commodity_info/view/commodity_vote/vote_state.dart';
import 'package:qpp_example/page/commodity_info/view/info_row.dart';
import 'package:qpp_example/utils/qpp_color.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';
import 'package:qpp_example/utils/screen.dart';
import 'package:qpp_example/utils/shared_prefs_utils.dart';

/// 問券調查(投票)資訊
class VoteItemInfo extends StatelessWidget {
  const VoteItemInfo.desktop({super.key}) : isDesktop = true;
  const VoteItemInfo.mobile({super.key}) : isDesktop = false;

  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 資料區 上半部
        const CommodityBodyTop(),
        // 資料區下半部
        Container(
          constraints: const BoxConstraints(maxWidth: 1280),
          padding: EdgeInsets.only(bottom: 20, top: isDesktop ? 0 : 10),
          child: Column(
            children: [
              // 狀態
              isDesktop
                  ? const VoteItemState.desktop()
                  : const VoteItemState.mobile(),
              // 類別欄位
              isDesktop
                  ? const VoucherInfoRowInfo.desktop()
                  : const VoucherInfoRowInfo.mobile(),
              // 創建者欄位
              isDesktop
                  ? const InfoRowCreator.desktop()
                  : const InfoRowCreator.mobile(),
              // 連結欄位
              isDesktop
                  ? const InfoRowIntroLink.desktop()
                  : const InfoRowIntroLink.mobile(),
              // 說明欄位
              isDesktop
                  ? const InfoRowDescription.desktop()
                  : const InfoRowDescription.mobile(),
              isDesktop
                  ? const VoteOptions.desktop()
                  : const VoteOptions.mobile(),
              // 送出投票按鈕
              context.isDesktopPlatform
                  ? isDesktop
                      ? const SendVoteButton.desktop()
                      : const SendVoteButton.mobile()
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ],
    );
  }
}

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
        // 問券 自己的投票陣列
        final List<int>? array = ref.watch(
            itemSelectInfoProvider.select((value) => value.voteArrayData));

        final isSuccess = array != null && !array.contains(-1);

        final isCheck =
            ref.watch(itemSelectInfoProvider.select((value) => value.isCheck));

        final isFirstLogin = ref.watch(
            itemSelectInfoProvider.select((value) => value.isFirstLogin));

        final getLoginTokenState = ref.watch(
            authServiceProvider.select((value) => value.getLoginTokenState));

        final checkLoginTokenState = ref.watch(
            authServiceProvider.select((value) => value.checkLoginTokenState));

        final bool isLogin = SharedPrefs.getLoginInfo()?.isLogin == true;

        final bool isThereCurrentDialogShowing =
            context.isThereCurrentDialogShowing;

        /// 顯示登入Dialog
        void showLoginDialog() {
          // 如果彈窗已存在，先關閉彈窗
          if (isThereCurrentDialogShowing) {
            context.pop();
          }
          showloginVoteDialog(
            context,
            screenStyle: screenStyle,
            url: getLoginTokenState.data?.content,
          );
        }

        Future.microtask(() {
          // 成功取得login toke顯示Login dialog
          if (getLoginTokenState.isCompleted && !isLogin) {
            showLoginDialog();
          } else if (checkLoginTokenState.data?.isSuccess == true &&
              isFirstLogin) {
            // 更新是否為第一次登入的值
            ref.read(itemSelectInfoProvider.notifier).isFirstLogin = false;

            // 如果彈窗已存在，先關閉彈窗
            if (isThereCurrentDialogShowing) {
              context.pop();
            }
            showVoteSuccessDialog(context, screenStyle: screenStyle);
          }
        });

        return isLogin
            ? const SizedBox.shrink()
            : Padding(
                padding: EdgeInsets.symmetric(
                    vertical: context.isDesktopPlatform ? 36 : 16),
                child: Column(
                  children: [
                    isCheck && !isSuccess
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
                        if (isSuccess) {
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
                              .checkOptions(true);
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
