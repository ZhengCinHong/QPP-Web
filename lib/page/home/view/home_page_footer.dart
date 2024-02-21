import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qpp_example/common_ui/qpp_app_bar/view_model/qpp_app_bar_view_model.dart';
import 'package:universal_html/html.dart' as html;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qpp_example/common_ui/qpp_app_bar/model/qpp_app_bar_model.dart';
import 'package:qpp_example/common_ui/qpp_app_bar/view/qpp_app_bar_view.dart';
import 'package:qpp_example/common_ui/qpp_text/c_under_line_text.dart';
import 'package:qpp_example/constants/server_const.dart';
import 'package:qpp_example/localization/qpp_locales.dart';
import 'package:qpp_example/page/home/model/home_page_model.dart';
import 'package:qpp_example/utils/qpp_color.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';
import 'package:qpp_example/utils/screen.dart';

// -----------------------------------------------------------------------------
/// 首頁 - 頁尾
// -----------------------------------------------------------------------------
class HomePageFooter extends StatelessWidget {
  const HomePageFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(children: [_FooterInfo(), _CompanyName()]);
  }
}

// -----------------------------------------------------------------------------
/// 頁尾資訊
// -----------------------------------------------------------------------------
class _FooterInfo extends StatelessWidget {
  const _FooterInfo();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 背景顏色
        Positioned.fill(
          child: Container(color: QppColors.oxfordBlue),
        ),
        // 遮罩
        Positioned.fill(
          child: Container(color: QppColors.maskAlpha60),
        ),
        // 內容
        Container(
          // decoration: const BoxDecoration(color: QppColors.oxfordBlue),
          padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final bool isDesktopStyle =
                  constraints.maxWidth > 981; // 特殊樣式，防止多語系跑版

              return Flex(
                direction: isDesktopStyle ? Axis.horizontal : Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isDesktopStyle ? const Spacer() : const SizedBox.shrink(),
                  isDesktopStyle
                      ? const _Info(ScreenStyle.desktop)
                      : const _Info(ScreenStyle.mobile),
                  isDesktopStyle ? const Spacer() : const SizedBox(height: 50),
                  isDesktopStyle ? const _Guide() : const _MobileGuide(),
                  isDesktopStyle
                      ? Flexible(
                          child: Container(
                            constraints: const BoxConstraints(maxWidth: 100),
                          ),
                        )
                      : const SizedBox.shrink(),
                  isDesktopStyle
                      ? const LanguageDropdownMenu(ScreenStyle.desktop)
                      : const SizedBox.shrink(),
                  isDesktopStyle ? const Spacer() : const SizedBox.shrink(),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
/// 資訊
// -----------------------------------------------------------------------------
class _Info extends StatelessWidget {
  const _Info(this.screenStyle);

  final ScreenStyle screenStyle;

  @override
  Widget build(BuildContext context) {
    final isDesktopStyle = screenStyle.isDesktop;

    final String image = isDesktopStyle
        ? HomePageModel.footerLogoImages[0]
        : HomePageModel.footerLogoImages[1];

    return Flex(
      direction: isDesktopStyle ? Axis.horizontal : Axis.vertical,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          key: ValueKey(image),
          icon: Image.asset(
            image,
            cacheWidth: isDesktopStyle ? 74 : 151,
            cacheHeight: isDesktopStyle ? 83 : 47,
          ),
          onPressed: () => html.window.location.reload(),
        ),
        const SizedBox(height: 30, width: 30),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.tr(QppLocales.footerCompanyName),
              style: QppTextStyles.mobile_16pt_title_white_bold_L,
            ),
            const SizedBox(height: 20),
            Text(
              '${context.tr(QppLocales.footerTaxID)}：83527156',
              style: QppTextStyles.mobile_14pt_body_white_L,
            ),
            const SizedBox(height: 4),
            _InfoMailLinkText(
              '${context.tr(QppLocales.footerCustomerServiceEmail)}：',
              screenStyle: screenStyle,
            ),
            const SizedBox(height: 4),
            _InfoMailLinkText(
              '${context.tr(QppLocales.footerBusinessProposalEmail)}：',
              screenStyle: screenStyle,
            )
          ],
        ),
      ],
    );
  }
}

/// 資訊信箱連結Text
class _InfoMailLinkText extends StatelessWidget {
  const _InfoMailLinkText(this.text, {required this.screenStyle});

  final String text;
  final ScreenStyle screenStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(text, style: QppTextStyles.web_14pt_body_s_white_L),
        const CUnderlineText.link(
          text: ServerConst.mailStr,
          link: ServerConst.mailUrl,
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
/// 導向
// -----------------------------------------------------------------------------
class _Guide extends StatelessWidget {
  const _Guide();

  @override
  Widget build(BuildContext context) {
    const double padding = 40;

    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FirstGuide(),
        SizedBox(width: padding),
        _SecondGuide(),
        SizedBox(width: padding),
        _MenuButton(type: MainMenu.description),
        SizedBox(width: padding),
        _MenuButton(type: MainMenu.contact),
      ],
    );
  }
}

class _MobileGuide extends StatelessWidget {
  const _MobileGuide();

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MenuBtns.vertical(padding: 20, fontSize: 16),
        Flexible(child: SizedBox(width: 100)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _TermsColumn(padding: 8),
            SizedBox(height: 20),
            _DownloadColumn(padding: 8),
          ],
        )
      ],
    );
  }
}

/// 桌面版第一列導向(功能介紹...)
class _FirstGuide extends StatelessWidget {
  const _FirstGuide();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _MenuButton(type: MainMenu.introduce),
        SizedBox(height: 23),
        _TermsColumn(),
      ],
    );
  }
}

/// 桌面版第二列導向(產品特色...)
class _SecondGuide extends StatelessWidget {
  const _SecondGuide();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _MenuButton(type: MainMenu.feature),
        SizedBox(height: 23),
        _DownloadColumn()
      ],
    );
  }
}

/// 條款Column
class _TermsColumn extends StatelessWidget {
  const _TermsColumn({this.padding = 19});

  /// title <-> link 間距
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _Title(type: HomePageFooterTitleType.terms),
        SizedBox(height: padding),
        const _LinkText(type: HomePageFooterLinkType.privacyPolicy),
        const SizedBox(height: 8),
        const _LinkText(type: HomePageFooterLinkType.termsOfUse),
      ],
    );
  }
}

/// 下載Column
class _DownloadColumn extends StatelessWidget {
  const _DownloadColumn({this.padding = 19});

  /// title <-> link 間距
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _Title(type: HomePageFooterTitleType.download),
        SizedBox(height: padding),
        const _LinkText(type: HomePageFooterLinkType.appleStore),
        const SizedBox(height: 8),
        const _LinkText(type: HomePageFooterLinkType.googlePlay),
      ],
    );
  }
}

/// 選單按鈕
class _MenuButton extends StatelessWidget {
  const _MenuButton({required this.type});

  final MainMenu type;

  @override
  Widget build(BuildContext context) {
    return MouseRegionCustomWidget(
      builder: (event) => Container(
        constraints: const BoxConstraints(maxWidth: 100),
        child: Consumer(
          builder: (context, ref, child) {
            final scrollToContextNotifier =
                ref.read(scrollToContextProvider.notifier);

            return CUnderlineText(
              text: context.tr(type.text),
              style: QppTextStyles.mobile_16pt_title_white_bold_L,
              onTap: () {
                scrollToContextNotifier.state = type;
              },
              softWrap: true,
              overflow: TextOverflow.clip,
            );
          },
        ),
      ),
    );
  }
}

/// 標題(條款、下載)
class _Title extends StatelessWidget {
  const _Title({required this.type});

  final HomePageFooterTitleType type;

  @override
  Widget build(BuildContext context) {
    return Text(
      context.tr(type.text),
      style: QppTextStyles.mobile_16pt_title_white_bold_L,
    );
  }
}

/// 連結文字(隱私權政策...)
class _LinkText extends StatelessWidget {
  const _LinkText({required this.type});

  final HomePageFooterLinkType type;

  @override
  Widget build(BuildContext context) {
    return CUnderlineText.link(
      text: context.tr(type.text),
      // google play 不能加上 lang, 會搜尋不到
      link: type == HomePageFooterLinkType.googlePlay
          ? type.link
          : '${type.link}?lang=${context.locale}',
      style: QppTextStyles.web_12pt_caption_white_L,
      isNewTab: true,
    );
  }
}

// -----------------------------------------------------------------------------
/// 公司名稱
// -----------------------------------------------------------------------------
class _CompanyName extends StatelessWidget {
  const _CompanyName();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      color: QppColors.darkOxfordBlue,
      child: const Center(
        child: Text(
          '©2023 HOLY BUSINESS CO., LTD',
          style: QppTextStyles.web_12pt_caption_white_L,
        ),
      ),
    );
  }
}
