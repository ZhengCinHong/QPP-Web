import 'package:flutter/widgets.dart';

class NFTInfoTeachImgSize {
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
}
