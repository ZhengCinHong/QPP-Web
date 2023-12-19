import 'package:flutter/widgets.dart';
import 'package:qpp_example/common_ui/expand_container.dart';
import 'package:qpp_example/utils/qpp_text_styles.dart';

abstract class NFTExpand<T> extends ExpandContainer {
  final T data;
  const NFTExpand.desktop({super.key, required this.data}) : super.desktop();
  const NFTExpand.mobile({super.key, required this.data}) : super.mobile();

  @override
  StateNFTExpand createState() => StateNFTExpand();
}

class StateNFTExpand extends StateExpand {
  @override
  Widget build(BuildContext context) {
    // 判斷無資料就不顯示
    if (widget is NFTExpand) {
      var wid = widget as NFTExpand;
      if (wid.data is List) {
        var listData = wid.data as List;
        if (listData.isEmpty) {
          return const SizedBox.shrink();
        }
      } else if (wid.data == null) {
        return const SizedBox.shrink();
      }
      return super.build(context);
    }
    return super.build(context);
  }
}

abstract class NFTSectionInfoTitle extends StatelessWidget {
  const NFTSectionInfoTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: Row(
        children: [
          Image.asset(
            iconPath,
            width: 28.0,
            height: 28.0,
          ),
          const SizedBox(
            width: 16,
          ),
          Text(
            title,
            style: QppTextStyles.web_18pt_title_s_pastel_blue_L,
          ),
        ],
      ),
    );
  }

  /// icon 路徑
  String get iconPath;

  /// title
  String get title;
}

abstract class NFTSectionInfoContent<T> extends StatelessWidget {
  final bool isDesktop;
  final T data;
  const NFTSectionInfoContent(
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
