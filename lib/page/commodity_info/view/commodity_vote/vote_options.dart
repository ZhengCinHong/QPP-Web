import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qpp_example/api/core/api_response.dart';
import 'package:qpp_example/extension/widget/disable_selection_container.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:qpp_example/model/enum/item/vote_show_type.dart';
import 'package:qpp_example/model/enum/item/vote_type.dart';
import 'package:qpp_example/model/vote/qpp_vote.dart';
import 'package:qpp_example/model/vote/vote_data.dart';
import 'package:qpp_example/page/commodity_info/view/commodity_info_body.dart';
import 'package:qpp_example/utils/qpp_color.dart';
import 'package:qpp_example/utils/qpp_image.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';
import 'package:qpp_example/utils/screen.dart';

/// 投票選項
class VoteOptions extends StatelessWidget {
  const VoteOptions.desktop({super.key}) : screenStyle = ScreenStyle.desktop;
  const VoteOptions.mobile({super.key}) : screenStyle = ScreenStyle.mobile;

  final ScreenStyle screenStyle;

  @override
  Widget build(BuildContext context) {
    final isDesktopStyle = screenStyle.isDesktop;

    return Consumer(
      builder: (context, ref, child) {
        // 問券 物品資料狀態通知
        final ApiResponse<QppVote> voteDataState = ref.watch(
            itemSelectInfoProvider.select((value) => value.voteDataState));

        final QppVote? qppVote = voteDataState.data;
        final voteData = qppVote?.voteData;

        return voteDataState.isCompleted && qppVote != null && voteData != null
            ? ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                primary: false,
                itemCount: voteData.length,
                itemBuilder: (context, index) {
                  final data = voteData[index];

                  return Padding(
                    padding: EdgeInsets.only(
                        top: index == 0
                            ? 14
                            : isDesktopStyle
                                ? 8
                                : 4),
                    child: isDesktopStyle
                        ? VoteOptionsItem.desktop(
                            index: index,
                            voteData: data,
                            qppVote: qppVote,
                          )
                        : VoteOptionsItem.mobile(
                            index: index,
                            voteData: data,
                            qppVote: qppVote,
                          ),
                  );
                },
              )
            : const SizedBox.shrink();
      },
    );
  }
}

/// 投票選項Item
class VoteOptionsItem extends StatelessWidget {
  const VoteOptionsItem.desktop({
    super.key,
    required this.index,
    required this.voteData,
    required this.qppVote,
  }) : screenStyle = ScreenStyle.desktop;

  const VoteOptionsItem.mobile({
    super.key,
    required this.index,
    required this.voteData,
    required this.qppVote,
  }) : screenStyle = ScreenStyle.mobile;

  final ScreenStyle screenStyle;
  final VoteData voteData;
  final int index;
  final QppVote qppVote;

  @override
  Widget build(BuildContext context) {
    final isDesktopStyle = screenStyle.isDesktop;

    final double leftSpacing = isDesktopStyle ? 60 : 12;
    // 這邊對照infoRow的標題寬度
    final double titleWidth = isDesktopStyle ? 120 : 90;

    /// 一般的字型
    final textStyle = isDesktopStyle
        ? QppTextStyles.web_16pt_body_platinum_L
        : QppTextStyles.mobile_14pt_body_pastel_blue_L;

    /// 所有選項
    final options = voteData.options;

    return Container(
      color: QppColors.prussianBlue,
      padding: EdgeInsets.only(
        top: isDesktopStyle ? 24 : 20,
        bottom: isDesktopStyle ? 25 : 22,
      ),
      child: Column(
        children: [
          // -----------------------------------------------------------------------------
          // 題目
          // -----------------------------------------------------------------------------
          Padding(
            padding: EdgeInsets.only(
              bottom: isDesktopStyle ? 21 : 14,
              left: leftSpacing,
              right: isDesktopStyle ? 57 : 25,
            ),
            child: Consumer(
              builder: (context, ref, chid) {
                final List<bool> isErrorArray = ref.watch(itemSelectInfoProvider
                    .select((value) => value.isOptionErrorArray));

                /// 問券 自己的投票陣列
                final List<int>? voteArrayData = ref.watch(
                    itemSelectInfoProvider.select(
                        (value) => value.voteDataState.data?.voteArrayData));

                final isError =
                    isErrorArray[index] && voteArrayData?[index] == -1;

                /// 錯誤的字型
                final errorTextStyle = isDesktopStyle
                    ? QppTextStyles.web_16pt_body_red_L
                    : QppTextStyles.mobile_14pt_body_outrageous_orange_L;

                return Row(
                  children: [
                    SizedBox(
                      width: titleWidth,
                      child: Text(
                        'Q${(index + 1).toString()}',
                        style: isError
                            ? errorTextStyle
                            : isDesktopStyle
                                ? QppTextStyles.web_16pt_body_category_text_L
                                : QppTextStyles
                                    .mobile_14pt_body_category_text_L,
                      ),
                    ),
                    Flexible(
                      child: AutoSizeText(
                        voteData.voteTitle,
                        style: isError ? errorTextStyle : textStyle,
                      ),
                    )
                  ],
                );
              },
            ),
          ),
          // -----------------------------------------------------------------------------
          // 選項
          // -----------------------------------------------------------------------------
          Padding(
            padding: EdgeInsets.only(
              left: leftSpacing + titleWidth,
              right: isDesktopStyle ? 57 : 25,
            ),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              primary: false,
              itemCount: options.length,
              itemBuilder: (context, itemIndex) {
                final item = options[itemIndex];

                return Padding(
                  padding: EdgeInsets.only(
                    top: itemIndex == 0
                        ? 0
                        : isDesktopStyle
                            ? 16
                            : 8,
                  ),
                  child: Consumer(
                    builder: (context, ref, child) {
                      /// 問券 自己的投票陣列
                      final List<int>? voteArrayData = ref.watch(
                          itemSelectInfoProvider.select((value) =>
                              value.voteDataState.data?.voteArrayData));

                      /// 投票狀態(是否已投票，已投票狀態)
                      final votedState = ref.watch(itemSelectInfoProvider
                          .select((value) => value.votedState));

                      /// 是否為已投票
                      final isVoted = votedState.$1;

                      /// 是否為創建者
                      final isCreater = ref.watch(itemSelectInfoProvider
                          .select((value) => value.isCreater));

                      /// 是否選擇
                      final isSelected = voteArrayData?[index] == itemIndex;

                      /// 是否啟用點擊(選項按鈕)
                      final isEnableTap =
                          !isVoted && qppVote.voteType == VoteType.inProgress;

                      /// 是否為已過期
                      final isExpired = qppVote.voteType == VoteType.expired;

                      /// 是否為已結束
                      final isEnded = qppVote.voteType == VoteType.ended;

                      final notifier =
                          ref.read(itemSelectInfoProvider.notifier);

                      /// 已選擇的字型
                      final selectedTextStyle = isDesktopStyle
                          ? QppTextStyles.web_16pt_body_pastel_yellow_L
                          : QppTextStyles.mobile_14pt_body_canary_yellow_L;

                      /// 百分比
                      final percent = item.percent(voteData.totalVoteNumber);

                      /// 是否為0%
                      final bool isZeroPercent = percent == 0;

                      /// 投票顯示狀態
                      final voteShowType = qppVote.voteShowType;

                      /// 是否為問號
                      final isQuestionMark =
                          voteShowType == VoteShowType.questionMark;

                      /// 是否隱藏確認框
                      final isHiddenCheckBox = isCreater ||
                          isExpired ||
                          isEnded ||
                          (!isSelected && isVoted);
                      /// 確認框右邊間距
                      final double checkboxRightSpacing =
                          isDesktopStyle ? 8 : 12;
                      /// 確認框寬度
                      final double checkboxWidth = isDesktopStyle ? 20 : 16;
                      /// 內縮間距
                      final double inwardRetractionSpacing = checkboxRightSpacing + checkboxWidth;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MouseRegion(
                            cursor: isEnableTap
                                ? MaterialStateMouseCursor.clickable
                                : MouseCursor.defer,
                            child: GestureDetector(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isHiddenCheckBox
                                      ? const SizedBox.shrink()
                                      : Padding(
                                          padding: EdgeInsets.only(
                                            right: checkboxRightSpacing,
                                          ),
                                          child: Image.asset(
                                            isSelected
                                                ? QPPImages
                                                    .desktop_icon_button_check_single
                                                : QPPImages
                                                    .desktop_icon_button_check_default,
                                            width: checkboxWidth,
                                          ),
                                        ),
                                  Flexible(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        left: (!(isCreater || isExpired || isEnded) && !isSelected && isVoted) // 非選擇，但已投票(並且不為創建者)，需要內縮
                                            ? inwardRetractionSpacing
                                            : 0,
                                      ),
                                      child: Text(
                                        '${isExpired ? '・' : ''}${item.option}',
                                        style: (isSelected &&
                                                !isEnableTap &&
                                                voteShowType !=
                                                    VoteShowType.noShow)
                                            ? selectedTextStyle
                                            : textStyle,
                                      ),
                                    ),
                                  ),
                                ],
                              ).disabledSelectionContainer,
                              onTap: () {
                                if (isEnableTap) {
                                  notifier.selectedOption(index, itemIndex);
                                  notifier.updateErrorOptions(
                                    index,
                                    false,
                                  );
                                }
                              },
                            ),
                          ),
                          voteShowType != VoteShowType.noShow
                              ? Padding(
                                  padding: EdgeInsets.only(
                                    left: (isCreater || isExpired || isEnded)
                                        ? 0
                                        : inwardRetractionSpacing
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: isDesktopStyle ? 13 : 5,
                                          bottom: isDesktopStyle ? 4 : 2,
                                        ),
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: LayoutBuilder(
                                                builder:
                                                    (context, constraints) {
                                                  /// 百分比條寬度
                                                  final double percentWidth =
                                                      percent *
                                                          constraints.maxWidth;

                                                  // 百分比條
                                                  return Container(
                                                    width: isQuestionMark
                                                        ? constraints.maxWidth
                                                        : isZeroPercent
                                                            ? 6
                                                            : percentWidth,
                                                    height:
                                                        isDesktopStyle ? 12 : 8,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        isDesktopStyle ? 2 : 1,
                                                      ),
                                                      color: isQuestionMark
                                                          ? QppColors
                                                              .midnightBlue
                                                          : isZeroPercent
                                                              ? QppColors
                                                                  .midnightBlue
                                                              : QppColors
                                                                  .mayaBlue,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            // 間距
                                            SizedBox(
                                              width: isDesktopStyle ? 10 : 6,
                                            ),
                                            // 百分比字串
                                            Text(
                                              isQuestionMark
                                                  ? '?%'
                                                  : '${(percent * 100).toStringAsFixed(1)}%',
                                              style: isDesktopStyle
                                                  ? isQuestionMark
                                                      ? QppTextStyles
                                                          .web_12pt_caption_midnight_blue_L
                                                      : QppTextStyles
                                                          .web_16pt_body_maya_blue_R
                                                  : isQuestionMark
                                                      ? QppTextStyles
                                                          .web_12pt_caption_midnight_blue_L
                                                      : QppTextStyles
                                                          .web_12pt_caption_maya_blue_L,
                                            )
                                          ],
                                        ),
                                      ),
                                      // 人數
                                      Text(
                                        '${context.tr(QppLocales.commodityInfoPeople)} ${isQuestionMark ? '?' : item.voteCount}',
                                        style: isDesktopStyle
                                            ? isQuestionMark
                                                ? QppTextStyles
                                                    .web_12pt_caption_midnight_blue_L
                                                : QppTextStyles
                                                    .web_16pt_body_maya_blue_R
                                            : isQuestionMark
                                                ? QppTextStyles
                                                    .web_12pt_caption_midnight_blue_L
                                                : QppTextStyles
                                                    .web_12pt_caption_maya_blue_L,
                                      )
                                    ],
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ],
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// class _SelectCheckBoxWidget extends StatelessWidget {
//   final Widget child;

//   final bool isEnableTap;
//   final (int, int) indexPath;

//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       cursor:
//           isEnableTap ? MaterialStateMouseCursor.clickable : MouseCursor.defer,
//       child: GestureDetector(
//         child: child.disabledSelectionContainer,
//         onTap: () {
//           if (isEnableTap) {
//             notifier.selectedOption(indexPath.$1, indexPath.$2);
//             notifier.updateErrorOptions(
//               index,
//               false,
//             );
//           }
//         },
//       ),
//     );
//   }
// }
