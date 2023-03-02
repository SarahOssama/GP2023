import 'package:audima/app/constants.dart';
import 'package:audima/data/response/responses.dart';
import 'package:audima/app/extensions.dart';
import '../../domain/model/models.dart';
//map from nullable responses to non null models

//map between data layer to domain

//like I change objects in data layer to objects in domain layer
extension CustomerResponseMapper on CustomerResponse? {
  // "this" word here is like i access customerResponse class
  Customer toDomain() {
    return Customer(
      this?.id.orEmpty() ?? Constants.empty,
      this?.name.orEmpty() ?? Constants.empty,
      this?.numOfNotifications.orZero() ?? Constants.zero,
    );
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  Contacts toDomain() {
    return Contacts(
      this?.phone.orEmpty() ?? Constants.empty,
      this?.email.orEmpty() ?? Constants.empty,
      this?.link.orEmpty() ?? Constants.empty,
    );
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(
      //so here customer response is changed to customer model
      this?.customer.toDomain(),
      //so here contacts response is changed to contacts model
      this?.contacts.toDomain(),
    );
  }
}
