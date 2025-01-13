// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stimulus_new.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$StimulusNew {
  int get tensIntensity => throw _privateConstructorUsedError;

  /// Create a copy of StimulusNew
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StimulusNewCopyWith<StimulusNew> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StimulusNewCopyWith<$Res> {
  factory $StimulusNewCopyWith(
          StimulusNew value, $Res Function(StimulusNew) then) =
      _$StimulusNewCopyWithImpl<$Res, StimulusNew>;
  @useResult
  $Res call({int tensIntensity});
}

/// @nodoc
class _$StimulusNewCopyWithImpl<$Res, $Val extends StimulusNew>
    implements $StimulusNewCopyWith<$Res> {
  _$StimulusNewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StimulusNew
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tensIntensity = null,
  }) {
    return _then(_value.copyWith(
      tensIntensity: null == tensIntensity
          ? _value.tensIntensity
          : tensIntensity // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StimulusNewImplCopyWith<$Res>
    implements $StimulusNewCopyWith<$Res> {
  factory _$$StimulusNewImplCopyWith(
          _$StimulusNewImpl value, $Res Function(_$StimulusNewImpl) then) =
      __$$StimulusNewImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int tensIntensity});
}

/// @nodoc
class __$$StimulusNewImplCopyWithImpl<$Res>
    extends _$StimulusNewCopyWithImpl<$Res, _$StimulusNewImpl>
    implements _$$StimulusNewImplCopyWith<$Res> {
  __$$StimulusNewImplCopyWithImpl(
      _$StimulusNewImpl _value, $Res Function(_$StimulusNewImpl) _then)
      : super(_value, _then);

  /// Create a copy of StimulusNew
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tensIntensity = null,
  }) {
    return _then(_$StimulusNewImpl(
      tensIntensity: null == tensIntensity
          ? _value.tensIntensity
          : tensIntensity // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$StimulusNewImpl implements _StimulusNew {
  const _$StimulusNewImpl({this.tensIntensity = 0});

  @override
  @JsonKey()
  final int tensIntensity;

  @override
  String toString() {
    return 'StimulusNew(tensIntensity: $tensIntensity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StimulusNewImpl &&
            (identical(other.tensIntensity, tensIntensity) ||
                other.tensIntensity == tensIntensity));
  }

  @override
  int get hashCode => Object.hash(runtimeType, tensIntensity);

  /// Create a copy of StimulusNew
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StimulusNewImplCopyWith<_$StimulusNewImpl> get copyWith =>
      __$$StimulusNewImplCopyWithImpl<_$StimulusNewImpl>(this, _$identity);
}

abstract class _StimulusNew implements StimulusNew {
  const factory _StimulusNew({final int tensIntensity}) = _$StimulusNewImpl;

  @override
  int get tensIntensity;

  /// Create a copy of StimulusNew
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StimulusNewImplCopyWith<_$StimulusNewImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
