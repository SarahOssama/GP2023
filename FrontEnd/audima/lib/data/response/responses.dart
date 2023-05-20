import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
part 'responses.g.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: "statuscode")
  int? status;
  @JsonKey(name: "message")
  String? message;
}

//login response
@JsonSerializable()
class CustomerResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "numOfNotifications")
  int? numOfNotifications;
  CustomerResponse(this.id, this.name, this.numOfNotifications);

  //from json
  factory CustomerResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerResponseFromJson(json);

  //to   json
  Map<String, dynamic> toJson() => _$CustomerResponseToJson(this);
}

@JsonSerializable()
class ContactsResponse {
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "link")
  String? link;
  ContactsResponse(this.phone, this.email, this.link);

  //from json
  factory ContactsResponse.fromJson(Map<String, dynamic> json) =>
      _$ContactsResponseFromJson(json);

  //to   json
  Map<String, dynamic> toJson() => _$ContactsResponseToJson(this);
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse {
  @JsonKey(name: "customer")
  CustomerResponse? customer;
  @JsonKey(name: "contacts")
  ContactsResponse? contacts;
  AuthenticationResponse(this.customer, this.contacts);

  //from json
  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);

  //to   json
  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}

//businessInfo response
@JsonSerializable()
class MissionStatementResponse extends BaseResponse {
  @JsonKey(name: "prediction")
  String? missionStatement;

  MissionStatementResponse(this.missionStatement);

  //from json
  factory MissionStatementResponse.fromJson(Map<String, dynamic> json) =>
      _$MissionStatementResponseFromJson(json);

  //to   json
  Map<String, dynamic> toJson() => _$MissionStatementResponseToJson(this);
}

//video response
@JsonSerializable()
class VideoResponse extends BaseResponse {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "media_file")
  String? videoPath;

  VideoResponse(this.id, this.videoPath);

  //from json
  factory VideoResponse.fromJson(Map<String, dynamic> json) =>
      _$VideoResponseFromJson(json);

  //to   json
  Map<String, dynamic> toJson() => _$VideoResponseToJson(this);
}

//ConfirmEdit response
@JsonSerializable()
class ConfirmEditResponse extends BaseResponse {
  @JsonKey(name: "action")
  String? action;
  @JsonKey(name: "videoDuration")
  double? videoDuration;
  @JsonKey(name: "features")
  Map<String, dynamic>? features;
  ConfirmEditResponse(this.action, this.features);

  //from json
  factory ConfirmEditResponse.fromJson(Map<String, dynamic> json) =>
      _$ConfirmEditResponseFromJson(json);

  //to   json
  Map<String, dynamic> toJson() => _$ConfirmEditResponseToJson(this);
}
