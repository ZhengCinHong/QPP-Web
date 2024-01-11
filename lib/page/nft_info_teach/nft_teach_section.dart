import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qpp_example/common_ui/expand_container.dart';
import 'package:qpp_example/utils/qpp_color.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';

/// NFT 教學收折容器
abstract class NFTTeachInfoExpand extends StatelessWidget {
  final bool isDesktop;
  const NFTTeachInfoExpand.desktop({super.key}) : isDesktop = true;
  const NFTTeachInfoExpand.mobile({super.key}) : isDesktop = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: padding,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: isDesktop ? QppColors.prussianBlue : QppColors.darkOxfordBlue,
          borderRadius: const BorderRadius.all(Radius.circular(12.0))),
      child: expandWidget,
    );
  }

  Widget get expandWidget {
    if (isDesktop) {
      return ExpandContainer.desktop(
        title: title,
        titleBackground: QppColors.prussianBlue,
        content: content,
        titlePadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      );
    }
    return ExpandContainer.mobile(
      title: title,
      content: content,
      titleBackground: QppColors.darkOxfordBlue,
      titlePadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
    );
  }

  Widget get title;

  Widget get content;

  EdgeInsets get padding {
    if (isDesktop) {
      return const EdgeInsets.fromLTRB(30, 28, 30, 30);
    }
    return const EdgeInsets.fromLTRB(20, 28, 20, 28);
  }
}

/// NFT 教學收折 item title
class NFTTeachSectionInfoTitle extends StatelessWidget {
  /// title
  final String titleKey;
  final bool isDesktop;
  const NFTTeachSectionInfoTitle(
      {super.key, required this.titleKey, required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        context.tr(titleKey),
        textAlign: TextAlign.center,
        style: isDesktop
            ? QppTextStyles.web_20pt_title_bold_m_white_C
            : QppTextStyles.mobile_16pt_title_white_bold_L,
      ),
    );
  }
}

/// NFT 教學收折 item 內容
abstract class NFTTeachSectionInfoContent<T> extends StatelessWidget {
  final bool isDesktop;
  final T data;
  const NFTTeachSectionInfoContent(
      {super.key, required this.isDesktop, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: contentPadding,
      child: child,
    );
  }

  Widget get child;

  EdgeInsets get contentPadding {
    return isDesktop
        ? const EdgeInsets.fromLTRB(60, 20, 60, 20)
        : const EdgeInsets.fromLTRB(12, 15, 12, 15);
  }
}

/// NFT TeachInfo 最小容器
class ItemTeachInfo extends StatelessWidget {
  final EdgeInsets? margin;
  final String? contentKey;
  final String? tipKey;
  final bool? isDesktop;
  final List<Widget>? displayImg;

  const ItemTeachInfo(
      {super.key,
      this.contentKey,
      this.tipKey,
      this.displayImg,
      this.margin,
      this.isDesktop = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          content,
          tip,
          img,
        ],
      ),
    );
  }

  /// 內容
  Widget get content {
    if (contentKey != null) {
      return Builder(builder: (context) {
        return Text(
          context.tr(contentKey!),
          style: isDesktop!
              ? QppTextStyles.web_16pt_body_platinum_L
              : QppTextStyles.mobile_14pt_body_platinum_L,
        );
      });
    }
    return const SizedBox.shrink();
  }

  /// 提示
  Widget get tip {
    if (tipKey != null) {
      return Padding(
        padding: const EdgeInsets.only(top: 6),
        child: Builder(builder: (context) {
          return Text(
            context.tr(tipKey!),
            style: isDesktop!
                ? QppTextStyles.web_16pt_body_pastel_yellow_L
                : QppTextStyles.mobile_14pt_body_pastel_yellow_L,
          );
        }),
      );
    }
    return const SizedBox.shrink();
  }

  /// 圖片
  Widget get img {
    if (displayImg != null) {
      return Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Wrap(
          spacing: 16,
          runSpacing: 16,
          children: displayImg!,
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
