// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'presets.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Presets _$PresetsFromJson(Map<String, dynamic> json) {
  return _Presets.fromJson(json);
}

/// @nodoc
mixin _$Presets {
  List<Preset> get presets => throw _privateConstructorUsedError;
  Preset? get selectedPreset => throw _privateConstructorUsedError;

  /// Serializes this Presets to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Presets
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PresetsCopyWith<Presets> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PresetsCopyWith<$Res> {
  factory $PresetsCopyWith(Presets value, $Res Function(Presets) then) =
      _$PresetsCopyWithImpl<$Res, Presets>;
  @useResult
  $Res call({List<Preset> presets, Preset? selectedPreset});

  $PresetCopyWith<$Res>? get selectedPreset;
}

/// @nodoc
class _$PresetsCopyWithImpl<$Res, $Val extends Presets>
    implements $PresetsCopyWith<$Res> {
  _$PresetsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Presets
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? presets = null,
    Object? selectedPreset = freezed,
  }) {
    return _then(_value.copyWith(
      presets: null == presets
          ? _value.presets
          : presets // ignore: cast_nullable_to_non_nullable
              as List<Preset>,
      selectedPreset: freezed == selectedPreset
          ? _value.selectedPreset
          : selectedPreset // ignore: cast_nullable_to_non_nullable
              as Preset?,
    ) as $Val);
  }

  /// Create a copy of Presets
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PresetCopyWith<$Res>? get selectedPreset {
    if (_value.selectedPreset == null) {
      return null;
    }

    return $PresetCopyWith<$Res>(_value.selectedPreset!, (value) {
      return _then(_value.copyWith(selectedPreset: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PresetsImplCopyWith<$Res> implements $PresetsCopyWith<$Res> {
  factory _$$PresetsImplCopyWith(
          _$PresetsImpl value, $Res Function(_$PresetsImpl) then) =
      __$$PresetsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Preset> presets, Preset? selectedPreset});

  @override
  $PresetCopyWith<$Res>? get selectedPreset;
}

/// @nodoc
class __$$PresetsImplCopyWithImpl<$Res>
    extends _$PresetsCopyWithImpl<$Res, _$PresetsImpl>
    implements _$$PresetsImplCopyWith<$Res> {
  __$$PresetsImplCopyWithImpl(
      _$PresetsImpl _value, $Res Function(_$PresetsImpl) _then)
      : super(_value, _then);

  /// Create a copy of Presets
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? presets = null,
    Object? selectedPreset = freezed,
  }) {
    return _then(_$PresetsImpl(
      presets: null == presets
          ? _value._presets
          : presets // ignore: cast_nullable_to_non_nullable
              as List<Preset>,
      selectedPreset: freezed == selectedPreset
          ? _value.selectedPreset
          : selectedPreset // ignore: cast_nullable_to_non_nullable
              as Preset?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PresetsImpl implements _Presets {
  const _$PresetsImpl(
      {required final List<Preset> presets, required this.selectedPreset})
      : _presets = presets;

  factory _$PresetsImpl.fromJson(Map<String, dynamic> json) =>
      _$$PresetsImplFromJson(json);

  final List<Preset> _presets;
  @override
  List<Preset> get presets {
    if (_presets is EqualUnmodifiableListView) return _presets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_presets);
  }

  @override
  final Preset? selectedPreset;

  @override
  String toString() {
    return 'Presets(presets: $presets, selectedPreset: $selectedPreset)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PresetsImpl &&
            const DeepCollectionEquality().equals(other._presets, _presets) &&
            (identical(other.selectedPreset, selectedPreset) ||
                other.selectedPreset == selectedPreset));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_presets), selectedPreset);

  /// Create a copy of Presets
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PresetsImplCopyWith<_$PresetsImpl> get copyWith =>
      __$$PresetsImplCopyWithImpl<_$PresetsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PresetsImplToJson(
      this,
    );
  }
}

abstract class _Presets implements Presets {
  const factory _Presets(
      {required final List<Preset> presets,
      required final Preset? selectedPreset}) = _$PresetsImpl;

  factory _Presets.fromJson(Map<String, dynamic> json) = _$PresetsImpl.fromJson;

  @override
  List<Preset> get presets;
  @override
  Preset? get selectedPreset;

  /// Create a copy of Presets
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PresetsImplCopyWith<_$PresetsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
