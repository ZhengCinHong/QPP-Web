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
      decoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          color: QppColors.prussianBlue,
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
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
      titleBackground: QppColors.prussianBlue,
      titlePadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
    );
  }

  Widget get title;

  Widget get content;

  EdgeInsets get padding {
    if (isDesktop) {
      return const EdgeInsets.fromLTRB(37, 28, 37, 37);
    }
    return const EdgeInsets.fromLTRB(37, 28, 58, 39);
  }
}

/// NFT 教學收折 item title
class NFTTeachSectionInfoTitle extends StatelessWidget {
  /// title
  final String titleKey;
  const NFTTeachSectionInfoTitle({super.key, required this.titleKey});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        context.tr(titleKey),
        textAlign: TextAlign.center,
        style: QppTextStyles.web_20pt_title_bold_m_white_C,
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
