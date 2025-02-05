// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tens.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Tens _$TensFromJson(Map<String, dynamic> json) {
  return _Tens.fromJson(json);
}

/// @nodoc
mixin _$Tens {
  int get intensity => throw _privateConstructorUsedError;
  int get mode => throw _privateConstructorUsedError;
  bool get isPlaying => throw _privateConstructorUsedError;
  int get channel => throw _privateConstructorUsedError;
  int get phase => throw _privateConstructorUsedError;

  /// Serializes this Tens to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Tens
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TensCopyWith<Tens> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TensCopyWith<$Res> {
  factory $TensCopyWith(Tens value, $Res Function(Tens) then) =
      _$TensCopyWithImpl<$Res, Tens>;
  @useResult
  $Res call({int intensity, int mode, bool isPlaying, int channel, int phase});
}

/// @nodoc
class _$TensCopyWithImpl<$Res, $Val extends Tens>
    implements $TensCopyWith<$Res> {
  _$TensCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Tens
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? intensity = null,
    Object? mode = null,
    Object? isPlaying = null,
    Object? channel = null,
    Object? phase = null,
  }) {
    return _then(_value.copyWith(
      intensity: null == intensity
          ? _value.intensity
          : intensity // ignore: cast_nullable_to_non_nullable
              as int,
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as int,
      isPlaying: null == isPlaying
          ? _value.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool,
      channel: null == channel
          ? _value.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as int,
      phase: null == phase
          ? _value.phase
          : phase // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TensImplCopyWith<$Res> implements $TensCopyWith<$Res> {
  factory _$$TensImplCopyWith(
          _$TensImpl value, $Res Function(_$TensImpl) then) =
      __$$TensImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int intensity, int mode, bool isPlaying, int channel, int phase});
}

/// @nodoc
class __$$TensImplCopyWithImpl<$Res>
    extends _$TensCopyWithImpl<$Res, _$TensImpl>
    implements _$$TensImplCopyWith<$Res> {
  __$$TensImplCopyWithImpl(_$TensImpl _value, $Res Function(_$TensImpl) _then)
      : super(_value, _then);

  /// Create a copy of Tens
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? intensity = null,
    Object? mode = null,
    Object? isPlaying = null,
    Object? channel = null,
    Object? phase = null,
  }) {
    return _then(_$TensImpl(
      intensity: null == intensity
          ? _value.intensity
          : intensity // ignore: cast_nullable_to_non_nullable
              as int,
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as int,
      isPlaying: null == isPlaying
          ? _value.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool,
      channel: null == channel
          ? _value.channel
          : channel // ignore: cast_nullable_to_non_nullable
              as int,
      phase: null == phase
          ? _value.phase
          : phase // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TensImpl implements _Tens {
  const _$TensImpl(
      {this.intensity = 0,
      this.mode = 1,
      this.isPlaying = false,
      this.channel = 1,
      this.phase = 0});

  factory _$TensImpl.fromJson(Map<String, dynamic> json) =>
      _$$TensImplFromJson(json);

  @override
  @JsonKey()
  final int intensity;
  @override
  @JsonKey()
  final int mode;
  @override
  @JsonKey()
  final bool isPlaying;
  @override
  @JsonKey()
  final int channel;
  @override
  @JsonKey()
  final int phase;

  @override
  String toString() {
    return 'Tens(intensity: $intensity, mode: $mode, isPlaying: $isPlaying, channel: $channel, phase: $phase)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TensImpl &&
            (identical(other.intensity, intensity) ||
                other.intensity == intensity) &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.isPlaying, isPlaying) ||
                other.isPlaying == isPlaying) &&
            (identical(other.channel, channel) || other.channel == channel) &&
            (identical(other.phase, phase) || other.phase == phase));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, intensity, mode, isPlaying, channel, phase);

  /// Create a copy of Tens
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TensImplCopyWith<_$TensImpl> get copyWith =>
      __$$TensImplCopyWithImpl<_$TensImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TensImplToJson(
      this,
    );
  }
}

abstract class _Tens implements Tens {
  const factory _Tens(
      {final int intensity,
      final int mode,
      final bool isPlaying,
      final int channel,
      final int phase}) = _$TensImpl;

  factory _Tens.fromJson(Map<String, dynamic> json) = _$TensImpl.fromJson;

  @override
  int get intensity;
  @override
  int get mode;
  @override
  bool get isPlaying;
  @override
  int get channel;
  @override
  int get phase;

  /// Create a copy of Tens
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TensImplCopyWith<_$TensImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
