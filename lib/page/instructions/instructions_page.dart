import 'dart:convert';
import 'package:qpp_example/page/instructions/instructions_html_class.dart';
import 'package:qpp_example/page/instructions/instructions_type.dart';
import 'package:qpp_example/utils/instruction_util.dart';
import 'package:universal_html/html.dart' as html;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:qpp_example/extension/widget/background_image.dart';
import 'package:qpp_example/page/instructions/copy_text_menu.dart';
import 'package:qpp_example/utils/qpp_color.dart';
import 'package:qpp_example/utils/qpp_image.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';
import 'package:qpp_example/utils/screen.dart';

/// 說明首頁
class InstructionsPage extends StatelessWidget {
  static String privacyJsonTextName = "text";
  static String privacyJsonTipTextName = "tipText";

  // 滾輪控制器
  final _scrollController = ScrollController();

  final InstructionsType type;

  /// 記錄彈窗狀態的 key
  final GlobalKey<CopyTextMenuState> _copyTextMenuStateKey = GlobalKey();

  /// 紀錄顯示文字的 key
  final GlobalKey _copyTextMenuDisplayTextKey = GlobalKey();

  /// 使用者條款
  InstructionsPage.term({super.key}) : type = InstructionsType.term;

  /// 隱私權政策
  InstructionsPage.privacy({super.key}) : type = InstructionsType.privacy;

  @override
  Widget build(BuildContext context) {
    List<String> texts = type.create(context);

    final size = MediaQuery.of(context).size;
    final height = size.height;
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
        body: SizedBox(
          height: height,
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
                  copyTextMenuStateKey: _copyTextMenuStateKey,
                  copyTextMenuDisplayTextKey: _copyTextMenuDisplayTextKey,
                ),
                renderMode: RenderMode.column,
                textStyle: textStyle,
              );
            },
          ),
        ).addBackgroundImage(
          isDesktop ? QPPImages.desktop_bg_kv_2 : QPPImages.mobile_bg_kv_2,
        ),
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
    required GlobalKey<CopyTextMenuState> copyTextMenuStateKey,
    required GlobalKey copyTextMenuDisplayTextKey,
  }) {
    return (element) {
      if (element.className == InstructionsHtmlClass.title.name ||
          element.className == InstructionsHtmlClass.firstTitle.name) {
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
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                Text(
                  _parseHtmlString(element.innerHtml),
                  style: titleTextStyle,
                  textAlign: TextAlign.center,
                )
              ],
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
            Text(_parseHtmlString(element.innerHtml), style: subTitleTextStyle),
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
        List<InlineSpan> result = [];

        // 專門處理隱私權點擊提示彈窗
        final childrens = element.children;
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
              key: copyTextMenuStateKey,
              tipText: text[InstructionsPage.privacyJsonTipTextName],
              tipTextStyle: QppTextStyles.web_16pt_body_white_L,
              scrollController: scrollController,
            );

            // 顯示 "電子郵件" 文案
            result.addAll([
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Wrap(
                  children: [
                    const SizedBox(
                      width: 4,
                    ),
                    InkWell(
                      child: Text(
                        text[InstructionsPage.privacyJsonTextName],
                        key: copyTextMenuDisplayTextKey,
                        textAlign: TextAlign.center,
                        style: isDesktop
                            ? QppTextStyles.web_16pt_body_canary_yellow_C
                            : QppTextStyles.mobile_14pt_body_canary_yellow_L,
                      ),
                      onTap: () async {
                        copyTextMenuStateKey.currentState
                            ?.showTip(copyTextMenuDisplayTextKey);
                        await Clipboard.setData(
                            ClipboardData(text: href ?? ""));
                      },
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                  ],
                ),
              ),
              // 彈窗預設不顯示，點擊後顯示，放在介面上方便給 listview 做回收。
              WidgetSpan(
                child: copyTextMenu,
              ),
            ]);
          } else {
            result.add(TextSpan(
                text: _parseHtmlString(children.innerHtml), style: textStyle));
          }
        }

        return Wrap(
          children: [
            RichText(
              text: TextSpan(
                children: result,
              ),
            ),
          ],
        );
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
          'text-decoration-color': QppColors.canaryYellow.toHexString(),
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
            "(${index + 1}) ${element.innerHtml}",
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

  // 解析 html 字串
  String _parseHtmlString(String htmlString) {
    var text = html.Element.span()..appendHtml(htmlString);
    return text.innerText;
  }
}
