// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginInfo _$LoginInfoFromJson(Map<String, dynamic> json) => LoginInfo(
      expiredTimestamp: json['expiredTimestamp'] as String?,
      refreshTimestamp: json['refreshTimestamp'] as int,
      voteToken: json['voteToken'] as String,
      uid: json['uid'] as String,
      uidImage: json['uidImage'] as String,
    );

Map<String, dynamic> _$LoginInfoToJson(LoginInfo instance) => <String, dynamic>{
      'expiredTimestamp': instance.expiredTimestamp,
      'refreshTimestamp': instance.refreshTimestamp,
      'voteToken': instance.voteToken,
      'uid': instance.uid,
      'uidImage': instance.uidImage,
    };
