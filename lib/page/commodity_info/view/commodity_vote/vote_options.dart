import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qpp_example/api/core/api_response.dart';
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
        ApiResponse<QppVote> voteDataState = ref.watch(
            itemSelectInfoProvider.select((value) => value.voteDataState));

        return voteDataState.isCompleted
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  children: voteDataState.data?.voteData
                          .asMap()
                          .entries
                          .map(
                            (e) => isDesktopStyle
                                ? VoteOptionsItem.desktop(
                                    index: e.key, voteData: e.value)
                                : VoteOptionsItem.mobile(
                                    index: e.key, voteData: e.value),
                          )
                          .toList() ??
                      [],
                ),
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
  }) : screenStyle = ScreenStyle.desktop;

  const VoteOptionsItem.mobile({
    super.key,
    required this.index,
    required this.voteData,
  }) : screenStyle = ScreenStyle.mobile;

  final ScreenStyle screenStyle;
  final VoteData voteData;
  final int index;

  @override
  Widget build(BuildContext context) {
    final isDesktopStyle = screenStyle.isDesktop;

    final double leftSpacing = isDesktopStyle ? 60 : 12;
    // 這邊對照infoRow的標題寬度
    final double titleWidth = isDesktopStyle ? 120 : 90;

    final textStyle = isDesktopStyle
        ? QppTextStyles.web_16pt_body_platinum_L
        : QppTextStyles.mobile_14pt_body_pastel_blue_L;

    final errorTextStyle = isDesktopStyle
        ? QppTextStyles.web_16pt_body_red_L
        : QppTextStyles.mobile_14pt_body_outrageous_orange_L;

    return Container(
      color: QppColors.prussianBlue,
      padding: EdgeInsets.only(
        top: isDesktopStyle ? 24 : 20,
        bottom: isDesktopStyle ? 25 : 22,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: isDesktopStyle ? 21 : 14,
              left: leftSpacing,
              right: isDesktopStyle ? 57 : 25,
            ),
            child: Consumer(
              builder: (context, ref, chid) {
                final bool isCheck = ref.watch(
                    itemSelectInfoProvider.select((value) => value.isCheck));

                // 問券 自己的投票陣列
                final List<int>? data = ref.watch(itemSelectInfoProvider
                    .select((value) => value.voteArrayData));

                final isError = isCheck && data?[index] == -1;

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
                    Text(
                      voteData.voteTitle,
                      style: isError ? errorTextStyle : textStyle,
                    )
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: leftSpacing + titleWidth,
              right: isDesktopStyle ? 57 : 25,
            ),
            child: Column(
              children: voteData.options
                  .asMap()
                  .entries
                  .map(
                    (e) => Padding(
                      padding: EdgeInsets.only(top: e.key == 0 ? 0 : 16),
                      child: Consumer(
                        builder: (context, ref, child) {
                          // 問券 自己的投票陣列
                          final List<int>? data = ref.watch(
                              itemSelectInfoProvider
                                  .select((value) => value.voteArrayData));

                          final notifier =
                              ref.read(itemSelectInfoProvider.notifier);

                          return MouseRegion(
                            cursor: MaterialStateMouseCursor.clickable,
                            child: GestureDetector(
                              child: Row(
                                children: [
                                  Image.asset(
                                    data?[index] == e.key
                                        ? QPPImages
                                            .desktop_icon_button_check_single
                                        : QPPImages
                                            .desktop_icon_button_check_default,
                                  ),
                                  SizedBox(width: isDesktopStyle ? 8 : 12),
                                  Text(e.value.option, style: textStyle)
                                ],
                              ),
                              onTap: () {
                                notifier.selectedOption(index, e.key);
                                notifier.checkOptions(false);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
