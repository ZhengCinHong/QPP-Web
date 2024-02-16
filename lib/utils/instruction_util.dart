import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:qpp_example/constants/server_const.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:qpp_example/page/instructions/instructions_html_class.dart';
import 'package:qpp_example/page/instructions/instructions_html_tag.dart';
import 'package:qpp_example/page/instructions/instructions_page.dart';
import 'package:qpp_example/page/instructions/instructions_type.dart';

// InstructionsPage 工具

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
    }

    return result;
  }
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
