import 'package:freezed_annotation/freezed_annotation.dart';
part 'freezed_data_classes.freezed.dart';

@freezed
class LoginObject with _$LoginObject {
  factory LoginObject(String username, String password) = _LoginObject;
}

@freezed
class CompanyNameObject with _$CompanyNameObject {
  factory CompanyNameObject(String company) = _CompanyNameObject;
}

@freezed
class BrandPersonalityObject with _$BrandPersonalityObject {
  factory BrandPersonalityObject(String brandCharacteristic) =
      _BrandPersonalityObject;
}
