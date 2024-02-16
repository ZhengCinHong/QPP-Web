import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:qpp_example/utils/qpp_image.dart';

class NFTInfoTeachImgUtil {
  static final List<Size> mobileSizeList = [
    const Size(255, 454),
    const Size(255, 553),
    const Size(255, 553),
    const Size(255, 553),
    const Size(255, 454),
    const Size(255, 553),
    const Size(255, 553),
    const Size(255, 551),
    const Size(255, 552),
    const Size(255, 553),
    const Size(279, 142),
    const Size(279, 203),
    const Size(279, 400),
    const Size(279, 141),
    const Size(279, 142),
    const Size(279, 142),
    const Size(279, 142),
    const Size(255, 547),
    const Size(255, 553),
    const Size(255, 553),
    const Size(255, 404),
    const Size(279, 190),
    const Size(279, 171),
    const Size(279, 131),
  ];

  static final List<Size> desktopSizeList = [
    const Size(255, 454),
    const Size(255, 553),
    const Size(255, 553),
    const Size(255, 553),
    const Size(310, 552),
    const Size(255, 553),
    const Size(255, 553),
    const Size(255, 551),
    const Size(255, 552),
    const Size(255, 553),
    const Size(1206, 609),
    const Size(791, 573),
    const Size(400, 573),
    const Size(1206, 609),
    const Size(1206, 610),
    const Size(1206, 609),
    const Size(1206, 610),
    const Size(255, 547),
    const Size(255, 553),
    const Size(255, 553),
    const Size(255, 404),
    const Size(600, 409),
    const Size(600, 365),
    const Size(600, 283),
  ];

  /// NFT 教學頁 大圖列表
  static final List<String> infoTeachImgList = [
    QPPImages.desktop_pic_nft_instruction_01,
    QPPImages.desktop_pic_nft_instruction_02,
    QPPImages.desktop_pic_nft_instruction_03,
    QPPImages.desktop_pic_nft_instruction_04,
    QPPImages.desktop_pic_nft_instruction_05,
    QPPImages.desktop_pic_nft_instruction_06,
    QPPImages.desktop_pic_nft_instruction_07,
    QPPImages.desktop_pic_nft_instruction_08,
    QPPImages.desktop_pic_nft_instruction_09,
    QPPImages.desktop_pic_nft_instruction_10,
    QPPImages.desktop_pic_nft_instruction_11,
    QPPImages.desktop_pic_nft_instruction_12,
    QPPImages.desktop_pic_nft_instruction_13,
    QPPImages.desktop_pic_nft_instruction_14,
    QPPImages.desktop_pic_nft_instruction_15,
    QPPImages.desktop_pic_nft_instruction_16,
    QPPImages.desktop_pic_nft_instruction_17,
    QPPImages.desktop_pic_nft_instruction_18,
    QPPImages.desktop_pic_nft_instruction_19,
    QPPImages.desktop_pic_nft_instruction_20,
    QPPImages.desktop_pic_nft_instruction_21,
    QPPImages.desktop_pic_nft_instruction_22,
    QPPImages.desktop_pic_nft_instruction_23,
    QPPImages.desktop_pic_nft_instruction_24,
  ];

  static int getWidth(int index, bool isDesktop) {
    Size size = isDesktop ? desktopSizeList[index] : mobileSizeList[index];
    return size.width.toInt();
  }

  static int getHeight(int index, bool isDesktop) {
    Size size = isDesktop ? desktopSizeList[index] : mobileSizeList[index];
    return size.height.toInt();
  }

  static Size getSize(int index, bool isDesktop) {
    return isDesktop ? desktopSizeList[index] : mobileSizeList[index];
  }

  /// 取得對應圖片 Widget
  static Widget getImg(int index, bool isDesktop) {
    Size size = getSize(index, isDesktop);
    String path = infoTeachImgList[index];
    return SizedBox(
      key: ValueKey('sb$index'),
      width: size.width,
      height: size.height,
      child: Builder(builder: (context) {
        return GestureDetector(
          onTap: () {
            // 顯示自訂 dialog
            showGeneralDialog(
              // 點擊跳出圖片 dialog
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
                    // 可縮放及移動元件
                    child: InteractiveViewer(
                      clipBehavior: Clip.none,
                      child: Image.asset(
                        path,
                        errorBuilder: (context, error, stackTrace) {
                          return const SizedBox.shrink();
                        },
                      ),
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
          child: Image.asset(
            path,
            key: ValueKey(infoTeachImgList[index]),
            // TODO: 先拿掉 cache size, android 手機吃 cavakit render 圖片會變很小
            // cacheHeight: size.height.toInt(),
            // cacheWidth: size.width.toInt(),
          ),
        );
      }),
    );
  }
}
