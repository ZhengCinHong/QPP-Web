import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:universal_html/html.dart' as html;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qpp_example/api/core/api_response.dart';
import 'package:qpp_example/common_ui/qpp_universal_link/universal_link_widget.dart';
import 'package:qpp_example/common_view_model/auth_service/view_model/auth_service_view_model.dart';
import 'package:qpp_example/constants/qpp_contanst.dart';
import 'package:qpp_example/constants/server_const.dart';
import 'package:qpp_example/extension/build_context.dart';
import 'package:qpp_example/extension/throttle_debounce.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:qpp_example/model/enum/item/item_category.dart';
import 'package:qpp_example/model/nft/qpp_nft.dart';
import 'package:qpp_example/model/qpp_item.dart';
import 'package:qpp_example/model/vote/qpp_vote.dart';
import 'package:qpp_example/page/commodity_info/view/commodity_empty.dart';
import 'package:qpp_example/page/commodity_info/view/commodity_nft.dart';
import 'package:qpp_example/page/commodity_info/view/commodity_normal.dart';
import 'package:qpp_example/page/commodity_info/view/commodity_vote.dart';
import 'package:qpp_example/page/commodity_info/view/commodity_vote/send_vote_button.dart';
import 'package:qpp_example/page/commodity_info/view_model/commodity_info_view_model.dart';
import 'package:qpp_example/universal_link/universal_link_data.dart';
import 'package:qpp_example/utils/qpp_image.dart';
import 'package:qpp_example/utils/screen.dart';
import 'package:qpp_example/utils/qpp_color.dart';

/// 物品資訊 view model
late ChangeNotifierProvider<CommodityInfoModel> itemSelectInfoProvider;

class CommodityInfoPage extends StatefulWidget {
  final GoRouterState routerState;
  const CommodityInfoPage({super.key, required this.routerState});

  @override
  State<StatefulWidget> createState() {
    return _CommodityInfoPageState();
  }
}

/// 物品資訊頁
class _CommodityInfoPageState extends State<CommodityInfoPage> {
  Size? size;
  // 是否為桌面版面
  bool isDesktopStyle = true;

  late AutoScrollController controller;

  /// 列表數量
  final count = 3;

  /// 完整路徑, 產 QR Code 用
  late String qrCodeUrl;

  /// 物品 ID
  late String commodityID;

  /// 滑動到最底部
  Future _scrollToBottom() async {
    await controller.scrollToIndex(
      count - 1,
      preferPosition: AutoScrollPosition.begin,
    );
    controller.highlight(count - 1);
  }

  @override
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    // 是否為桌面版面
    isDesktopStyle = size?.width.determineScreenStyle().isDesktop ?? false;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    controller = AutoScrollController();

    qrCodeUrl = ServerConst.routerHost + widget.routerState.uri.toString();
    // link 參數資料
    UniversalLinkParamData universalLinkParamData =
        UniversalLinkParamData.fromJson(widget.routerState.uri.queryParameters);
    // 物品 ID or NFT Token ID
    if (universalLinkParamData.commodityID != null) {
      commodityID = universalLinkParamData.commodityID!;
    } else if (universalLinkParamData.metadataID != null) {
      commodityID = universalLinkParamData.metadataID!;
    } else {
      commodityID = '-1';
    }

    // model 初始化
    itemSelectInfoProvider = ChangeNotifierProvider<CommodityInfoModel>((ref) {
      // 開始取資料
      Future.microtask(() => ref.notifier.loadData(commodityID));
      return CommodityInfoModel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: count,
          primary: false,
          controller: controller,
          itemBuilder: (context, index) {
            return AutoScrollTag(
              key: ValueKey(index),
              controller: controller,
              index: index,
              child: switch (index) {
                0 => // 上方資料區
                  isDesktopStyle
                      ? const InfoCard.desktop()
                      : const InfoCard.mobile(),
                1 => // 下方 QR Code / 按鈕
                  Consumer(
                    builder: (context, ref, child) {
                      final isQuestionnaire = ref.watch(
                        itemSelectInfoProvider.select(
                          (value) =>
                              value.voteDataState.data?.item.category ==
                              ItemCategory.questionnaire,
                        ),
                      );

                      return isQuestionnaire
                          ? const SizedBox.shrink()
                          : child ?? const SizedBox.shrink();
                    },
                    child: UniversalLinkWidget(
                      url: qrCodeUrl,
                      mobileText: QppLocales.commodityInfoLaunchQPP,
                    ),
                  ),
                _ => // 底部間距
                  const SizedBox(height: 40),
              },
            );
          },
        ),
        Positioned(
          bottom: 15,
          right: 15,
          child: Consumer(
            builder: (context, ref, child) {
              final isQuestionnaire = ref.watch(
                itemSelectInfoProvider.select(
                  (value) =>
                      value.voteDataState.data?.item.category ==
                      ItemCategory.questionnaire,
                ),
              );

              return isQuestionnaire
                  ? child ?? const SizedBox.shrink()
                  : const SizedBox.shrink();
            },
            child: IconButton(
              onPressed: () {
                _scrollToBottom();
              }.throttle(),
              icon: Image.asset(
                QPPImages.desktop_button_down_send_normal,
                width: isDesktopStyle ? 80 : 54,
                scale: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

///  上方資料卡片容器
class InfoCard extends StatelessWidget {
  // 版面判斷
  final bool isDesktop;

  /// 桌面裝置版面
  const InfoCard.desktop({super.key}) : isDesktop = true;

  /// 移動裝置版面
  const InfoCard.mobile({super.key}) : isDesktop = false;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        // 一般物品資料狀態通知
        ApiResponse<QppItem> itemInfoState =
            ref.watch(itemSelectInfoProvider).itemSelectInfoState;
        // NFT 物品資料狀態通知
        ApiResponse<QppNFT> nftMetaState =
            ref.watch(itemSelectInfoProvider).nftMetaDataState;
        // 問券 物品資料狀態通知
        ApiResponse<QppVote> voteDataState =
            ref.watch(itemSelectInfoProvider).voteDataState;

        /// 登出狀態
        ApiResponse<()> logoutState =
            ref.watch(authServiceProvider.select((value) => value.logoutState));

        Future.microtask(() {
          // 登出，刷新頁面(for 問券調查)
          if (logoutState.isCompleted && voteDataState.isCompleted) {
            html.window.location.reload();
          }
        });

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              // 切子元件超出範圍
              clipBehavior: Clip.hardEdge,
              semanticContainer: true,
              // 容器與四周間距
              margin: isDesktop
                  ? const EdgeInsets.fromLTRB(
                      60,
                      kToolbarDesktopHeight + 100,
                      60,
                      40,
                    )
                  : const EdgeInsets.fromLTRB(
                      24, kToolbarMobileHeight + 24, 24, 24),
              color: QppColors.oxfordBlue,
              shape: RoundedRectangleBorder(
                // 圓角參數
                borderRadius: BorderRadius.circular(8),
              ),
              // Card 陰影
              elevation: 0,
              // 特定裝置會吃不到 card clip, 多加一層切圓角
              child: ClipRRect(
                clipBehavior: Clip.hardEdge,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: () {
                  if (itemInfoState.isCompleted) {
                    // 有取得物品資料
                    return isDesktop
                        ? const NormalItemInfo.desktop()
                        : const NormalItemInfo.mobile();
                  } else if (nftMetaState.isCompleted) {
                    // 有取得 NFT Meta
                    return isDesktop
                        ? const NFTItemInfo.desktop()
                        : const NFTItemInfo.mobile();
                  } else if (voteDataState.isCompleted) {
                    // 取得問券資料
                    return isDesktop
                        ? const VoteItemInfo.desktop()
                        : const VoteItemInfo.mobile();
                  } else {
                    // 沒有取得物品資料
                    return isDesktop
                        ? const EmptyInfo.desktop()
                        : const EmptyInfo.mobile();
                  }
                }(),
              ),
            ),
            voteDataState.isCompleted
                ? context.isDesktopPlatform
                    ? const SizedBox.shrink()
                    : isDesktop
                        ? const SendVoteButton.desktop()
                        : const SendVoteButton.mobile()
                : const SizedBox.shrink(),
          ],
        );
      },
    );
  }
}
