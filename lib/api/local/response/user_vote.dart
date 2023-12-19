import 'dart:convert';
import 'package:qpp_example/api/local/response/base_local_response.dart';

/// 送出投票
class UserVoteRequest {
  String createBody({
    required String itemId,
    required List<int> myVote,
    required String voteToken,
  }) {
    return json.encode(
        {'ItemId': itemId, 'VoteArrayData': myVote, 'VoteToken': voteToken});
  }
}

/// 送出投票
class UserVoteResponse extends BaseLocalResponse {
  const UserVoteResponse({required super.json});

  factory UserVoteResponse.fromJson(Map<String, dynamic> json) {
    return UserVoteResponse(
      json: json,
    );
  }
}
