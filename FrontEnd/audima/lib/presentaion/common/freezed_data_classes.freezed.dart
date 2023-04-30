// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'freezed_data_classes.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LoginObject {
  String get username => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LoginObjectCopyWith<LoginObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginObjectCopyWith<$Res> {
  factory $LoginObjectCopyWith(
          LoginObject value, $Res Function(LoginObject) then) =
      _$LoginObjectCopyWithImpl<$Res, LoginObject>;
  @useResult
  $Res call({String username, String password});
}

/// @nodoc
class _$LoginObjectCopyWithImpl<$Res, $Val extends LoginObject>
    implements $LoginObjectCopyWith<$Res> {
  _$LoginObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? password = null,
  }) {
    return _then(_value.copyWith(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LoginObjectCopyWith<$Res>
    implements $LoginObjectCopyWith<$Res> {
  factory _$$_LoginObjectCopyWith(
          _$_LoginObject value, $Res Function(_$_LoginObject) then) =
      __$$_LoginObjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String username, String password});
}

/// @nodoc
class __$$_LoginObjectCopyWithImpl<$Res>
    extends _$LoginObjectCopyWithImpl<$Res, _$_LoginObject>
    implements _$$_LoginObjectCopyWith<$Res> {
  __$$_LoginObjectCopyWithImpl(
      _$_LoginObject _value, $Res Function(_$_LoginObject) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? password = null,
  }) {
    return _then(_$_LoginObject(
      null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_LoginObject implements _LoginObject {
  _$_LoginObject(this.username, this.password);

  @override
  final String username;
  @override
  final String password;

  @override
  String toString() {
    return 'LoginObject(username: $username, password: $password)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LoginObject &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, username, password);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LoginObjectCopyWith<_$_LoginObject> get copyWith =>
      __$$_LoginObjectCopyWithImpl<_$_LoginObject>(this, _$identity);
}

abstract class _LoginObject implements LoginObject {
  factory _LoginObject(final String username, final String password) =
      _$_LoginObject;

  @override
  String get username;
  @override
  String get password;
  @override
  @JsonKey(ignore: true)
  _$$_LoginObjectCopyWith<_$_LoginObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$BusinessInfoObject {
  String get companyName => throw _privateConstructorUsedError;
  String get brandPersonality => throw _privateConstructorUsedError;
  String get industryType => throw _privateConstructorUsedError;
  String get serviceProvided => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BusinessInfoObjectCopyWith<BusinessInfoObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BusinessInfoObjectCopyWith<$Res> {
  factory $BusinessInfoObjectCopyWith(
          BusinessInfoObject value, $Res Function(BusinessInfoObject) then) =
      _$BusinessInfoObjectCopyWithImpl<$Res, BusinessInfoObject>;
  @useResult
  $Res call(
      {String companyName,
      String brandPersonality,
      String industryType,
      String serviceProvided});
}

/// @nodoc
class _$BusinessInfoObjectCopyWithImpl<$Res, $Val extends BusinessInfoObject>
    implements $BusinessInfoObjectCopyWith<$Res> {
  _$BusinessInfoObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? companyName = null,
    Object? brandPersonality = null,
    Object? industryType = null,
    Object? serviceProvided = null,
  }) {
    return _then(_value.copyWith(
      companyName: null == companyName
          ? _value.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String,
      brandPersonality: null == brandPersonality
          ? _value.brandPersonality
          : brandPersonality // ignore: cast_nullable_to_non_nullable
              as String,
      industryType: null == industryType
          ? _value.industryType
          : industryType // ignore: cast_nullable_to_non_nullable
              as String,
      serviceProvided: null == serviceProvided
          ? _value.serviceProvided
          : serviceProvided // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_BusinessInfoObjectCopyWith<$Res>
    implements $BusinessInfoObjectCopyWith<$Res> {
  factory _$$_BusinessInfoObjectCopyWith(_$_BusinessInfoObject value,
          $Res Function(_$_BusinessInfoObject) then) =
      __$$_BusinessInfoObjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String companyName,
      String brandPersonality,
      String industryType,
      String serviceProvided});
}

/// @nodoc
class __$$_BusinessInfoObjectCopyWithImpl<$Res>
    extends _$BusinessInfoObjectCopyWithImpl<$Res, _$_BusinessInfoObject>
    implements _$$_BusinessInfoObjectCopyWith<$Res> {
  __$$_BusinessInfoObjectCopyWithImpl(
      _$_BusinessInfoObject _value, $Res Function(_$_BusinessInfoObject) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? companyName = null,
    Object? brandPersonality = null,
    Object? industryType = null,
    Object? serviceProvided = null,
  }) {
    return _then(_$_BusinessInfoObject(
      null == companyName
          ? _value.companyName
          : companyName // ignore: cast_nullable_to_non_nullable
              as String,
      null == brandPersonality
          ? _value.brandPersonality
          : brandPersonality // ignore: cast_nullable_to_non_nullable
              as String,
      null == industryType
          ? _value.industryType
          : industryType // ignore: cast_nullable_to_non_nullable
              as String,
      null == serviceProvided
          ? _value.serviceProvided
          : serviceProvided // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_BusinessInfoObject implements _BusinessInfoObject {
  _$_BusinessInfoObject(this.companyName, this.brandPersonality,
      this.industryType, this.serviceProvided);

  @override
  final String companyName;
  @override
  final String brandPersonality;
  @override
  final String industryType;
  @override
  final String serviceProvided;

  @override
  String toString() {
    return 'BusinessInfoObject(companyName: $companyName, brandPersonality: $brandPersonality, industryType: $industryType, serviceProvided: $serviceProvided)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BusinessInfoObject &&
            (identical(other.companyName, companyName) ||
                other.companyName == companyName) &&
            (identical(other.brandPersonality, brandPersonality) ||
                other.brandPersonality == brandPersonality) &&
            (identical(other.industryType, industryType) ||
                other.industryType == industryType) &&
            (identical(other.serviceProvided, serviceProvided) ||
                other.serviceProvided == serviceProvided));
  }

  @override
  int get hashCode => Object.hash(runtimeType, companyName, brandPersonality,
      industryType, serviceProvided);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BusinessInfoObjectCopyWith<_$_BusinessInfoObject> get copyWith =>
      __$$_BusinessInfoObjectCopyWithImpl<_$_BusinessInfoObject>(
          this, _$identity);
}

abstract class _BusinessInfoObject implements BusinessInfoObject {
  factory _BusinessInfoObject(
      final String companyName,
      final String brandPersonality,
      final String industryType,
      final String serviceProvided) = _$_BusinessInfoObject;

  @override
  String get companyName;
  @override
  String get brandPersonality;
  @override
  String get industryType;
  @override
  String get serviceProvided;
  @override
  @JsonKey(ignore: true)
  _$$_BusinessInfoObjectCopyWith<_$_BusinessInfoObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MissionStatementObject {
  String get missionStatement => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MissionStatementObjectCopyWith<MissionStatementObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MissionStatementObjectCopyWith<$Res> {
  factory $MissionStatementObjectCopyWith(MissionStatementObject value,
          $Res Function(MissionStatementObject) then) =
      _$MissionStatementObjectCopyWithImpl<$Res, MissionStatementObject>;
  @useResult
  $Res call({String missionStatement});
}

/// @nodoc
class _$MissionStatementObjectCopyWithImpl<$Res,
        $Val extends MissionStatementObject>
    implements $MissionStatementObjectCopyWith<$Res> {
  _$MissionStatementObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? missionStatement = null,
  }) {
    return _then(_value.copyWith(
      missionStatement: null == missionStatement
          ? _value.missionStatement
          : missionStatement // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MissionStatementObjectCopyWith<$Res>
    implements $MissionStatementObjectCopyWith<$Res> {
  factory _$$_MissionStatementObjectCopyWith(_$_MissionStatementObject value,
          $Res Function(_$_MissionStatementObject) then) =
      __$$_MissionStatementObjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String missionStatement});
}

/// @nodoc
class __$$_MissionStatementObjectCopyWithImpl<$Res>
    extends _$MissionStatementObjectCopyWithImpl<$Res,
        _$_MissionStatementObject>
    implements _$$_MissionStatementObjectCopyWith<$Res> {
  __$$_MissionStatementObjectCopyWithImpl(_$_MissionStatementObject _value,
      $Res Function(_$_MissionStatementObject) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? missionStatement = null,
  }) {
    return _then(_$_MissionStatementObject(
      null == missionStatement
          ? _value.missionStatement
          : missionStatement // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_MissionStatementObject implements _MissionStatementObject {
  _$_MissionStatementObject(this.missionStatement);

  @override
  final String missionStatement;

  @override
  String toString() {
    return 'MissionStatementObject(missionStatement: $missionStatement)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MissionStatementObject &&
            (identical(other.missionStatement, missionStatement) ||
                other.missionStatement == missionStatement));
  }

  @override
  int get hashCode => Object.hash(runtimeType, missionStatement);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MissionStatementObjectCopyWith<_$_MissionStatementObject> get copyWith =>
      __$$_MissionStatementObjectCopyWithImpl<_$_MissionStatementObject>(
          this, _$identity);
}

abstract class _MissionStatementObject implements MissionStatementObject {
  factory _MissionStatementObject(final String missionStatement) =
      _$_MissionStatementObject;

  @override
  String get missionStatement;
  @override
  @JsonKey(ignore: true)
  _$$_MissionStatementObjectCopyWith<_$_MissionStatementObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$VideoEditsObject {
  String get videoEdits => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $VideoEditsObjectCopyWith<VideoEditsObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VideoEditsObjectCopyWith<$Res> {
  factory $VideoEditsObjectCopyWith(
          VideoEditsObject value, $Res Function(VideoEditsObject) then) =
      _$VideoEditsObjectCopyWithImpl<$Res, VideoEditsObject>;
  @useResult
  $Res call({String videoEdits});
}

/// @nodoc
class _$VideoEditsObjectCopyWithImpl<$Res, $Val extends VideoEditsObject>
    implements $VideoEditsObjectCopyWith<$Res> {
  _$VideoEditsObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? videoEdits = null,
  }) {
    return _then(_value.copyWith(
      videoEdits: null == videoEdits
          ? _value.videoEdits
          : videoEdits // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_VideoEditsObjectCopyWith<$Res>
    implements $VideoEditsObjectCopyWith<$Res> {
  factory _$$_VideoEditsObjectCopyWith(
          _$_VideoEditsObject value, $Res Function(_$_VideoEditsObject) then) =
      __$$_VideoEditsObjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String videoEdits});
}

/// @nodoc
class __$$_VideoEditsObjectCopyWithImpl<$Res>
    extends _$VideoEditsObjectCopyWithImpl<$Res, _$_VideoEditsObject>
    implements _$$_VideoEditsObjectCopyWith<$Res> {
  __$$_VideoEditsObjectCopyWithImpl(
      _$_VideoEditsObject _value, $Res Function(_$_VideoEditsObject) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? videoEdits = null,
  }) {
    return _then(_$_VideoEditsObject(
      null == videoEdits
          ? _value.videoEdits
          : videoEdits // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_VideoEditsObject implements _VideoEditsObject {
  _$_VideoEditsObject(this.videoEdits);

  @override
  final String videoEdits;

  @override
  String toString() {
    return 'VideoEditsObject(videoEdits: $videoEdits)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_VideoEditsObject &&
            (identical(other.videoEdits, videoEdits) ||
                other.videoEdits == videoEdits));
  }

  @override
  int get hashCode => Object.hash(runtimeType, videoEdits);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_VideoEditsObjectCopyWith<_$_VideoEditsObject> get copyWith =>
      __$$_VideoEditsObjectCopyWithImpl<_$_VideoEditsObject>(this, _$identity);
}

abstract class _VideoEditsObject implements VideoEditsObject {
  factory _VideoEditsObject(final String videoEdits) = _$_VideoEditsObject;

  @override
  String get videoEdits;
  @override
  @JsonKey(ignore: true)
  _$$_VideoEditsObjectCopyWith<_$_VideoEditsObject> get copyWith =>
      throw _privateConstructorUsedError;
}
