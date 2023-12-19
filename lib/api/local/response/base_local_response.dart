import 'package:qpp_example/model/qpp_item.dart';
import 'package:qpp_example/model/vote/qpp_vote.dart';

/// use for local api
class BaseLocalResponse {
  const BaseLocalResponse({required this.json});

  final Map<String, dynamic> json;

  /// 錯誤訊息
  List<LocalResponseErrorInfo>? get errorInfoArray {
    // errorInfo 可能回 null
    try {
      final List<dynamic>? errorInfo = json['errorInfo'];

      if (errorInfo == null) {
        return null;
      }

      final data = List<dynamic>.from(errorInfo);

      return data
          .map((e) =>
              LocalResponseErrorInfo(json: e as Map<String, dynamic>? ?? {}))
          .toList();
    } catch (exception) {
      print({'ErrorInfoArray Error: $exception'});
      return null;
    }
  }

  /// 錯誤訊息(0003)
  LocalResponseErrorInfo? get qppReturnError {
    try {
      return errorInfoArray
          ?.firstWhere((element) => element.errorCode == '0003');
    } catch (e) {
      print('qppReturnError Error: $e');
      return null;
    }
  }

  /// 是否成功
  bool get isSuccess => status == 1;

  /// response 狀態
  int get status => int.parse(json['status']);

  /// response 內容
  dynamic get content {
    try {
      return json['content'];
    } catch (exception) {
      return "";
    }
  }
}

/// LocalResponse 錯誤訊息
class LocalResponseErrorInfo {
  final Map<String, dynamic> json;

  const LocalResponseErrorInfo({required this.json});

  String get errorMessage {
    return json['errorMessage'];
  }

  String get errorCode {
    return json['errorCode'];
  }

  String get errorItem {
    return json['errorItem'];
  }
}

/// BaseLocalResponse 擴充
extension BaseLocalResponseExtension on BaseLocalResponse {
  /// 若 content 為問券資料, 可直接使用, 取得問券資料
  QppVote? getVoteData(QppItem item) {
    try {
      return QppVote.create(item, content);
    } catch (e) {
      print({'QppVote Failure: $e'});
      return null;
    }
  }
}
