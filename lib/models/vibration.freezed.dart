// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vibration.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Vibration _$VibrationFromJson(Map<String, dynamic> json) {
  return _Vibration.fromJson(json);
}

/// @nodoc
mixin _$Vibration {
  int get frequency => throw _privateConstructorUsedError;

  /// Serializes this Vibration to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Vibration
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VibrationCopyWith<Vibration> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VibrationCopyWith<$Res> {
  factory $VibrationCopyWith(Vibration value, $Res Function(Vibration) then) =
      _$VibrationCopyWithImpl<$Res, Vibration>;
  @useResult
  $Res call({int frequency});
}

/// @nodoc
class _$VibrationCopyWithImpl<$Res, $Val extends Vibration>
    implements $VibrationCopyWith<$Res> {
  _$VibrationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Vibration
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? frequency = null,
  }) {
    return _then(_value.copyWith(
      frequency: null == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VibrationImplCopyWith<$Res>
    implements $VibrationCopyWith<$Res> {
  factory _$$VibrationImplCopyWith(
          _$VibrationImpl value, $Res Function(_$VibrationImpl) then) =
      __$$VibrationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int frequency});
}

/// @nodoc
class __$$VibrationImplCopyWithImpl<$Res>
    extends _$VibrationCopyWithImpl<$Res, _$VibrationImpl>
    implements _$$VibrationImplCopyWith<$Res> {
  __$$VibrationImplCopyWithImpl(
      _$VibrationImpl _value, $Res Function(_$VibrationImpl) _then)
      : super(_value, _then);

  /// Create a copy of Vibration
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? frequency = null,
  }) {
    return _then(_$VibrationImpl(
      frequency: null == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VibrationImpl implements _Vibration {
  const _$VibrationImpl({this.frequency = 0});

  factory _$VibrationImpl.fromJson(Map<String, dynamic> json) =>
      _$$VibrationImplFromJson(json);

  @override
  @JsonKey()
  final int frequency;

  @override
  String toString() {
    return 'Vibration(frequency: $frequency)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VibrationImpl &&
            (identical(other.frequency, frequency) ||
                other.frequency == frequency));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, frequency);

  /// Create a copy of Vibration
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VibrationImplCopyWith<_$VibrationImpl> get copyWith =>
      __$$VibrationImplCopyWithImpl<_$VibrationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VibrationImplToJson(
      this,
    );
  }
}

abstract class _Vibration implements Vibration {
  const factory _Vibration({final int frequency}) = _$VibrationImpl;

  factory _Vibration.fromJson(Map<String, dynamic> json) =
      _$VibrationImpl.fromJson;

  @override
  int get frequency;

  /// Create a copy of Vibration
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VibrationImplCopyWith<_$VibrationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
