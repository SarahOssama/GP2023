//business info models
import 'package:audima/presentaion/common/freezed_data_classes.dart';
import 'package:flutter/material.dart';

//company name models
class CompanyNameQuestionObject {
  String hint;
  CompanyNameQuestionObject(this.hint);
}

class CompanyNameQuestionViewObject {
  CompanyNameQuestionObject companyNameQuestionObject;
  String question;
  CompanyNameQuestionViewObject(this.companyNameQuestionObject, this.question);
}

//brand perosnality models
class BrandPersonalityQuestionObject {
  String brandpersonality;
  String imgUrl;
  bool isSelected;
  bool isHovered;
  int index;
  Color color;
  BrandPersonalityQuestionObject(this.brandpersonality, this.imgUrl,
      this.isSelected, this.isHovered, this.index, this.color);
}

class BrandPersonalityQuestionViewObject {
  List<BrandPersonalityQuestionObject> brandPersonalityList;
  String question;
  BrandPersonalityQuestionViewObject(this.brandPersonalityList, this.question);
}

//company industry type
class CompanyIndustryTypeQuestionObject {
  String? industrytype;
  CompanyIndustryTypeQuestionObject(this.industrytype);
}

class CompanyIndustryTypeQuestionViewObject {
  List<CompanyIndustryTypeQuestionObject> companyIndustryTypeQuestionObject;
  String question;
  CompanyIndustryTypeQuestionViewObject(
      this.companyIndustryTypeQuestionObject, this.question);
}

//company service description
class CompanyServiceDescriptionQuestionObject {
  String hint;
  CompanyServiceDescriptionQuestionObject(this.hint);
}

class CompanyServiceDescriptionQuestionViewObject {
  CompanyServiceDescriptionQuestionObject
      companyServiceDescriptionQuestionObject;
  String question;
  CompanyServiceDescriptionQuestionViewObject(
      this.companyServiceDescriptionQuestionObject, this.question);
}

//business info all data model
class BusinessWholeData {
  BusinessInfoObject businessInfoObject;
  bool isBusinessInfoCompleted;
  BusinessWholeData(this.businessInfoObject, this.isBusinessInfoCompleted);
}

//---------------------------------------------------------------------------------------apis models

//login models

class Customer {
  String id;
  String name;
  int numOfNotifications;
  Customer(this.id, this.name, this.numOfNotifications);
}

class Contacts {
  String phone;
  String email;
  String link;
  Contacts(this.phone, this.email, this.link);
}

//above in premitave models like customers and contacts every single datatype must be non nullable
//but down in Authentication this model is non premative as it contains objects inside it so it should be nullable
class Authentication {
  Customer? customer;
  Contacts? contacts;
  Authentication(this.customer, this.contacts);
}

class MissionStatement {
  String missionStatement;
  MissionStatement(this.missionStatement);
}

class Video {
  int id;
  String videoUrl;
  String caption;
  Video(this.id, this.videoUrl, this.caption);
}

class ConfirmEdit {
  String message;
  String action;
  double videoDuration;
  Map<String, dynamic> features;
  ConfirmEdit(this.message, this.action, this.videoDuration, this.features);
}
