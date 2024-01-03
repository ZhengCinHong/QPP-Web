import 'package:qpp_example/utils/qpp_image.dart';

enum ItemSubCategory {
  unKnow(-1),
  serial(1),
  qrCodeOrSpecial(2),
  customSpecialCard(3);

  final int value;

  const ItemSubCategory(this.value);

  factory ItemSubCategory.findTypeByValue(int value) {
    for (var subCategory in ItemSubCategory.values) {
      if (subCategory.value == value) {
        return subCategory;
      }
    }
    return ItemSubCategory.unKnow;
  }

  /// 取得顯示名稱
  String get displayName {
    return switch (this) {
      serial => "序號",
      qrCodeOrSpecial => "QR Code",
      _ => "unknown",
    };
  }
  /// 取得多語系 key
  String get multiLangKey {
    return switch (this) {
      // 序號
      serial => "commodity_info_type_number",
      // QR Code
      qrCodeOrSpecial => "commodity_info_type_qrcode",
      _ => "unknown",
    };
  }

  /// 取得 icon 路徑
  String get iconPath {
    return switch (this) {
      serial => QPPImages.icon_display_scratch_card_serial_number,
      qrCodeOrSpecial => QPPImages.desktop_icon_display_scratch_card_qr_code,
      _ => "unknown",
    };
  }
}
