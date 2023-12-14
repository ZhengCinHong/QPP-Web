import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:qpp_example/model/vote/qpp_vote.dart';
import 'package:qpp_example/page/commodity_info/model/vote_model.dart';
import 'package:qpp_example/page/commodity_info/view/commodity_info_body.dart';
import 'package:qpp_example/utils/qpp_color.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';
import 'package:qpp_example/utils/screen.dart';

/// 投票狀態
class VoteItemState extends ConsumerWidget {
  const VoteItemState.desktop({super.key}) : screenStyle = ScreenStyle.desktop;
  const VoteItemState.mobile({super.key}) : screenStyle = ScreenStyle.mobile;

  final ScreenStyle screenStyle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDesktopStyle = screenStyle.isDesktop;

    final voteDataState = ref
        .watch(itemSelectInfoProvider.select((value) => value.voteDataState));

    final voteData = voteDataState.data;

    return voteDataState.isCompleted && voteData != null
        ? Padding(
            padding: EdgeInsets.only(
              top: isDesktopStyle ? 16 : 0,
              bottom: isDesktopStyle ? 24 : 16,
              left: isDesktopStyle ? 37 : 0,
              right: isDesktopStyle ? 37 : 0,
            ),
            child: Row(
              children: [
                // 狀態
                Expanded(
                  child: isDesktopStyle
                      ? _VoteStateItem.desktop(
                          type: VoteItemStateType.state,
                          data: voteData,
                        )
                      : _VoteStateItem.mobile(
                          type: VoteItemStateType.state,
                          data: voteData,
                        ),
                ),
                // 間距
                isDesktopStyle
                    ? const SizedBox(width: 18)
                    : Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        width: 1,
                        color: QppColors.ashGray,
                      ),
                // 投票人數
                Expanded(
                  child: isDesktopStyle
                      ? _VoteStateItem.desktop(
                          type: VoteItemStateType.voteCount,
                          data: voteData,
                        )
                      : _VoteStateItem.mobile(
                          type: VoteItemStateType.voteCount,
                          data: voteData,
                        ),
                ),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}

/// 投票狀態Item
class _VoteStateItem extends StatelessWidget {
  const _VoteStateItem.desktop({required this.type, required this.data})
      : screenStyle = ScreenStyle.desktop;
  const _VoteStateItem.mobile({required this.type, required this.data})
      : screenStyle = ScreenStyle.mobile;

  final ScreenStyle screenStyle;
  final VoteItemStateType type;
  final QppVote data;

  @override
  Widget build(BuildContext context) {
    final isDesktopStyle = screenStyle.isDesktop;
    final isState = type == VoteItemStateType.state;

    return Container(
      constraints:
          BoxConstraints(maxWidth: 594, minHeight: isDesktopStyle ? 124 : 72),
      padding: EdgeInsets.only(
        top: isDesktopStyle ? 36 : 8,
        bottom: isDesktopStyle ? 29 : 9,
        left: 24,
        right: 24,
      ),
      color: QppColors.prussianBlue,
      child: Flex(
        direction: isDesktopStyle ? Axis.horizontal : Axis.vertical,
        children: [
          // 狀態標題
          Text(
            context.tr(type.title),
            style: isDesktopStyle
                ? QppTextStyles.web_16pt_body_category_text_L
                : QppTextStyles.mobile_12pt_body_category_text_L,
          ),
          const SizedBox(width: 10),
          // 狀態
          Expanded(
            flex: isDesktopStyle ? 1 : 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: isDesktopStyle
                          ? 0
                          : isState
                              ? 4
                              : 8),
                  child: AutoSizeText(
                    isState
                        ? context.tr(data.voteType.text)
                        : data.voteCount.toString(),
                    style: isDesktopStyle
                        ? QppTextStyles.web_24pt_title_L_white_L
                        : QppTextStyles.mobile_14pt_body_white_L,
                  ),
                ),
                isState
                    ?
                    // 截止
                    Text(
                        '(${context.tr(QppLocales.commodityInfoExpriy)}${data.expiryDate})',
                        style: isDesktopStyle
                            ? QppTextStyles.web_16pt_body_red_L
                            : QppTextStyles.mobile_10pt_caption_red_L,
                        textAlign: TextAlign.center,
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
