// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse _$BaseResponseFromJson(Map<String, dynamic> json) => BaseResponse()
  ..status = json['statuscode'] as int?
  ..message = json['message'] as String?;

Map<String, dynamic> _$BaseResponseToJson(BaseResponse instance) =>
    <String, dynamic>{
      'statuscode': instance.status,
      'message': instance.message,
    };

CustomerResponse _$CustomerResponseFromJson(Map<String, dynamic> json) =>
    CustomerResponse(
      json['id'] as String?,
      json['name'] as String?,
      json['numOfNotifications'] as int?,
    );

Map<String, dynamic> _$CustomerResponseToJson(CustomerResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'numOfNotifications': instance.numOfNotifications,
    };

ContactsResponse _$ContactsResponseFromJson(Map<String, dynamic> json) =>
    ContactsResponse(
      json['phone'] as String?,
      json['email'] as String?,
      json['link'] as String?,
    );

Map<String, dynamic> _$ContactsResponseToJson(ContactsResponse instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'email': instance.email,
      'link': instance.link,
    };

AuthenticationResponse _$AuthenticationResponseFromJson(
        Map<String, dynamic> json) =>
    AuthenticationResponse(
      json['customer'] == null
          ? null
          : CustomerResponse.fromJson(json['customer'] as Map<String, dynamic>),
      json['contacts'] == null
          ? null
          : ContactsResponse.fromJson(json['contacts'] as Map<String, dynamic>),
    )
      ..status = json['statuscode'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$AuthenticationResponseToJson(
        AuthenticationResponse instance) =>
    <String, dynamic>{
      'statuscode': instance.status,
      'message': instance.message,
      'customer': instance.customer,
      'contacts': instance.contacts,
    };

MissionStatementResponse _$MissionStatementResponseFromJson(
        Map<String, dynamic> json) =>
    MissionStatementResponse(
      json['prediction'] as String?,
    )
      ..status = json['statuscode'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$MissionStatementResponseToJson(
        MissionStatementResponse instance) =>
    <String, dynamic>{
      'statuscode': instance.status,
      'message': instance.message,
      'prediction': instance.missionStatement,
    };

VideoResponse _$VideoResponseFromJson(Map<String, dynamic> json) =>
    VideoResponse(
      json['id'] as int?,
      json['media_file'] as String?,
      json['caption'] as String?,
    )
      ..status = json['statuscode'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$VideoResponseToJson(VideoResponse instance) =>
    <String, dynamic>{
      'statuscode': instance.status,
      'message': instance.message,
      'id': instance.id,
      'media_file': instance.videoPath,
      'caption': instance.caption,
    };

ConfirmEditResponse _$ConfirmEditResponseFromJson(Map<String, dynamic> json) =>
    ConfirmEditResponse(
      json['action'] as String?,
      json['features'] as Map<String, dynamic>?,
    )
      ..status = json['statuscode'] as int?
      ..message = json['message'] as String?
      ..videoDuration = (json['videoDuration'] as num?)?.toDouble();

Map<String, dynamic> _$ConfirmEditResponseToJson(
        ConfirmEditResponse instance) =>
    <String, dynamic>{
      'statuscode': instance.status,
      'message': instance.message,
      'action': instance.action,
      'videoDuration': instance.videoDuration,
      'features': instance.features,
    };
