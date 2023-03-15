//business info models
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
  String industrytype;
  String imgUrl;
  bool isSelected;
  bool isHovered;
  int index;
  Color color;
  CompanyIndustryTypeQuestionObject(this.industrytype, this.imgUrl,
      this.isSelected, this.isHovered, this.index, this.color);
}

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
