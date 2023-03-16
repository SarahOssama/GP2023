import 'package:freezed_annotation/freezed_annotation.dart';
part 'freezed_data_classes.freezed.dart';

@freezed
class LoginObject with _$LoginObject {
  factory LoginObject(String username, String password) = _LoginObject;
}

@freezed
class TextObject with _$TextObject {
  factory TextObject(String text) = _TextObject;
}

@freezed
class BrandPersonalityObject with _$BrandPersonalityObject {
  factory BrandPersonalityObject(String brandCharacteristic) =
      _BrandPersonalityObject;
}

@freezed
class CompanyIndustryTypeObject with _$CompanyIndustryTypeObject {
  factory CompanyIndustryTypeObject(String industryType) =
      _CompanyIndustryTypeObject;
}
