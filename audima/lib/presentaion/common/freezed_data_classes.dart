import 'package:freezed_annotation/freezed_annotation.dart';
part 'freezed_data_classes.freezed.dart';

@freezed
class LoginObject with _$LoginObject {
  factory LoginObject(String username, String password) = _LoginObject;
}

@freezed
class BusinessInfoObject with _$BusinessInfoObject {
  factory BusinessInfoObject(String companyName, String brandPersonality,
      String industryType, String serviceProvided) = _BusinessInfoObject;
}

@freezed
class MissionStatementObject with _$MissionStatementObject {
  factory MissionStatementObject(String missionStatement) =
      _MissionStatementObject;
}

@freezed
class VideoEditsObject with _$VideoEditsObject {
  factory VideoEditsObject(String videoEdits) = _VideoEditsObject;
}
