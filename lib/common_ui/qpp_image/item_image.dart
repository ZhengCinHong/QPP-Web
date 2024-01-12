import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qpp_example/api/core/api_response.dart';
import 'package:qpp_example/extension/string/text.dart';
import 'package:qpp_example/model/item_img_data.dart';
import 'package:qpp_example/page/commodity_info/view/commodity_info_body.dart';
import 'package:qpp_example/utils/qpp_color.dart';
import 'package:qpp_example/utils/qpp_image.dart';

/// 物品圖片
class ItemImgPhoto extends ConsumerWidget {
  // 是否為 mobile 版面
  final bool isMobile;

  /// 一般版面 constructor
  const ItemImgPhoto({super.key}) : isMobile = false;

  /// Mobile 版面 constructor
  const ItemImgPhoto.mobile({super.key}) : isMobile = true;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 監聽 photo url state
    ApiResponse<ItemImgData> itemPhotoState =
        ref.watch(itemSelectInfoProvider).itemPhotoState;

    if (itemPhotoState.status == Status.completed) {
      ItemImgData imgData = itemPhotoState.data!;
      // 確認是否為 NFT 圖片
      if (imgData.isNFT) {
        return NFTItemImg(
            isMobile: isMobile,
            path: imgData.path,
            background: imgData.bgColor);
      }
      return NormalItemImg(isMobile: isMobile, path: itemPhotoState.data!.path);
    } else if (itemPhotoState.status == Status.error) {
      return NormalItemImg(isMobile: isMobile);
    }
    return const SizedBox.shrink();
  }
}

/// desktop NFT 物品, size 180 or 144, radius 8
class NFTItemImg extends StatelessWidget {
  final bool isMobile;
  final String path;
  final Color background;
  const NFTItemImg(
      {super.key,
      required this.isMobile,
      required this.path,
      required this.background});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 48),
      width: isMobile ? 144 : 180,
      height: isMobile ? 144 : 180,
      clipBehavior: Clip.antiAlias,
      // decoration 負責切形狀
      decoration: _rectDecor(background: background),
      // foregroundDecoration 畫框線用
      foregroundDecoration: _rectDecorBorder(),
      child: Stack(children: [
        ConstrainedBox(
          // 撐滿容器
          constraints: const BoxConstraints.expand(),
          child: Image.network(
            path,
            // 圖片讀取錯誤處理
            errorBuilder: (context, error, stackTrace) {
              return const SizedBox.shrink();
            },
            filterQuality: FilterQuality.high,
            fit: BoxFit.cover,
          ),
        ),
        // 圖片放大按鈕
        Positioned(
            bottom: 5,
            right: 5,
            child: ExpandPhotoBtnWidget(
              imgPath: path,
            )),
      ]),
    );
  }
}

class _MyClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(1.5, 1.5, size.width - 1.5, size.height - 1.5);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return false;
  }
}

/// 一般物品圖片
class NormalItemImg extends StatelessWidget {
  // 是否為 mobile layout
  final bool isMobile;
  // 圖片位址, 若為 null 顯示預設
  final String? path;
  const NormalItemImg({super.key, required this.isMobile, this.path});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 83),
      width: isMobile ? 88 : 100,
      height: isMobile ? 88 : 100,
      clipBehavior: Clip.antiAlias,
      // decoration 負責切形狀
      decoration: _circleDecor(),
      // foregroundDecoration 畫框線用
      foregroundDecoration: _circleDecorBorder(),
      // 只用 Container 切圓會溢出, 這邊加上 ClipOval 強制把圖片切圓
      child: ClipOval(clipper: _MyClipper(), child: _img),
    );
  }

  /// 切圓形
  BoxDecoration _circleDecor() {
    return const BoxDecoration(
      shape: BoxShape.circle,
      // 一般物品底色, 有可能有透明圖片物品
      color: QppColors.lightStPatricksBlue,
    );
  }

  /// 切圓框線
  BoxDecoration _circleDecorBorder() {
    return BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: QppColors.lapisLazuli, width: 1.5),
    );
  }

  Widget get _img {
    if (path.isNullOrEmpty) {
      return Image.asset(
        QPPImages.desktop_pic_commodity_avatar_default,
        filterQuality: FilterQuality.high,
        fit: BoxFit.cover,
      );
    }
    // 錯誤處理在 model 做完了
    return Image.network(
      path!,
      filterQuality: FilterQuality.high,
      fit: BoxFit.cover,
    );
  }
}

/// 切圓角
BoxDecoration _rectDecor({required Color background}) {
  return BoxDecoration(
      shape: BoxShape.rectangle,
      color: background,
      borderRadius: const BorderRadius.all(Radius.circular(8.0)));
}

/// 切圓角框線
BoxDecoration _rectDecorBorder() {
  return BoxDecoration(
      shape: BoxShape.rectangle,
      border: Border.all(color: QppColors.midnightBlue, width: 1.0),
      borderRadius: const BorderRadius.all(Radius.circular(8.0)));
}

/// 點擊展開圖片元件
class ExpandPhotoBtnWidget extends StatelessWidget {
  final String imgPath;
  const ExpandPhotoBtnWidget({super.key, required this.imgPath});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          child: Image.asset(
            QPPImages.desktop_icon_image_magnifier,
            width: 30,
            height: 30,
          ),
          onTap: () {
            // 顯示自訂 dialog
            showGeneralDialog(
              context: context,
              pageBuilder: (_, animation, secondaryAnimation) {
                // dialog 自訂顯示元件
                return Stack(children: [
                  ClipRect(
                    // 毛玻璃效果
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: const SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),
                  Center(
                    // 顯示圖片
                    child: Image.network(
                      imgPath,
                      errorBuilder: (context, error, stackTrace) {
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ]);
              },
              barrierDismissible: true,
              // 語義化標籤(HTML)
              barrierLabel:
                  MaterialLocalizations.of(context).modalBarrierDismissLabel,
              // 動畫時間
              transitionDuration: const Duration(milliseconds: 150),
              // 自訂動畫
              transitionBuilder:
                  (context, animation, secondaryAnimation, child) {
                // 使用縮放動畫
                return ScaleTransition(
                  scale: CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOut,
                  ),
                  child: child,
                );
              },
            );
          },
        ));
  }
}
