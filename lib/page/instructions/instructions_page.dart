import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:qpp_example/common_ui/qpp_framework/qpp_main_framework.dart';
import 'package:qpp_example/extension/string/text.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:qpp_example/utils/qpp_color.dart';
import 'package:qpp_example/utils/screen.dart';

/// 說明首頁
class InstructionsPage extends StatelessWidget {
  final InstructionsType type;

  /// 使用者條款
  const InstructionsPage.term({super.key}) : type = InstructionsType.term;

  /// 隱私權政策
  const InstructionsPage.privacy({super.key}) : type = InstructionsType.privacy;

  @override
  Widget build(BuildContext context) {
    List<String> texts = type.create(context);

    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    final isDesktop = size.width.determineScreenStyle().isDesktop;

    const olTagLineHeight = 25;
    const double fontSize = 16;

    const textStyle = TextStyle(
        color: QppColors.white,
        fontSize: fontSize,
        decoration: TextDecoration.none,
        decorationStyle: TextDecorationStyle.solid);

    double paddingHorizontal = width * 0.16;

    return SelectionArea(
      // ignore: sized_box_for_whitespace
      child: Container(
        height: double.infinity,
        child: ListView.builder(
          padding: isDesktop
              ? EdgeInsets.only(
                  left: paddingHorizontal,
                  top: height * 0.1,
                  right: paddingHorizontal)
              : EdgeInsets.only(
                  left: paddingHorizontal,
                  top: height * 0.1,
                  right: paddingHorizontal),
          itemCount: texts.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return HtmlWidget(
              texts[index],
              customStylesBuilder: customStylesBuilder(olTagLineHeight),
              customWidgetBuilder: listCustomWidgetBuilder(
                size: size,
                fontSize: fontSize,
                olTagLineHeight: olTagLineHeight,
                textStyle: textStyle,
              ),
              renderMode: RenderMode.column,
              textStyle: textStyle,
            );
          },
        ),
      ).addDesktopBgKvBackgroundImage(),
    );
  }

  /// 清單客製化渲染處理
  CustomWidgetBuilder listCustomWidgetBuilder(
      {required Size size,
      required double fontSize,
      required int olTagLineHeight,
      required TextStyle textStyle}) {
    final width = size.width;

    const titleTextStyle = TextStyle(
        color: QppColors.mayaBlue,
        fontSize: 44,
        decoration: TextDecoration.none);

    const subTitleTextStyle = TextStyle(
        color: QppColors.mayaBlue,
        fontSize: 24,
        decoration: TextDecoration.none);

    final olTextStyle = TextStyle(
        height:
            olTagLineHeight / fontSize, // 25(line-height)/16(fontSize) = 1.5625
        color: QppColors.white,
        fontSize: fontSize,
        decoration: TextDecoration.none,
        decorationStyle: TextDecorationStyle.solid);

    double paddingHorizontal = width * 0.16;
    double listWidth = width - (paddingHorizontal * 2);

    return (element) {
      if (element.className == InstructionsHtmlClass.sectionTitle.name) {
        final size = element.innerHtml.size(titleTextStyle);
        // 空格 + 標題 + 空格 + 分割線 + 空格
        return Column(
          children: [
            const SizedBox(height: 92),
            SizedBox(
              width: listWidth,
              height: size.height,
              child: FittedBox(
                fit: BoxFit.none,
                child: Text(element.innerHtml, style: titleTextStyle),
              ),
            ),
            const SizedBox(height: 23),
            const Divider(height: 1, color: QppColors.lapisLazuli),
            const SizedBox(height: 48)
          ],
        );
      } else if (element.className ==
          InstructionsHtmlClass.subSectionTitle.name) {
        // 標題 + 空格
        return Column(
          children: [
            Text(element.innerHtml, style: subTitleTextStyle),
            SizedBox(width: listWidth, height: 24)
          ],
        );
      } else if (element.className ==
          InstructionsHtmlClass.subSectionEnd.name) {
        // 內容 + 空格 + 分割線 + 空格
        return Column(
          children: [
            HtmlWidget(
              element.innerHtml,
              textStyle: textStyle,
              customStylesBuilder: customStylesBuilder(olTagLineHeight),
              customWidgetBuilder:
                  textCustomWidgetBuilder(olTagLineHeight, olTextStyle),
            ),
            SizedBox(width: listWidth, height: 48),
            const Divider(height: 1, color: QppColors.lapisLazuli),
            const SizedBox(height: 48)
          ],
        );
      }

      return null;
    };
  }

  /// 文字風格處理
  CustomStylesBuilder customStylesBuilder(int lineHeight) {
    return (element) {
      // css 相關處理
      if (element.localName == 'ol') {
        return {
          'line-height': '${lineHeight}px',
          'padding-left': '1.5em' // 修正顯示文字元件沒有準確靠左問題
        };
      }
      if (element.className == 'text-yellow-100') {
        return {
          'color': QppColors.canaryYellow.toHexString(),
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
  /// 段落標題
  sectionTitle,

  /// 段落開始
  subSectionTitle,

  /// 段落結束
  subSectionEnd
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

        result.add(InstructionsHtmlTag.paragraph.create([
          content.tr(QppLocales.privacyParagraph9P1),
          "<a class="
              "text-yellow-100"
              "  href="
              "mailto:contact@fooish.com"
              ">${content.tr(QppLocales.privacyParagraph9SendMail)}</a>",
          content.tr(QppLocales.privacyParagraph9P2),
        ].join("")));

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
        result.addTermString(content, QppLocales.nftTermsSubtitle2);
        result.addTermString(content, QppLocales.nftTermsText2);
        result.addTermString(content, QppLocales.nftTermsSubtitle3);
        result.addTermString(content, QppLocales.nftTermsText3);
        result.addTermString(content, QppLocales.nftTermsSubtitle4);
        result.addTermString(content, QppLocales.nftTermsText4);
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
      className = InstructionsHtmlClass.subSectionTitle;

      // 補上方分割線
      if (length > 0) {
        final index = length - 1;
        final old = removeAt(index);
        addDivClassString(
          className: InstructionsHtmlClass.subSectionEnd.name,
          innerHtml: old,
        );
      }
    } else if (key.contains("title")) {
      // 主標題
      className = InstructionsHtmlClass.sectionTitle;
    }

    if (className != null) {
      addDivClassString(className: className.name, innerHtml: result);
      return;
    }
    add(result);
  }

  void addTermString(BuildContext content, String key) {
    String result = content.tr(key);

    InstructionsHtmlClass? className;

    if (key.contains("subtitle")) {
      // 子標題
      className = InstructionsHtmlClass.subSectionTitle;

      // 補上方分割線
      if (length > 0) {
        final index = length - 1;
        final old = removeAt(index);
        addDivClassString(
            className: InstructionsHtmlClass.subSectionEnd.name,
            innerHtml: old);
      }
    } else if (key.contains("title")) {
      // 主標題
      className = InstructionsHtmlClass.sectionTitle;
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
