// Flutter 3.0 後, 列舉可使用方式
// https://blog.logrocket.com/deep-dive-enhanced-enums-flutter-3-0/
import 'package:qpp_example/utils/qpp_image.dart';

/// 物品類別列舉
enum ItemCategory {
  unKnow(-1),

  ///0 系統_貨幣, SystemProductKind內有詳細系統貨幣資訊
  systemCoin(0),

  ///1 問券
  questionnaire(1),

  ///2 交易_委託, server用，委托單
  commission(2),

  ///9 開放授權, server用，存授權名單

  authorize(9),

  ///101 虛擬_貨幣

  virtualCoin(101),

  ///102 虛擬_寶物

  virtualTreasure(102),

  /// 103 虛擬＿寶物含標籤

  virtualTreasureWithTag(103),

  /// 201 票券_顯示

  physicalVoucher(201),

  /// 202 票券_隱藏 (序號 ＆ QR code)

  hiddenVoucher(202),

  /// 203 票卷_數位

  digitVoucher(203),

  /// 301 識別_卡片

  idCard(301),

  /// 1000 數位物品

  digitItem(1000);

  final int value;
  const ItemCategory(this.value);

  factory ItemCategory.findTypeByValue(int value) {
    for (var category in ItemCategory.values) {
      if (category.value == value) {
        return category;
      }
    }
    return ItemCategory.unKnow;
  }

  /// 取得顯示名稱
  String get displayName {
    return switch (this) {
      systemCoin => "系統貨幣",
      questionnaire => "問券調查",
      commission => "交易_委託",
      authorize => "開放授權",
      virtualCoin => "數位貨幣",
      virtualTreasure => "虛擬寶物",
      virtualTreasureWithTag => "虛擬寶物",
      physicalVoucher => "實體票券",
      hiddenVoucher => "序號/QR Code",
      digitVoucher => "數位票券",
      idCard => "身份識別",
      digitItem => "數位物品",
      _ => "",
    };
  }

  /// 取得 icon 圖片路徑
  String get iconPath {
    switch (this) {
      case systemCoin:
      case virtualCoin:
        return QPPImages.icon_display_coin;
      case virtualTreasure:
      case virtualTreasureWithTag:
        return QPPImages.icon_display_treasure;
      case physicalVoucher:
      case digitVoucher:
        return QPPImages.icon_display_ticket;
      case idCard:
        return QPPImages.icon_display_idcard;
      case digitItem:
        return QPPImages.icon_display_digital_object;
      case hiddenVoucher:
      // 需判斷為 QR Code/序號, 在 sub category 處理
      case questionnaire:
        return QPPImages.icon_display_questionnaire;
      case commission:
      case authorize:
      default:
        return "";
    }
  }

  /// 取得多語系 key
  String get multiLangKey {
    return switch (this) {
      // 系統貨幣
      systemCoin => "commodity_info_type_system",
      // 問卷調查
      questionnaire => "commodity_info_type_vote",
      // TODO: 待語系表更新
      commission => "交易_委託",
      authorize => "開放授權",
      // 數位貨幣
      virtualCoin => "commodity_info_type_digital",
      // 虛擬寶物
      virtualTreasure => "commodity_info_type_virtual",
      // 虛擬寶物
      virtualTreasureWithTag => "commodity_info_type_virtual",
      // 實體票券
      physicalVoucher => "commodity_info_type_voucher",
      hiddenVoucher => "序號/QR Code",
      // 數位票券
      digitVoucher => "commodity_info_type_eTicket",
      // 身份識別
      idCard => "commodity_info_type_id",
      // 數位物品,
      digitItem => "commodity_info_type_digital_object",
      _ => "",
    };
  }
}
