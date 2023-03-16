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
mixin _$TextObject {
  String get text => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TextObjectCopyWith<TextObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TextObjectCopyWith<$Res> {
  factory $TextObjectCopyWith(
          TextObject value, $Res Function(TextObject) then) =
      _$TextObjectCopyWithImpl<$Res, TextObject>;
  @useResult
  $Res call({String text});
}

/// @nodoc
class _$TextObjectCopyWithImpl<$Res, $Val extends TextObject>
    implements $TextObjectCopyWith<$Res> {
  _$TextObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
  }) {
    return _then(_value.copyWith(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TextObjectCopyWith<$Res>
    implements $TextObjectCopyWith<$Res> {
  factory _$$_TextObjectCopyWith(
          _$_TextObject value, $Res Function(_$_TextObject) then) =
      __$$_TextObjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String text});
}

/// @nodoc
class __$$_TextObjectCopyWithImpl<$Res>
    extends _$TextObjectCopyWithImpl<$Res, _$_TextObject>
    implements _$$_TextObjectCopyWith<$Res> {
  __$$_TextObjectCopyWithImpl(
      _$_TextObject _value, $Res Function(_$_TextObject) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
  }) {
    return _then(_$_TextObject(
      null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_TextObject implements _TextObject {
  _$_TextObject(this.text);

  @override
  final String text;

  @override
  String toString() {
    return 'TextObject(text: $text)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TextObject &&
            (identical(other.text, text) || other.text == text));
  }

  @override
  int get hashCode => Object.hash(runtimeType, text);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TextObjectCopyWith<_$_TextObject> get copyWith =>
      __$$_TextObjectCopyWithImpl<_$_TextObject>(this, _$identity);
}

abstract class _TextObject implements TextObject {
  factory _TextObject(final String text) = _$_TextObject;

  @override
  String get text;
  @override
  @JsonKey(ignore: true)
  _$$_TextObjectCopyWith<_$_TextObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$BrandPersonalityObject {
  String get brandCharacteristic => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BrandPersonalityObjectCopyWith<BrandPersonalityObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BrandPersonalityObjectCopyWith<$Res> {
  factory $BrandPersonalityObjectCopyWith(BrandPersonalityObject value,
          $Res Function(BrandPersonalityObject) then) =
      _$BrandPersonalityObjectCopyWithImpl<$Res, BrandPersonalityObject>;
  @useResult
  $Res call({String brandCharacteristic});
}

/// @nodoc
class _$BrandPersonalityObjectCopyWithImpl<$Res,
        $Val extends BrandPersonalityObject>
    implements $BrandPersonalityObjectCopyWith<$Res> {
  _$BrandPersonalityObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? brandCharacteristic = null,
  }) {
    return _then(_value.copyWith(
      brandCharacteristic: null == brandCharacteristic
          ? _value.brandCharacteristic
          : brandCharacteristic // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_BrandPersonalityObjectCopyWith<$Res>
    implements $BrandPersonalityObjectCopyWith<$Res> {
  factory _$$_BrandPersonalityObjectCopyWith(_$_BrandPersonalityObject value,
          $Res Function(_$_BrandPersonalityObject) then) =
      __$$_BrandPersonalityObjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String brandCharacteristic});
}

/// @nodoc
class __$$_BrandPersonalityObjectCopyWithImpl<$Res>
    extends _$BrandPersonalityObjectCopyWithImpl<$Res,
        _$_BrandPersonalityObject>
    implements _$$_BrandPersonalityObjectCopyWith<$Res> {
  __$$_BrandPersonalityObjectCopyWithImpl(_$_BrandPersonalityObject _value,
      $Res Function(_$_BrandPersonalityObject) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? brandCharacteristic = null,
  }) {
    return _then(_$_BrandPersonalityObject(
      null == brandCharacteristic
          ? _value.brandCharacteristic
          : brandCharacteristic // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_BrandPersonalityObject implements _BrandPersonalityObject {
  _$_BrandPersonalityObject(this.brandCharacteristic);

  @override
  final String brandCharacteristic;

  @override
  String toString() {
    return 'BrandPersonalityObject(brandCharacteristic: $brandCharacteristic)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BrandPersonalityObject &&
            (identical(other.brandCharacteristic, brandCharacteristic) ||
                other.brandCharacteristic == brandCharacteristic));
  }

  @override
  int get hashCode => Object.hash(runtimeType, brandCharacteristic);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BrandPersonalityObjectCopyWith<_$_BrandPersonalityObject> get copyWith =>
      __$$_BrandPersonalityObjectCopyWithImpl<_$_BrandPersonalityObject>(
          this, _$identity);
}

abstract class _BrandPersonalityObject implements BrandPersonalityObject {
  factory _BrandPersonalityObject(final String brandCharacteristic) =
      _$_BrandPersonalityObject;

  @override
  String get brandCharacteristic;
  @override
  @JsonKey(ignore: true)
  _$$_BrandPersonalityObjectCopyWith<_$_BrandPersonalityObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CompanyIndustryTypeObject {
  String get industryType => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CompanyIndustryTypeObjectCopyWith<CompanyIndustryTypeObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompanyIndustryTypeObjectCopyWith<$Res> {
  factory $CompanyIndustryTypeObjectCopyWith(CompanyIndustryTypeObject value,
          $Res Function(CompanyIndustryTypeObject) then) =
      _$CompanyIndustryTypeObjectCopyWithImpl<$Res, CompanyIndustryTypeObject>;
  @useResult
  $Res call({String industryType});
}

/// @nodoc
class _$CompanyIndustryTypeObjectCopyWithImpl<$Res,
        $Val extends CompanyIndustryTypeObject>
    implements $CompanyIndustryTypeObjectCopyWith<$Res> {
  _$CompanyIndustryTypeObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? industryType = null,
  }) {
    return _then(_value.copyWith(
      industryType: null == industryType
          ? _value.industryType
          : industryType // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CompanyIndustryTypeObjectCopyWith<$Res>
    implements $CompanyIndustryTypeObjectCopyWith<$Res> {
  factory _$$_CompanyIndustryTypeObjectCopyWith(
          _$_CompanyIndustryTypeObject value,
          $Res Function(_$_CompanyIndustryTypeObject) then) =
      __$$_CompanyIndustryTypeObjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String industryType});
}

/// @nodoc
class __$$_CompanyIndustryTypeObjectCopyWithImpl<$Res>
    extends _$CompanyIndustryTypeObjectCopyWithImpl<$Res,
        _$_CompanyIndustryTypeObject>
    implements _$$_CompanyIndustryTypeObjectCopyWith<$Res> {
  __$$_CompanyIndustryTypeObjectCopyWithImpl(
      _$_CompanyIndustryTypeObject _value,
      $Res Function(_$_CompanyIndustryTypeObject) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? industryType = null,
  }) {
    return _then(_$_CompanyIndustryTypeObject(
      null == industryType
          ? _value.industryType
          : industryType // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_CompanyIndustryTypeObject implements _CompanyIndustryTypeObject {
  _$_CompanyIndustryTypeObject(this.industryType);

  @override
  final String industryType;

  @override
  String toString() {
    return 'CompanyIndustryTypeObject(industryType: $industryType)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CompanyIndustryTypeObject &&
            (identical(other.industryType, industryType) ||
                other.industryType == industryType));
  }

  @override
  int get hashCode => Object.hash(runtimeType, industryType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CompanyIndustryTypeObjectCopyWith<_$_CompanyIndustryTypeObject>
      get copyWith => __$$_CompanyIndustryTypeObjectCopyWithImpl<
          _$_CompanyIndustryTypeObject>(this, _$identity);
}

abstract class _CompanyIndustryTypeObject implements CompanyIndustryTypeObject {
  factory _CompanyIndustryTypeObject(final String industryType) =
      _$_CompanyIndustryTypeObject;

  @override
  String get industryType;
  @override
  @JsonKey(ignore: true)
  _$$_CompanyIndustryTypeObjectCopyWith<_$_CompanyIndustryTypeObject>
      get copyWith => throw _privateConstructorUsedError;
}
