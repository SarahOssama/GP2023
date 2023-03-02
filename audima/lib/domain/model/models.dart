//business info models

class BusinessInfoObject {
  String question;
  String hint;
  String answer;
  BusinessInfoObject(this.question, this.hint, this.answer);
}

class BusinessInfoViewObject {
  BusinessInfoObject businessInfoObject;
  int numOfSlides;
  int currentIndex;
  BusinessInfoViewObject(
      this.businessInfoObject, this.numOfSlides, this.currentIndex);
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
  Contacts? customer;
  Customer? contacts;
  Authentication(this.customer, this.contacts);
}
