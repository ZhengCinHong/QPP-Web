import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qpp_example/api/core/api_response.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:qpp_example/model/enum/item/vote_show_type.dart';
import 'package:qpp_example/model/enum/item/vote_type.dart';
import 'package:qpp_example/model/vote/qpp_vote.dart';
import 'package:qpp_example/page/commodity_info/view/commodity_info_body.dart';
import 'package:qpp_example/page/commodity_info/view/info_row.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';

/// 問券 - 目前統計
class VoteStatistics extends InfoRow {
  const VoteStatistics.desktop({super.key}) : super.desktop();
  const VoteStatistics.mobile({super.key}) : super.mobile();

  @override
  ApiResponse getResponse(WidgetRef ref) {
    return ref
        .watch(itemSelectInfoProvider.select((value) => value.voteDataState));
  }

  @override
  Widget getContent(data) {
    final contentTextStyle = isDesktop
        ? QppTextStyles.web_16pt_body_red_L
        : QppTextStyles.mobile_14pt_body_outrageous_orange_L;

    return data is QppVote
        ? Builder(
            builder: (context) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: titleWidth,
                    child: Text(
                      context.tr(QppLocales.commodityInfoVoteTotal),
                      style: isDesktop
                          ? QppTextStyles.web_16pt_body_category_text_L
                          : QppTextStyles.mobile_14pt_body_category_text_L,
                    ),
                  ),
                  // 紅字(投票結果將於結束後公佈)
                  data.voteShowType == VoteShowType.questionMark &&
                          data.voteType == VoteType.inProgress
                      ? Text(
                          context.tr(QppLocales.commodityInfoVoteAfter),
                          style: contentTextStyle,
                        )
                      : data.voteType == VoteType.expired
                          ? Text(
                              context.tr(QppLocales.commodityInfoVoteOver),
                              style: contentTextStyle,
                            )
                          : const SizedBox.shrink(),
                ],
              );
            },
          )
        : const SizedBox.shrink();
  }
}
