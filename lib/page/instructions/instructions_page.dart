import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:qpp_example/common_ui/qpp_framework/qpp_main_framework.dart';
import 'package:qpp_example/constants/server_const.dart';
import 'package:qpp_example/extension/string/text.dart';
import 'package:qpp_example/extension/string/url.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:qpp_example/page/instructions/copy_text_menu.dart';
import 'package:qpp_example/utils/qpp_color.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';
import 'package:qpp_example/utils/screen.dart';

/// 說明首頁
class InstructionsPage extends StatelessWidget {
  static String privacyJsonTextName = "text";
  static String privacyJsonTipTextName = "tipText";

  // 滾輪控制器
  final _scrollController = ScrollController();

  final InstructionsType type;

  /// 使用者條款
  InstructionsPage.term({super.key}) : type = InstructionsType.term;

  /// 隱私權政策
  InstructionsPage.privacy({super.key}) : type = InstructionsType.privacy;

  @override
  Widget build(BuildContext context) {
    List<String> texts = type.create(context);

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final isDesktop = width.determineScreenStyle().isDesktop;

    const olLineHeightRatio = 1.5625; // 25(line-height)/16(fontSize) = 1.5625

    final textStyle = isDesktop
        ? QppTextStyles.mobile_16pt_title_white_L
        : QppTextStyles.mobile_14pt_body_platinum_L;

    final fontSize = textStyle.fontSize ?? 16;
    final olTagLineHeight = (fontSize * olLineHeightRatio).round();

    // 標題樣式
    final titleTextStyle = isDesktop
        ? QppTextStyles.web_44pt_Display_L_Maya_blue_L
        : QppTextStyles.mobile_28pt_Display_s_maya_blue_C;

    // 子標題樣式
    final subTitleTextStyle = isDesktop
        ? QppTextStyles.web_24pt_title_L_maya_blue_C
        : QppTextStyles.mobile_20pt_title_L_maya_blue_L;

    // 有序項目樣式
    final olTextStyle = TextStyle(
      height: olLineHeightRatio,
      color: textStyle.color,
      fontSize: fontSize,
    );

    // 顯示寬度處理
    final paddingHorizontal = width * (isDesktop ? 0.16 : 0.088);
    final listWidth = size.width - (paddingHorizontal * 2);
    final top =
        isDesktop ? (paddingHorizontal * 0.5) : (paddingHorizontal * 1.75);
    final bottom = top;
    final padding = EdgeInsets.only(
      left: paddingHorizontal,
      top: top,
      right: paddingHorizontal,
      bottom: bottom,
    );

    return SelectionArea(
      child: Scaffold(
        // ignore: sized_box_for_whitespace
        body: Container(
          height: double.infinity,
          child: ListView.builder(
            controller: _scrollController,
            padding: padding,
            itemCount: texts.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return HtmlWidget(
                texts[index],
                customStylesBuilder: customStylesBuilder(olTagLineHeight),
                customWidgetBuilder: listCustomWidgetBuilder(
                  isDesktop: isDesktop,
                  listWidth: listWidth,
                  olTagLineHeight: olTagLineHeight,
                  textStyle: textStyle,
                  titleTextStyle: titleTextStyle,
                  subTitleTextStyle: subTitleTextStyle,
                  olTextStyle: olTextStyle,
                  scrollController: _scrollController,
                ),
                onTapUrl: (url) async {
                  url.launchURL();
                  return true;
                },
                renderMode: RenderMode.column,
                textStyle: textStyle,
              );
            },
          ),
        ).addDesktopBgKvBackgroundImage(),
      ),
    );
  }

  /// 清單客製化渲染處理
  CustomWidgetBuilder listCustomWidgetBuilder({
    required bool isDesktop,
    required double listWidth,
    required int olTagLineHeight,
    required TextStyle textStyle,
    required TextStyle titleTextStyle,
    required TextStyle subTitleTextStyle,
    required TextStyle olTextStyle,
    required ScrollController scrollController,
  }) {
    return (element) {
      if (element.className == InstructionsHtmlClass.title.name ||
          element.className == InstructionsHtmlClass.firstTitle.name) {
        final size = element.innerHtml.size(titleTextStyle);
        // optional(空格(92)) + 標題 + 空格(23) + 分割線 + 空格(48)

        List<Widget> children = [];

        // 是否要加入上方空白
        if (element.className == InstructionsHtmlClass.title.name) {
          children.add(SizedBox(height: isDesktop ? 92 : 56));
        }

        // 加入標題
        children.addAll([
          SizedBox(
            width: listWidth,
            height: size.height,
            child: FittedBox(
              fit: BoxFit.none,
              child: Text(element.innerHtml, style: titleTextStyle),
            ),
          ),
          SizedBox(height: isDesktop ? 23 : 15),
          const Divider(height: 1, color: QppColors.lapisLazuli),
          SizedBox(height: isDesktop ? 48 : 27.5)
        ]);

        return Column(
          children: children,
        );
      } else if (element.className == InstructionsHtmlClass.sectionTitle.name) {
        // 標題 + 空格(24)
        return Column(
          children: [
            Text(element.innerHtml, style: subTitleTextStyle),
            SizedBox(width: listWidth, height: 24)
          ],
        );
      } else if (element.className == InstructionsHtmlClass.sectionEnd.name) {
        // 內容 + 空格(48) + 分割線 + 空格(48)
        return Column(
          children: [
            HtmlWidget(
              element.innerHtml,
              textStyle: textStyle,
              customStylesBuilder: customStylesBuilder(olTagLineHeight),
              customWidgetBuilder:
                  textCustomWidgetBuilder(olTagLineHeight, olTextStyle),
            ),
            SizedBox(width: listWidth, height: isDesktop ? 48 : 27.5),
            const Divider(height: 1, color: QppColors.lapisLazuli),
            SizedBox(height: isDesktop ? 48 : 27.5)
          ],
        );
      } else if (element.className ==
          InstructionsHtmlClass.nftSectionEnd.name) {
        // 內容 + 空格(24)
        return Column(
          children: [
            HtmlWidget(
              element.innerHtml,
              textStyle: textStyle,
              customStylesBuilder: customStylesBuilder(olTagLineHeight),
              customWidgetBuilder:
                  textCustomWidgetBuilder(olTagLineHeight, olTextStyle),
            ),
            const SizedBox(width: 1, height: 24),
          ],
        );
      } else if (element.className ==
          InstructionsHtmlClass.privacySendEmail.name) {
        List<Widget> result = [];
        // 專門處理隱私權點擊提示彈窗
        final childrens = element.children;
        // for (var children in childrens) {
        //   // 假如是超連結
        //   if (children.localName == "a") {
        //     // 取得連結
        //     String? href;
        //     if (children.attributes.containsKey('href')) {
        //       href = children.attributes['href'];
        //     }
        //     final text = json.decode(children.innerHtml);

        //     result.add(const SizedBox(width: 4));
        //     // result.add(copyTextMenu);
        //     result.add(const SizedBox(width: 4));
        //   } else {
        //     result.add(Text(children.innerHtml, style: textStyle));
        //   }
        // }

        for (var children in childrens) {
          // 假如是超連結
          if (children.localName == "a") {
            // 取得連結
            String? href;
            if (children.attributes.containsKey('href')) {
              href = children.attributes['href'];
            }

            final text = json.decode(children.innerHtml);

            // 生成按鈕
            final copyTextMenu = CopyTextMenu(
              text: text[InstructionsPage.privacyJsonTextName],
              textStyle: isDesktop
                  ? QppTextStyles.web_16pt_body_canary_yellow_C
                  : QppTextStyles.mobile_14pt_body_canary_yellow_L,
              tipText: text[InstructionsPage.privacyJsonTipTextName],
              tipTextStyle: QppTextStyles.web_16pt_body_canary_yellow_C,
              scrollController: scrollController,
              onTap: () async {
                await Clipboard.setData(ClipboardData(text: href ?? ""));
              },
            );

            result.add(const SizedBox(width: 4));
            result.add(copyTextMenu);
            result.add(const SizedBox(width: 4));
          } else {
            result.add(Text(children.innerHtml, style: textStyle));
          }
        }

        return Wrap(children: result);
      }

      return null;
    };
  }

  /// 文字風格處理
  CustomStylesBuilder customStylesBuilder(int olTagLineHeight) {
    return (element) {
      // css 相關處理
      if (element.localName == 'ol') {
        return {
          'line-height': '${olTagLineHeight}px',
          'padding-left': '1.5em', // 修正顯示文字元件沒有準確靠左問題
        };
      }
      if (element.localName == 'ul') {
        return {
          'padding-left': '1.5em' // 修正顯示文字元件沒有準確靠左問題
        };
      }
      if (element.className == 'text-yellow-100') {
        return {
          'color': QppColors.canaryYellow.toHexString(),
        };
      }
      if (element.localName == 'u') {
        return {
          'border-bottom': "1px solid",
        };
      }
      return null;
    };
  }

  /// 文字客製化渲染處理
  CustomWidgetBuilder textCustomWidgetBuilder(
      int lineHeight, TextStyle olTextStyle) {
    return (element) {
      // 調整子項目文案 (1. -> (1): 由於修改的 css 不支援 li::before，只能強制調整。)
      if (element.localName == 'li' &&
          element.parent?.localName == 'ol' &&
          element.parent?.parent?.localName == 'li' &&
          element.parent?.parent?.parent?.localName == 'ol') {
        var index = element.parent?.children
            .indexWhere((e) => e.innerHtml == element.innerHtml);

        if (index != null) {
          return HtmlWidget(
            "(${index + 1}) ${element.outerHtml}",
            textStyle: olTextStyle,
            customStylesBuilder: customStylesBuilder(lineHeight),
            customWidgetBuilder:
                textCustomWidgetBuilder(lineHeight, olTextStyle),
          );
        }
      }

      return null;
    };
  }
}

/// 說明類型
enum InstructionsType {
  /// 隱私權政策
  privacy,

  /// 使用者條款
  term
}

/// 說明的子類型
enum InstructionsHtmlClass {
  /// 標題
  title,

  /// 第一個標題 (移除 top padding)
  firstTitle,

  /// (標題＋section)區塊結束
  titleAreaEnd,

  /// 段落開始
  sectionTitle,

  /// 段落結束
  sectionEnd,

  /// 數位收藏品段落結束
  nftSectionEnd,

  /// 隱私權寄信
  privacySendEmail;
}

/// html 元素屬性
enum InstructionsHtmlTag {
  ///  換行 <p>
  paragraph,

  /// 順序清單 <ol>
  orderedList,

  /// 無序清單 <ul>
  unorderedList,

  // <li>
  listItem,

  // <a>
  anchor
}

/// html 元素屬性擴充
extension InstructionsHtmlTagExtension on InstructionsHtmlTag {
  String createByKey(BuildContext content, String key) {
    final innerHtml = content.tr(key);
    return create(innerHtml);
  }

  String create(String innerHtml) {
    switch (this) {
      case InstructionsHtmlTag.paragraph:
        return "<p>$innerHtml</p>";
      case InstructionsHtmlTag.orderedList:
        return "<ol>$innerHtml</ol>";
      case InstructionsHtmlTag.unorderedList:
        return "<ul>$innerHtml</ul>";
      case InstructionsHtmlTag.listItem:
        return "<li>$innerHtml</li>";
      default:
        return "";
    }
  }
}

/// 說明文字要顯示介面
extension InstructionsTypeExtension on InstructionsType {
  List<String> create(BuildContext content) {
    List<String> result = [];

    switch (this) {
      case InstructionsType.privacy:
        result.addPrivacyString(content, QppLocales.privacyTitle);
        result.addPrivacyString(content, QppLocales.privacyP);
        result.addPrivacyString(content, QppLocales.privacyParagraph1Title);

        result.add([
          InstructionsHtmlTag.paragraph
              .createByKey(content, QppLocales.privacyParagraph1P1),
          InstructionsHtmlTag.paragraph
              .createByKey(content, QppLocales.privacyParagraph1P2),
          InstructionsHtmlTag.paragraph
              .createByKey(content, QppLocales.privacyParagraph1P3),
          InstructionsHtmlTag.paragraph
              .createByKey(content, QppLocales.privacyParagraph1P4)
        ].join(""));

        result.addPrivacyString(content, QppLocales.privacyParagraph2Title);

        result.add([
          InstructionsHtmlTag.paragraph
              .createByKey(content, QppLocales.privacyParagraph2P),
          InstructionsHtmlTag.orderedList.create([
            InstructionsHtmlTag.listItem
                .createByKey(content, QppLocales.privacyParagraph2Li1),
            InstructionsHtmlTag.listItem
                .createByKey(content, QppLocales.privacyParagraph2Li2),
            InstructionsHtmlTag.listItem
                .createByKey(content, QppLocales.privacyParagraph2Li3),
            InstructionsHtmlTag.listItem
                .createByKey(content, QppLocales.privacyParagraph2Li4),
            InstructionsHtmlTag.listItem
                .createByKey(content, QppLocales.privacyParagraph2Li5),
          ].join("")),
        ].join(""));

        result.addPrivacyString(content, QppLocales.privacyParagraph3Title);

        result.add(
          InstructionsHtmlTag.orderedList.create([
            InstructionsHtmlTag.listItem
                .createByKey(content, QppLocales.privacyParagraph3Li1),
            InstructionsHtmlTag.listItem
                .createByKey(content, QppLocales.privacyParagraph3Li2),
            InstructionsHtmlTag.listItem
                .createByKey(content, QppLocales.privacyParagraph3Li3),
            InstructionsHtmlTag.listItem
                .createByKey(content, QppLocales.privacyParagraph3Li4),
          ].join("")),
        );

        result.addPrivacyString(content, QppLocales.privacyParagraph4Title);

        result.add(
          InstructionsHtmlTag.orderedList.create([
            InstructionsHtmlTag.listItem
                .createByKey(content, QppLocales.privacyParagraph4Li1),
            InstructionsHtmlTag.listItem
                .createByKey(content, QppLocales.privacyParagraph4Li2),
            InstructionsHtmlTag.listItem
                .createByKey(content, QppLocales.privacyParagraph4Li3),
            InstructionsHtmlTag.listItem
                .createByKey(content, QppLocales.privacyParagraph4Li4),
          ].join("")),
        );

        result.addPrivacyString(content, QppLocales.privacyParagraph5Title);
        result.addPrivacyString(content, QppLocales.privacyParagraph5P);
        result.addPrivacyString(content, QppLocales.privacyParagraph6Title);
        result.addPrivacyString(content, QppLocales.privacyParagraph6P);
        result.addPrivacyString(content, QppLocales.privacyParagraph7Title);
        result.addPrivacyString(content, QppLocales.privacyParagraph7P);
        result.addPrivacyString(content, QppLocales.privacyParagraph8Title);
        result.addPrivacyString(content, QppLocales.privacyParagraph8P);
        result.addPrivacyString(content, QppLocales.privacyParagraph9Title);

        final paragraph9P1Text =
            "<h1>${content.tr(QppLocales.privacyParagraph9P1)}</h1>";

        final sendEmailText = '''{
        "${InstructionsPage.privacyJsonTextName}":"${content.tr(QppLocales.privacyParagraph9SendMail)}",
        "${InstructionsPage.privacyJsonTipTextName}":"${content.tr(QppLocales.privacyParagraph9Copy)}"
      }''';

        final privacySendEmail = "<a href="
            "${ServerConst.mailStr}"
            ">$sendEmailText</a>";

        final paragraph9P2Text =
            "<h1>${content.tr(QppLocales.privacyParagraph9P2)}</h1>";

        result.add(
          "<div class="
          "${InstructionsHtmlClass.privacySendEmail.name}"
          ">$paragraph9P1Text$privacySendEmail$paragraph9P2Text</div>",
        );

      case InstructionsType.term:
        result.addTermString(content, QppLocales.termTitle);
        result.addTermString(content, QppLocales.termSummary);
        result.addTermString(content, QppLocales.termSubtitle1);
        result.addTermString(content, QppLocales.termText1);
        result.addTermString(content, QppLocales.termSubtitle2);
        result.addTermString(content, QppLocales.termText2);
        result.addTermString(content, QppLocales.termSubtitle3);
        result.addTermString(content, QppLocales.termText3);
        result.addTermString(content, QppLocales.termSubtitle4);
        result.addTermString(content, QppLocales.termText4);
        result.addTermString(content, QppLocales.termSubtitle5);
        result.addTermString(content, QppLocales.termText5);
        result.addTermString(content, QppLocales.termSubtitle6);
        result.addTermString(content, QppLocales.termText6);
        result.addTermString(content, QppLocales.termSubtitle7);
        result.addTermString(content, QppLocales.termText7);
        result.addTermString(content, QppLocales.termSubtitle8);
        result.addTermString(content, QppLocales.termText8);
        result.addTermString(content, QppLocales.termSubtitle9);
        result.addTermString(content, QppLocales.termText9);
        result.addTermString(content, QppLocales.termSubtitle10);
        result.addTermString(content, QppLocales.termText10);
        result.addTermString(content, QppLocales.termSubtitle11);
        result.addTermString(content, QppLocales.termText11);
        result.addTermString(content, QppLocales.termSubtitle12);
        result.addTermString(content, QppLocales.termText12);
        result.addTermString(content, QppLocales.termSubtitle13);
        result.addTermString(content, QppLocales.termText13);
        result.addTermString(content, QppLocales.termSubtitle14);
        result.addTermString(content, QppLocales.termText14);

        result.addTermString(content, QppLocales.nftTermsTitle);
        result.addTermString(content, QppLocales.nftTermsSummary);
        result.addTermString(content, QppLocales.nftTermsSubtitle1);
        result.addTermString(content, QppLocales.nftTermsText1);
        result.addTermString(content, QppLocales.nftTermsSubtitle2,
            subSectionEnd: InstructionsHtmlClass.nftSectionEnd);
        result.addTermString(content, QppLocales.nftTermsText2);
        result.addTermString(content, QppLocales.nftTermsSubtitle3,
            subSectionEnd: InstructionsHtmlClass.nftSectionEnd);
        result.addTermString(content, QppLocales.nftTermsText3);
        result.addTermString(content, QppLocales.nftTermsSubtitle4,
            subSectionEnd: InstructionsHtmlClass.nftSectionEnd);
        result.addTermString(content, QppLocales.nftTermsText4);

        result.addTermString(content, QppLocales.forumTitle);
        result.addTermString(content, QppLocales.forumSummary);
        result.addTermString(content, QppLocales.forumSubtitle1);
        result.addTermString(content, QppLocales.forumText1);
        result.addTermString(content, QppLocales.forumSubtitle2);
        result.addTermString(content, QppLocales.forumText2);
        result.addTermString(content, QppLocales.forumLastText);
    }

    return result;
  }
}

/// 加入要渲染的 html 元素
extension _InstructionsList on List {
  void addPrivacyString(BuildContext content, String key) {
    var result = content.tr(key);
    InstructionsHtmlClass? className;

    if (key.contains("paragraph") && key.contains("title")) {
      // 子標題
      className = InstructionsHtmlClass.sectionTitle;

      // 補上方分割線
      if (length > 0) {
        final index = length - 1;
        final old = removeAt(index);
        addDivClassString(
          className: InstructionsHtmlClass.sectionEnd.name,
          innerHtml: old,
        );
      }
    } else if (key.contains("title")) {
      // 主標題
      className = (length == 0)
          ? InstructionsHtmlClass.firstTitle
          : InstructionsHtmlClass.title;
    }

    if (className != null) {
      addDivClassString(className: className.name, innerHtml: result);
      return;
    }
    add(result);
  }

  void addTermString(BuildContext content, String key,
      {InstructionsHtmlClass subSectionEnd =
          InstructionsHtmlClass.sectionEnd}) {
    String result = content.tr(key);
    InstructionsHtmlClass? className;

    if (key.contains("subtitle")) {
      // 子標題
      className = InstructionsHtmlClass.sectionTitle;

      // 補上方分割線
      if (length > 0) {
        final index = length - 1;
        final old = removeAt(index);
        addDivClassString(
          className: subSectionEnd.name,
          innerHtml: old,
        );
      }
    } else if (key.contains("title")) {
      // 主標題
      className = (length == 0)
          ? InstructionsHtmlClass.firstTitle
          : InstructionsHtmlClass.title;
    }

    if (className != null) {
      addDivClassString(className: className.name, innerHtml: result);
      return;
    }
    add(result);
  }

  void addDivClassString(
      {required String className, required String innerHtml}) {
    add("<div class=" "$className" ">$innerHtml</div>");
  }
}

/// 顏色轉成 hex 字串
extension ColorToHexString on Color {
  String toHexString() =>
      '#${(value & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}';
}
