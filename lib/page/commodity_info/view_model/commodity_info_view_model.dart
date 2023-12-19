import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:qpp_example/api/core/api_response.dart';
import 'package:qpp_example/api/client/api/client_api.dart';
import 'package:qpp_example/api/client/response/item_select.dart';
import 'package:qpp_example/api/client/response/multi_language_item_data.dart';
import 'package:qpp_example/api/client/response/multi_language_item_description_select.dart';
import 'package:qpp_example/api/client/response/multi_language_item_intro_link_select.dart';
import 'package:qpp_example/api/client/response/user_select_info.dart';
import 'package:qpp_example/api/core/http_service.dart';
import 'package:qpp_example/api/local/api/local_api.dart';
import 'package:qpp_example/api/local/response/base_local_response.dart';
import 'package:qpp_example/api/local/response/get_vote_info.dart';
import 'package:qpp_example/api/local/response/get_vote_status.dart';
import 'package:qpp_example/api/local/response/user_vote.dart';
import 'package:qpp_example/api/nft/nft_meta_api.dart';
import 'package:qpp_example/extension/string/text.dart';
import 'package:qpp_example/model/enum/item/item_category.dart';
import 'package:qpp_example/model/item_img_data.dart';
import 'package:qpp_example/model/item_multi_language_data.dart';
import 'package:qpp_example/model/nft/qpp_nft.dart';
import 'package:qpp_example/model/qpp_item.dart';
import 'package:qpp_example/model/qpp_user.dart';
import 'package:qpp_example/model/vote/qpp_vote.dart';
import 'package:qpp_example/page/commodity_info/model/vote_model.dart';
import 'package:qpp_example/utils/qpp_image_utils.dart';
import 'package:qpp_example/utils/shared_prefs_utils.dart';

/// 物品資訊頁 model
class CommodityInfoModel extends ChangeNotifier {
  /// 物品資訊
  ApiResponse<QppItem> itemSelectInfoState = ApiResponse.initial();

  /// 問券資訊
  ApiResponse<QppVote> voteDataState = ApiResponse.initial();

  /// NFT 物品資訊
  ApiResponse<QppNFT> nftMetaDataState = ApiResponse.initial();

  /// 物品多語系說明資訊
  ApiResponse<ItemMultiLanguageData> itemDescriptionInfoState =
      ApiResponse.initial();

  /// 物品多語系連結資訊
  ApiResponse<ItemMultiLanguageData> itemLinkInfoState = ApiResponse.initial();

  /// 創建者資訊狀態
  ApiResponse<QppUser> userInfoState = ApiResponse.initial();

  /// 物品圖片狀態
  ApiResponse<ItemImgData> itemPhotoState = ApiResponse.initial();

  /// 是否為錯誤選項陣列
  List<bool> isOptionErrorArray = [];

  /// 投票狀態(是否已投票，已投票狀態)
  (bool, VotedState) votedState = (false, VotedState.none);

  ///  是否為第一次登入(自動發送投票使用)
  bool isFirstLogin = true;

  final client = ClientApi.client;

  /// 開始取得物品資訊
  loadData(String id) {
    debugPrint('開始取得物品資訊...');
    if (id.isNullOrEmpty) {
      itemSelectInfoState = ApiResponse.error('無物品ID');
      notifyListeners();
    } else {
      // 是否為 NFT 物品
      if (id.isNFTId) {
        getNFTMetaData(id);
      } else {
        // 一般物品 取物品資訊及多語系說明/連結
        getNormalItemInfo(id);
        getMultiLanguageItemDescription(id);
        getMultiLanguageItemIntroLink(id);
      }
    }
  }

  /// 取得 NFT 物品 MetaData
  getNFTMetaData(String id) {
    nftMetaDataState = ApiResponse.loading();
    notifyListeners();
    var nftClient = NftMetaApi.client;

    nftClient.getNFTMeta(id).then((nftMetaDataResponse) {
      QppNFT nft = nftMetaDataResponse.NFT;
      // 取得 NFT MetaData 成功, 取發行者資料
      getUserInfo(int.parse(nft.publisherID));
      nftMetaDataState = ApiResponse.completed(nft);
      String itemPhotoUrl = nft.image;

      itemPhotoState = ApiResponse.completed(
          ItemImgData.nft(path: itemPhotoUrl, colorHex: nft.backgroundColor));
      notifyListeners();
    }).catchError(getItemInfoError);
  }

  /// 取得非 NFT 的其他物品資訊
  getNormalItemInfo(String id) {
    itemSelectInfoState = ApiResponse.loading();
    notifyListeners();
    String requestBody = ItemSelectRequest().createItemSelectBody([id]);

    client.postItemSelect(requestBody).then((itemSelectResponse) {
      if (itemSelectResponse.errorCode == "OK") {
        ItemData itemData = itemSelectResponse.getItem(0);
        QppItem item = QppItem.create(itemData);

        if (item.category == ItemCategory.questionnaire) {
          final loginInfo = SharedPrefs.getLoginInfo();

          if (loginInfo?.isLogin == true) {
            // 取使用者問券資料
            _getVoteStatus(item, loginInfo?.voteToken ?? '');
          } else {
            // 取問券資料
            getQuestionnaire(item);
          }
        } else {
          // 非問券的物品,通知成功
          itemSelectInfoState = ApiResponse.completed(item);
        }

        // 取物品資訊成功後, 取得創建者資料
        int? creatorId = item.creatorId;
        getUserInfo(creatorId);
        getItemImage(item.id, creatorId);
      } else {
        itemSelectInfoState = ApiResponse.error(itemSelectResponse.errorCode);
        print('取得物品資訊錯誤 SERVER_ERROR_CODE: ${itemSelectResponse.errorCode}');
      }
      notifyListeners();
    }).catchError(getItemInfoError);
  }

  /// 取物品資訊錯誤
  getItemInfoError(dynamic error) {
    // 無此物品
    itemSelectInfoState = ApiResponse.error(error);
    notifyListeners();
    print('取得物品資訊錯誤: $error');
  }

  /// 取得物品說明資訊
  getMultiLanguageItemDescription(String id) {
    itemDescriptionInfoState = ApiResponse.loading();
    notifyListeners();
    String requestBody =
        MultiLanguageItemDescriptionSelectRequest().createBody(id);

    client
        .postMultiLanguageItemDescriptionSelect(requestBody)
        .then((descriptionResponse) {
      if (descriptionResponse.errorCode == "OK") {
        MultiLanguageItemData descriptionData =
            descriptionResponse.descriptionData;
        ItemMultiLanguageData itemDescription =
            ItemMultiLanguageData.description(descriptionData);
        itemDescriptionInfoState = ApiResponse.completed(itemDescription);
      } else {
        itemDescriptionInfoState =
            ApiResponse.error(descriptionResponse.errorCode);
        print('取得物品說明資訊錯誤 SERVER_ERROR_CODE: ${descriptionResponse.errorCode}');
      }
      notifyListeners();
    }).catchError((error) {
      itemDescriptionInfoState = ApiResponse.error(error);
      notifyListeners();
      print('取得物品說明資訊錯誤: $error');
    });
  }

  /// 取得物品連結資訊
  getMultiLanguageItemIntroLink(String id) {
    itemLinkInfoState = ApiResponse.loading();
    notifyListeners();
    String requestBody =
        MultiLanguageItemIntroLinkSelectRequest().createBody(id);

    client
        .postMultiLanguageItemIntroLinkSelect(requestBody)
        .then((introLinkResponse) {
      if (introLinkResponse.errorCode == "OK") {
        MultiLanguageItemData introLinkData = introLinkResponse.introLinkData;
        ItemMultiLanguageData itemIntroLink =
            ItemMultiLanguageData.link(introLinkData);
        itemLinkInfoState = ApiResponse.completed(itemIntroLink);
      } else {
        itemLinkInfoState = ApiResponse.error(introLinkResponse.errorCode);
        print('取得物品連結資訊錯誤 SERVER_ERROR_CODE: ${introLinkResponse.errorCode}');
      }
      notifyListeners();
    }).catchError((error) {
      itemLinkInfoState = ApiResponse.error(error);
      notifyListeners();
      print('取得物品連結資訊錯誤: $error');
    });
  }

  /// 取得用戶資訊
  getUserInfo(int userID) {
    userInfoState = ApiResponse.loading();
    notifyListeners();

    final request = UserSelectInfoRequest().createBody(userID.toString());

    client.postUserSelect(request).then((userSelectInfoResponse) {
      if (userSelectInfoResponse.errorCode == "OK") {
        // 取得創建用戶
        QppUser creator = QppUser.create(userID, userSelectInfoResponse);
        userInfoState = ApiResponse.completed(creator);
      } else {
        userInfoState = ApiResponse.error(userSelectInfoResponse.errorCode);
        print(
            '取得創建者用戶資訊錯誤 SERVER_ERROR_CODE: ${userSelectInfoResponse.errorCode}');
      }
      notifyListeners();
    }).catchError((error) {
      userInfoState = ApiResponse.error(error);
      notifyListeners();
    });
  }

  /// 取得物品圖片
  getItemImage(int itemId, int creatorID) async {
    var timeUTC = DateTime.now().millisecondsSinceEpoch;
    String itemPhotoUrl =
        QppImageUtils.getItemImageURL(creatorID, itemId, timeStamp: timeUTC);
    // 確認是否有圖片, 有圖的要顯示框線, 沒圖或拿不到顯示預設圖不顯示框線
    try {
      // 成功表示有圖
      await HttpService.instance.dio.get(itemPhotoUrl,
          options: Options(responseType: ResponseType.bytes));
      itemPhotoState = ApiResponse.completed(ItemImgData(itemPhotoUrl));
    } on DioException catch (exception) {
      // 無圖或取得圖片錯誤
      itemPhotoState = ApiResponse.error(exception.message);
      debugPrint(exception.message);
    }
    notifyListeners();
  }

  /// 取得投票資訊
  void getQuestionnaire(QppItem item) {
    voteDataState = ApiResponse.loading();
    notifyListeners();
    final request = GetVoteInfoRequest().createBody(item.id.toString());
    LocalApi.client.postGetVoteInfo(request).then((getVoteInfoResponse) {
      if (getVoteInfoResponse.isSuccess) {
        // 取資料成功
        QppVote? vote = getVoteInfoResponse.getVoteData(item);
        voteDataState = ApiResponse.completed(vote);
        isOptionErrorArray = vote?.voteData.map((e) => false).toList() ?? [];
      } else {
        // 取資料失敗
        voteDataState =
            ApiResponse.error(getVoteInfoResponse.qppReturnError?.errorMessage);
      }
      notifyListeners();
    }).catchError((onError) {
      // 取資料失敗
      voteDataState = ApiResponse.error(onError.toString());
      notifyListeners();
    });
  }

  /// 選擇選項
  void selectedOption(int index, int option) {
    voteDataState.data?.voteArrayData[index] = option;
    voteDataState = ApiResponse.completed(voteDataState.data);
    notifyListeners();
  }

  /// 設定錯誤選項
  void setupErrorOptions() {
    // 創一個新的，不然riverpod會判斷不出有更新
    isOptionErrorArray = List<bool>.from(isOptionErrorArray);
    voteDataState.data?.voteArrayData.asMap().forEach((i, e) {
      isOptionErrorArray[i] = e == -1; // 代表未選擇
    });
    notifyListeners();
  }

  /// 更新錯誤選項
  void updateErrorOptions(int index, bool isError) {
    // 創一個新的，不然riverpod會判斷不出有更新
    isOptionErrorArray = List<bool>.from(isOptionErrorArray);
    isOptionErrorArray[index] = isError;
    notifyListeners();
  }

  /// 送出用戶投票
  void sendUserVote(QppItem item, String voteToken) {
    final request = UserVoteRequest().createBody(
      itemId: item.id.toString(),
      myVote: voteDataState.data?.voteArrayData ?? [],
      voteToken: voteToken,
    );

    voteDataState = ApiResponse.loading();
    notifyListeners();

    LocalApi.client.postUserVote(request).then((userVoteResponse) {
      if (userVoteResponse.isSuccess) {
        // 投票成功
        QppVote? vote = userVoteResponse.getVoteData(item);
        voteDataState = ApiResponse.completed(vote);

        // 更新成已投票狀態
        votedState = (
          true,
          VotedState.findTypeByCode(
              userVoteResponse.qppReturnError?.errorMessage ?? '')
        );
      } else {
        // 更新成未投票狀態
        votedState = (false, VotedState.unkown);
      }
      notifyListeners();
    }).catchError((onError) {
      print('sendUserVote Error: ${onError.toString()}');
      // 投票失敗
      voteDataState = ApiResponse.error(onError.toString());
      notifyListeners();
    });
  }

  /// 拿取投票狀態(登入後)
  void _getVoteStatus(QppItem item, String voteToken) {
    voteDataState = ApiResponse.loading();
    notifyListeners();

    final request = GetVoteStatusRequest().createBody(
      itemId: item.id.toString(),
      voteToken: voteToken,
    );

    LocalApi.client.postGetVoteStatus(request).then((getVoteStatusResponse) {
      if (getVoteStatusResponse.isSuccess) {
        // 取資料成功
        QppVote? vote = getVoteStatusResponse.getVoteData(item);
        voteDataState = ApiResponse.completed(vote);
        isOptionErrorArray = vote?.voteData.map((e) => false).toList() ?? [];

        // 更新投票狀態
        // 選項沒有錯誤或是創建者，就代表已經投票過
        votedState = (
          vote?.haveOptionError == false ||
              item.creatorId == userInfoState.data?.id,
          VotedState.none
        );
      } else {
        // 取資料失敗
        voteDataState = ApiResponse.error(
            getVoteStatusResponse.qppReturnError?.errorMessage);
      }
      notifyListeners();
    }).catchError((onError) {
      print('_getVoteStatus Error: ${onError.toString()}');
      // 取資料失敗
      voteDataState = ApiResponse.error(onError.toString());
      notifyListeners();
    });
  }
}
