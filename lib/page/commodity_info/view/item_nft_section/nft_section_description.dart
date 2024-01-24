import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qpp_example/api/core/api_response.dart';
import 'package:qpp_example/common_ui/qpp_text/info_row_link_read_more_text.dart';
import 'package:qpp_example/extension/string/url.dart';
import 'package:qpp_example/extension/widget/disable_selection_container.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:qpp_example/model/nft/qpp_nft.dart';
import 'package:qpp_example/model/qpp_user.dart';
import 'package:qpp_example/page/commodity_info/view/commodity_info_body.dart';
import 'package:qpp_example/page/commodity_info/view/info_row.dart';
import 'package:qpp_example/page/commodity_info/view/item_nft_section/nft_section.dart';
import 'package:qpp_example/utils/qpp_image.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';

class DescriptionExpand extends NFTExpand<QppNFT> {
  const DescriptionExpand.desktop({super.key, required super.data})
      : super.desktop();
  const DescriptionExpand.mobile({super.key, required super.data})
      : super.mobile();

  @override
  Widget? get title => const DescriptionTitle();
  @override
  Widget? get content => DescriptionContent(
        data: data,
        isDesktop: isDesktop,
      );
}

class DescriptionTitle extends NFTSectionInfoTitle {
  const DescriptionTitle({super.key});

  @override
  String get iconPath => QPPImages.desktop_icon_commodity_nft_describe;

  @override
  String get title => 'Description';
}

/// 發行者
class DescriptionContent extends NFTSectionInfoContent<QppNFT> {
  const DescriptionContent(
      {super.key, required super.isDesktop, required super.data});

  @override
  Widget get child => ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: 3,
        itemBuilder: (context, index) {
          return switch (index) {
            // 連結
            1 =>
              NFTInfoRowIntroLink(data: data.externalUrl, isDesktop: isDesktop),
            // 說明
            2 => NFTInfoRowDescription(
                data: data.description,
                isDesktop: isDesktop,
              ),
            _ => isDesktop
                ? const NFTInfoRowPublisher.desktop()
                : const NFTInfoRowPublisher.mobile(),
          };
        },
      );
}

/// NFT Info Row -----------------

/// 發行者資訊
class NFTInfoRowPublisher extends InfoRow {
  /// 顯示發行者
  const NFTInfoRowPublisher.desktop({super.key}) : super.desktop();
  const NFTInfoRowPublisher.mobile({super.key}) : super.mobile();

  @override
  ApiResponse getResponse(WidgetRef ref) {
    return ref.watch(itemSelectInfoProvider).userInfoState;
  }

  @override
  rowPadding() {
    return isDesktop
        ? const EdgeInsets.fromLTRB(0, 14, 0, 14)
        : const EdgeInsets.fromLTRB(0, 10, 0, 10);
  }

  @override
  Widget getContent(data) {
    return Builder(builder: (context) {
      return MouseRegion(
        // 滑鼠移進來時會改變游標圖案
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            // 點擊前往發行者頁面
            if (data is QppUser) {
              var result = data.createInformationUrl(context);
              result.launchURL(isNewTab: false);
            }
          },
          child: Row(
            children: [
              SizedBox(
                width: titleWidth,
                child: Text(
                  context.tr(QppLocales.commodityInfoPublisher),
                  textAlign: TextAlign.start,
                  style: QppTextStyles.web_16pt_body_category_text_L,
                ),
              ),
              // 若為官方帳號, 顯示 icon
              data.isOfficial
                  ? Container(
                      padding: const EdgeInsets.only(right: 8),
                      child: Image.asset(
                        data.officialIconPath,
                        width: 20,
                      ),
                    )
                  : const SizedBox.shrink(),
              // id + name
              Expanded(
                child: Text(
                  "${data.displayID}  ${data.displayName}",
                  textAlign: TextAlign.start,
                  style: QppTextStyles.web_16pt_body_Indian_yellow_L,
                ),
              ),
              // 物件左右翻轉, 或用 RotatedBox
              Image.asset(
                QPPImages.desktop_icon_selection_arrow_right_normal,
                matchTextDirection: true,
              ),
            ],
          ),
        ),
      ).disabledSelectionContainer;
    });
  }
}

/// 資訊顯示抽象類
/// 物品資訊 Row
abstract class NFTInfoRow extends StatelessWidget {
  final String data;
  final bool isDesktop;
  const NFTInfoRow({super.key, required this.data, this.isDesktop = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _padding,
      child: getContent(data),
    );
  }

  Widget getContent(String data);

  EdgeInsets get _padding {
    return isDesktop
        ? const EdgeInsets.fromLTRB(0, 14, 0, 14)
        : const EdgeInsets.fromLTRB(0, 10, 0, 10);
  }

  double get titleWidth {
    return isDesktop ? 120 : 90;
  }
}

/// NFT 物品連結資訊
class NFTInfoRowIntroLink extends NFTInfoRow {
  const NFTInfoRowIntroLink({super.key, required super.data, super.isDesktop});

  @override
  Widget getContent(data) {
    // 有資料才顯示
    return Builder(builder: (context) {
      return Row(
        // 子元件對齊頂端
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: titleWidth,
            child: Text(
              context.tr(QppLocales.commodityInfoTitle),
              textAlign: TextAlign.start,
              style: QppTextStyles.web_16pt_body_category_text_L,
            ),
          ),
          // intro link
          Expanded(
            // Expanded 包 text, 實現自動換行
            child: InfoRowLinkReadMoreText(data: data),
          ),
        ],
      );
    });
  }
}

/// NFT 物品說明資訊
class NFTInfoRowDescription extends NFTInfoRow {
  const NFTInfoRowDescription(
      {super.key, required super.data, super.isDesktop});

  @override
  Widget getContent(data) {
    // 有資料才顯示
    return Builder(builder: (context) {
      return Row(
        // 子元件對齊頂端
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: titleWidth,
            child: Text(
              context.tr(QppLocales.commodityInfoInfo),
              textAlign: TextAlign.start,
              style: QppTextStyles.web_16pt_body_category_text_L,
            ),
          ),
          // intro link
          Expanded(
            // Expanded 包 text, 實現自動換行
            child: InfoRowLinkReadMoreText(data: data),
          ),
        ],
      );
    });
  }
}
