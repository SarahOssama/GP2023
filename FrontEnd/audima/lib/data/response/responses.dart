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

// @JsonSerializable()
// class UsageResponse {
//   @JsonKey(name: "prompt_tokens")
//   int? promptTokens;
//   @JsonKey(name: "completion_tokens")
//   int? completionTokens;
//   @JsonKey(name: "total_tokens")
//   int? totalTokens;
//   UsageResponse(this.promptTokens, this.completionTokens, this.totalTokens);

//   //from json
//   factory UsageResponse.fromJson(Map<String, dynamic> json) =>
//       _$UsageResponseFromJson(json);

//   //to   json
//   Map<String, dynamic> toJson() => _$UsageResponseToJson(this);
// }

// @JsonSerializable()
// class DataResponse {
//   @JsonKey(name: "id")
//   String? id;
//   @JsonKey(name: "object")
//   String? object;
//   @JsonKey(name: "created")
//   int? created;
//   @JsonKey(name: "model")
//   String? model;
//   @JsonKey(name: "choices")
//   List<ChoicesResponse>? choices;
//   @JsonKey(name: "usage")
//   UsageResponse? usage;
//   DataResponse(
//       this.id, this.object, this.created, this.model, this.choices, this.usage);

//   //from json
//   factory DataResponse.fromJson(Map<String, dynamic> json) =>
//       _$DataResponseFromJson(json);

//   //to   json
//   Map<String, dynamic> toJson() => _$DataResponseToJson(this);
// }

// @JsonSerializable()
// class BusinessInfoResponse extends BaseResponse {
//   @JsonKey(name: "data")
//   DataResponse? data;
//   BusinessInfoResponse(this.data);

//   //from json
//   factory BusinessInfoResponse.fromJson(Map<String, dynamic> json) =>
//       _$BusinessInfoResponseFromJson(json);

//   //to   json
//   Map<String, dynamic> toJson() => _$BusinessInfoResponseToJson(this);
// }
