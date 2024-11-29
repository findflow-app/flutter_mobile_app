// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'beacon_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Beacon {
  String get name => throw _privateConstructorUsedError;
  String get data_type => throw _privateConstructorUsedError;
  String get data => throw _privateConstructorUsedError;

  /// Create a copy of Beacon
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BeaconCopyWith<Beacon> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BeaconCopyWith<$Res> {
  factory $BeaconCopyWith(Beacon value, $Res Function(Beacon) then) =
      _$BeaconCopyWithImpl<$Res, Beacon>;
  @useResult
  $Res call({String name, String data_type, String data});
}

/// @nodoc
class _$BeaconCopyWithImpl<$Res, $Val extends Beacon>
    implements $BeaconCopyWith<$Res> {
  _$BeaconCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Beacon
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? data_type = null,
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      data_type: null == data_type
          ? _value.data_type
          : data_type // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BeaconImplCopyWith<$Res> implements $BeaconCopyWith<$Res> {
  factory _$$BeaconImplCopyWith(
          _$BeaconImpl value, $Res Function(_$BeaconImpl) then) =
      __$$BeaconImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String data_type, String data});
}

/// @nodoc
class __$$BeaconImplCopyWithImpl<$Res>
    extends _$BeaconCopyWithImpl<$Res, _$BeaconImpl>
    implements _$$BeaconImplCopyWith<$Res> {
  __$$BeaconImplCopyWithImpl(
      _$BeaconImpl _value, $Res Function(_$BeaconImpl) _then)
      : super(_value, _then);

  /// Create a copy of Beacon
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? data_type = null,
    Object? data = null,
  }) {
    return _then(_$BeaconImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      data_type: null == data_type
          ? _value.data_type
          : data_type // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$BeaconImpl implements _Beacon {
  const _$BeaconImpl(
      {required this.name, required this.data_type, required this.data});

  @override
  final String name;
  @override
  final String data_type;
  @override
  final String data;

  @override
  String toString() {
    return 'Beacon(name: $name, data_type: $data_type, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BeaconImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.data_type, data_type) ||
                other.data_type == data_type) &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, data_type, data);

  /// Create a copy of Beacon
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BeaconImplCopyWith<_$BeaconImpl> get copyWith =>
      __$$BeaconImplCopyWithImpl<_$BeaconImpl>(this, _$identity);
}

abstract class _Beacon implements Beacon {
  const factory _Beacon(
      {required final String name,
      required final String data_type,
      required final String data}) = _$BeaconImpl;

  @override
  String get name;
  @override
  String get data_type;
  @override
  String get data;

  /// Create a copy of Beacon
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BeaconImplCopyWith<_$BeaconImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
