import 'package:qpp_example/constants/server_const.dart';
import 'package:qpp_example/extension/string/crypto.dart';

/// QPP圖片類型
enum QppImageType { user, commodity, identification }

/// QPP圖片樣式
enum QppImageStyle {
  /// 頭像
  avatar,

  /// 背景圖
  backgroundImage
}

extension ImageStyleExtension on QppImageStyle {
  int get value {
    return switch (this) {
      QppImageStyle.avatar => 1,
      QppImageStyle.backgroundImage => 2
    };
  }
}

/// Qpp圖片工具
class QppImageUtils {
  QppImageUtils._internal();

  // factory QppImageUtils() => _instance;

  static final QppImageUtils instance = QppImageUtils._internal();

  /// 商品圖片下載位址
  static String commodityImageUrl = "${ServerConst.storage}Item/";

  /// 用戶圖片下載位址
  static String userImageUrl = "${ServerConst.storage}Profile/";

  /// 取得用戶圖片檔名
  /// - Parameters:
  ///   - userID: 使用者ID
  ///   - imageStyle: 圖片樣式
  /// - Returns: 圖片檔名
  static String getUserImageFileName(int userID,
      {QppImageStyle imageStyle = QppImageStyle.avatar}) {
    String hash = userID.toString().hashUID;

    return "${hash}_Image${imageStyle.value}.png";
  }

  /// 取得用戶圖片URL
  /// - Parameters:
  ///   - userID: 使用者ID
  ///   - imageStyle: 圖片樣式
  ///   - timestamp: 時戳
  static String getUserImageURL(int userID,
      {QppImageStyle imageStyle = QppImageStyle.avatar, int timestamp = 0}) {
    String fileName = getUserImageFileName(userID, imageStyle: imageStyle);
    return _getFullURLPath(QppImageType.user, fileName, timestamp: timestamp);
  }

  /// 將server路徑、fileName、timestamp組合成URL，取得完整URL路徑
  /// - Note: 要加上時戳去要，才會拿到相對應的圖片資訊
  /// - Parameters:
  ///   - type: 打圖像API的類型
  ///   - fileName: 檔名
  ///   - timestamp: 時戳
  static String _getFullURLPath(QppImageType type, String fileName,
      {int timestamp = 0}) {
    String baseURL;

    switch (type) {
      case QppImageType.commodity || QppImageType.identification:
        baseURL = QppImageUtils.commodityImageUrl;
      case QppImageType.user:
        baseURL = QppImageUtils.userImageUrl;
    }

    // let timestamp = (timestamp == 0) ? ImageUtils.checkDBTimestamp(timestamp: timestamp, fileName: fileName) : 0

    return '$baseURL$fileName?v=$timestamp';
  }

  /// 取得物品圖片
  /// - Param:
  ///   - creatorID: 創建者 ID
  ///   - itemID: 物品 ID
  ///   - timeStamp: 時戳
  static String getItemImageURL(int creatorID, int itemID,
      {int timeStamp = 0}) {
    // baseUrl - ${storage}Item/
    // fileName - hash_creator_Uid + "_" + pid + "_" + PhotoKind.PHOTO.getValue() + ".png"
    // query param - "?v=timestamp"
    String itemPhotoUrl =
        "${ServerConst.storage}Item/${creatorID.toString().hashUID}_${itemID}_Image${QppImageStyle.avatar.value}.png?v=$timeStamp";
    return itemPhotoUrl;
  }
}
