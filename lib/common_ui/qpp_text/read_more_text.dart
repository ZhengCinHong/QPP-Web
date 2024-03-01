// ignore_for_file: constant_identifier_names, no_leading_underscores_for_local_identifiers, prefer_typing_uninitialized_variables
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:qpp_example/extension/string/text.dart';
import 'package:qpp_example/extension/string/url.dart';

// 修改自 https://pub-web.flutter-io.cn/packages/readmore

enum TrimMode {
  Length,
  Line,
}

/// 實現可收折及顯示連結的 Text Widget
class ReadMoreText extends StatefulWidget {
  const ReadMoreText(
    this.data, {
    Key? key,
    this.preDataText,
    this.postDataText,
    this.preDataTextStyle,
    this.postDataTextStyle,
    // 收起提示字串
    this.trimExpandedText = 'Less',
    // 顯示更多提示字串
    this.trimCollapsedText = 'More',
    this.colorClickableText,
    this.trimLength = 240,
    this.trimLines = 2,
    this.trimMode = TrimMode.Length,
    this.style,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.textScaleFactor,
    this.semanticsLabel,
    this.moreStyle,
    this.lessStyle,
    this.delimiter = '$_kEllipsis ',
    this.delimiterStyle,
    this.callback,
    this.onLinkPressed,
    this.linkTextStyle,
  }) : super(key: key);

  /// Used on TrimMode.Length
  final int trimLength;

  /// Used on TrimMode.Lines
  final int trimLines;

  /// Determines the type of trim. TrimMode.Length takes into account
  /// the number of letters, while TrimMode.Lines takes into account
  /// the number of lines
  final TrimMode trimMode;

  /// TextStyle for expanded text
  final TextStyle? moreStyle;

  /// TextStyle for compressed text
  final TextStyle? lessStyle;

  /// Textspan used before the data any heading or somthing
  final String? preDataText;

  /// Textspan used after the data end or before the more/less
  final String? postDataText;

  /// Textspan used before the data any heading or somthing
  final TextStyle? preDataTextStyle;

  /// Textspan used after the data end or before the more/less
  final TextStyle? postDataTextStyle;

  /// Called when state change between expanded/compress
  final Function(bool val)? callback;

  /// 收起提示字串, 預設為 'Less', 若不需要收起請給一個空白字元
  final String trimExpandedText;

  /// 顯示更多提示字串, 預設為 'More', 若不需要打開請給一個空白字元
  final String trimCollapsedText;

  /// 點擊連結處理
  final ValueChanged<String>? onLinkPressed;

  /// 顯示的字串
  final String data;

  /// 字串中帶連結的 TextStyle
  final TextStyle? linkTextStyle;

  final String delimiter;
  final Color? colorClickableText;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final double? textScaleFactor;
  final String? semanticsLabel;
  final TextStyle? delimiterStyle;

  @override
  ReadMoreTextState createState() => ReadMoreTextState();
}

const String _kEllipsis = '\u2026';

const String _kLineSeparator = '\u2028';

class ReadMoreTextState extends State<ReadMoreText> {
  bool _readMore = true;

  void _onTapLink() {
    setState(() {
      _readMore = !_readMore;
      widget.callback?.call(_readMore);
    });
  }

  @override
  Widget build(BuildContext context) {
    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
    TextStyle? effectiveTextStyle = widget.style;
    if (widget.style?.inherit ?? false) {
      effectiveTextStyle = defaultTextStyle.style.merge(widget.style);
    }

    final textAlign =
        widget.textAlign ?? defaultTextStyle.textAlign ?? TextAlign.start;
    final textDirection = widget.textDirection ?? Directionality.of(context);
    final textScaleFactor =
        widget.textScaleFactor ?? MediaQuery.textScaleFactorOf(context);
    final overflow = defaultTextStyle.overflow;
    final locale = widget.locale ?? Localizations.maybeLocaleOf(context);

    final colorClickableText =
        widget.colorClickableText ?? Theme.of(context).colorScheme.secondary;
    final _defaultLessStyle = widget.lessStyle ??
        effectiveTextStyle?.copyWith(color: colorClickableText);
    final _defaultMoreStyle = widget.moreStyle ??
        effectiveTextStyle?.copyWith(color: colorClickableText);
    final _defaultDelimiterStyle = widget.delimiterStyle ?? effectiveTextStyle;

    TextSpan link = TextSpan(
      text: _readMore ? widget.trimCollapsedText : widget.trimExpandedText,
      style: _readMore ? _defaultMoreStyle : _defaultLessStyle,
      recognizer: TapGestureRecognizer()..onTap = _onTapLink,
    );

    TextSpan _delimiter = TextSpan(
      text: _readMore
          ? widget.trimCollapsedText.isNotEmpty
              ? widget.delimiter
              : ''
          : '',
      style: _defaultDelimiterStyle,
      recognizer: TapGestureRecognizer()..onTap = _onTapLink,
    );

    Widget result = LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        assert(constraints.hasBoundedWidth);
        final double maxWidth = constraints.maxWidth;

        TextSpan? preTextSpan;
        TextSpan? postTextSpan;
        if (widget.preDataText != null) {
          preTextSpan = TextSpan(
            text: "${widget.preDataText!} ",
            style: widget.preDataTextStyle ?? effectiveTextStyle,
          );
        }
        if (widget.postDataText != null) {
          postTextSpan = TextSpan(
            text: " ${widget.postDataText!}",
            style: widget.postDataTextStyle ?? effectiveTextStyle,
          );
        }

        // Create a TextSpan with data
        final text = TextSpan(
          children: [
            if (preTextSpan != null) preTextSpan,
            TextSpan(text: widget.data, style: effectiveTextStyle),
            if (postTextSpan != null) postTextSpan
          ],
        );

        // Layout and measure link
        TextPainter textPainter = TextPainter(
          text: link,
          textAlign: textAlign,
          textDirection: textDirection,
          textScaleFactor: textScaleFactor,
          maxLines: widget.trimLines,
          ellipsis: overflow == TextOverflow.ellipsis ? widget.delimiter : null,
          locale: locale,
        );
        textPainter.layout(minWidth: 0, maxWidth: maxWidth);
        final linkSize = textPainter.size;

        // Layout and measure delimiter
        textPainter.text = _delimiter;
        textPainter.layout(minWidth: 0, maxWidth: maxWidth);
        final delimiterSize = textPainter.size;

        // Layout and measure text
        textPainter.text = text;
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final textSize = textPainter.size;

        // Get the endIndex of data
        bool linkLongerThanLine = false;
        int endIndex;

        if (linkSize.width < maxWidth) {
          final readMoreSize = linkSize.width + delimiterSize.width;
          final pos = textPainter.getPositionForOffset(Offset(
            textDirection == TextDirection.rtl
                ? readMoreSize
                : textSize.width - readMoreSize,
            textSize.height,
          ));
          endIndex = textPainter.getOffsetBefore(pos.offset) ?? 0;
        } else {
          var pos = textPainter.getPositionForOffset(
            textSize.bottomLeft(Offset.zero),
          );
          endIndex = pos.offset;
          linkLongerThanLine = true;
        }

        var textSpan;
        switch (widget.trimMode) {
          case TrimMode.Length:
            if (widget.trimLength < widget.data.length) {
              textSpan = _buildData(
                data: _readMore
                    ? widget.data.substring(0, widget.trimLength)
                    : widget.data,
                fullData: widget.data,
                textStyle: effectiveTextStyle,
                linkTextStyle: linkStyle,
                onPressed: widget.onLinkPressed,
                children: [_delimiter, link],
              );
            } else {
              textSpan = _buildData(
                data: widget.data,
                textStyle: effectiveTextStyle,
                linkTextStyle: linkStyle,
                onPressed: widget.onLinkPressed,
                children: [],
              );
            }
            break;
          case TrimMode.Line:
            if (textPainter.didExceedMaxLines) {
              textSpan = _buildData(
                data: _readMore
                    ? widget.data.substring(0, endIndex) +
                        (linkLongerThanLine ? _kLineSeparator : '')
                    : widget.data,
                fullData: widget.data,
                textStyle: effectiveTextStyle,
                linkTextStyle: linkStyle,
                onPressed: widget.onLinkPressed,
                children: [_delimiter, link],
              );
            } else {
              textSpan = _buildData(
                data: widget.data,
                textStyle: effectiveTextStyle,
                linkTextStyle: linkStyle,
                onPressed: widget.onLinkPressed,
                children: [],
              );
            }
            break;
          default:
            throw Exception(
                'TrimMode type: ${widget.trimMode} is not supported');
        }

        return Text.rich(
          TextSpan(
            children: [
              if (preTextSpan != null) preTextSpan,
              textSpan,
              if (postTextSpan != null) postTextSpan,
            ],
          ),
          textAlign: textAlign,
          textDirection: textDirection,
          softWrap: true,
          overflow: TextOverflow.clip,
          textScaleFactor: textScaleFactor,
        );
      },
    );
    if (widget.semanticsLabel != null) {
      result = Semantics(
        textDirection: widget.textDirection,
        label: widget.semanticsLabel,
        child: ExcludeSemantics(
          child: result,
        ),
      );
    }
    return result;
  }

  TextSpan _buildData({
    required String data,
    String? fullData,
    TextStyle? textStyle,
    TextStyle? linkTextStyle,
    ValueChanged<String>? onPressed,
    required List<TextSpan> children,
  }) {
    // 定义URL的正则表达式
    // url RegExp exp = RegExp(r'(https|http):\/\/?[\w/\-?=%.]+\.[\w/\-?=%.&]+');
    // mail RegExp exp = RegExp(r'[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}');
    // 判斷 url & mail 的正則
    RegExp exp = RegExp(
        r'(?:[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}|'
        r'(https|http):\/\/?[\w/\-?=%.]+\.[\w/\-?=%.&]+)',
        caseSensitive: false);

    List<TextSpan> contents = [];

    // 處理 URL
    while (exp.hasMatch(data)) {
      // 這邊處理顯示的字串
      final match = exp.firstMatch(data);
      final firstTextPart = data.substring(0, match!.start);
      final linkTextPart = data.substring(match.start, match.end);

      // if (!fullData.isNullOrEmpty) {
      // 取完整 URL 資料
      final fullLinkMatch = exp.firstMatch(fullData ?? '');
      final String? fullLinkPart =
          fullData?.substring(fullLinkMatch!.start, fullLinkMatch.end);
      // }
      // contents 加入一般文字
      contents.add(
        TextSpan(
          text: firstTextPart,
        ),
      );
      // contents 加入連結文字
      contents.add(
        TextSpan(
          text: linkTextPart,
          style: linkTextStyle,
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              // 判斷是否為 mail
              if (linkTextPart.isMail) {
                // 若為 mail
                'mailto:${fullLinkPart?.trim() ?? linkTextPart.trim()}'
                    .launchURL(isNewTab: false);
              } else {
                // 若為 url , call onPressed
                onPressed?.call(
                  fullLinkPart?.trim() ?? linkTextPart.trim(),
                );
              }
            },
        ),
      );
      // 若有塞FullData, 也要剪掉處理完的文字
      if (!fullData.isNullOrEmpty) {
        fullData = fullData!.substring(fullLinkMatch!.end, fullData.length);
      }
      // 剪掉處理完的文字
      data = data.substring(match.end, data.length);
    }

    contents.add(
      TextSpan(
        text: data,
      ),
    );
    return TextSpan(
      children: contents..addAll(children),
      style: textStyle,
    );
  }

  /// 取得 link text style
  TextStyle? get linkStyle {
    // 判斷是否有設定 link style
    if (widget.linkTextStyle == null) {
      // 未設定, 使用預設
      return widget.style?.copyWith(
        decoration: TextDecoration.underline,
        color: Colors.blue,
      );
    }
    // 已設定 link style
    return widget.linkTextStyle;
  }
}
