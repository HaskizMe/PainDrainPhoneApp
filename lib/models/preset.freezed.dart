// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'preset.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Preset _$PresetFromJson(Map<String, dynamic> json) {
  return _Preset.fromJson(json);
}

/// @nodoc
mixin _$Preset {
  int get id => throw _privateConstructorUsedError;
  Tens get tens => throw _privateConstructorUsedError;
  Vibration get vibration => throw _privateConstructorUsedError;
  Temperature get temperature => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Serializes this Preset to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Preset
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PresetCopyWith<Preset> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PresetCopyWith<$Res> {
  factory $PresetCopyWith(Preset value, $Res Function(Preset) then) =
      _$PresetCopyWithImpl<$Res, Preset>;
  @useResult
  $Res call(
      {int id,
      Tens tens,
      Vibration vibration,
      Temperature temperature,
      String name});

  $TensCopyWith<$Res> get tens;
  $VibrationCopyWith<$Res> get vibration;
  $TemperatureCopyWith<$Res> get temperature;
}

/// @nodoc
class _$PresetCopyWithImpl<$Res, $Val extends Preset>
    implements $PresetCopyWith<$Res> {
  _$PresetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Preset
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tens = null,
    Object? vibration = null,
    Object? temperature = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      tens: null == tens
          ? _value.tens
          : tens // ignore: cast_nullable_to_non_nullable
              as Tens,
      vibration: null == vibration
          ? _value.vibration
          : vibration // ignore: cast_nullable_to_non_nullable
              as Vibration,
      temperature: null == temperature
          ? _value.temperature
          : temperature // ignore: cast_nullable_to_non_nullable
              as Temperature,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  /// Create a copy of Preset
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TensCopyWith<$Res> get tens {
    return $TensCopyWith<$Res>(_value.tens, (value) {
      return _then(_value.copyWith(tens: value) as $Val);
    });
  }

  /// Create a copy of Preset
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $VibrationCopyWith<$Res> get vibration {
    return $VibrationCopyWith<$Res>(_value.vibration, (value) {
      return _then(_value.copyWith(vibration: value) as $Val);
    });
  }

  /// Create a copy of Preset
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TemperatureCopyWith<$Res> get temperature {
    return $TemperatureCopyWith<$Res>(_value.temperature, (value) {
      return _then(_value.copyWith(temperature: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PresetImplCopyWith<$Res> implements $PresetCopyWith<$Res> {
  factory _$$PresetImplCopyWith(
          _$PresetImpl value, $Res Function(_$PresetImpl) then) =
      __$$PresetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      Tens tens,
      Vibration vibration,
      Temperature temperature,
      String name});

  @override
  $TensCopyWith<$Res> get tens;
  @override
  $VibrationCopyWith<$Res> get vibration;
  @override
  $TemperatureCopyWith<$Res> get temperature;
}

/// @nodoc
class __$$PresetImplCopyWithImpl<$Res>
    extends _$PresetCopyWithImpl<$Res, _$PresetImpl>
    implements _$$PresetImplCopyWith<$Res> {
  __$$PresetImplCopyWithImpl(
      _$PresetImpl _value, $Res Function(_$PresetImpl) _then)
      : super(_value, _then);

  /// Create a copy of Preset
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tens = null,
    Object? vibration = null,
    Object? temperature = null,
    Object? name = null,
  }) {
    return _then(_$PresetImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      tens: null == tens
          ? _value.tens
          : tens // ignore: cast_nullable_to_non_nullable
              as Tens,
      vibration: null == vibration
          ? _value.vibration
          : vibration // ignore: cast_nullable_to_non_nullable
              as Vibration,
      temperature: null == temperature
          ? _value.temperature
          : temperature // ignore: cast_nullable_to_non_nullable
              as Temperature,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PresetImpl with DiagnosticableTreeMixin implements _Preset {
  const _$PresetImpl(
      {required this.id,
      required this.tens,
      required this.vibration,
      required this.temperature,
      required this.name});

  factory _$PresetImpl.fromJson(Map<String, dynamic> json) =>
      _$$PresetImplFromJson(json);

  @override
  final int id;
  @override
  final Tens tens;
  @override
  final Vibration vibration;
  @override
  final Temperature temperature;
  @override
  final String name;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Preset(id: $id, tens: $tens, vibration: $vibration, temperature: $temperature, name: $name)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Preset'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('tens', tens))
      ..add(DiagnosticsProperty('vibration', vibration))
      ..add(DiagnosticsProperty('temperature', temperature))
      ..add(DiagnosticsProperty('name', name));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PresetImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.tens, tens) || other.tens == tens) &&
            (identical(other.vibration, vibration) ||
                other.vibration == vibration) &&
            (identical(other.temperature, temperature) ||
                other.temperature == temperature) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, tens, vibration, temperature, name);

  /// Create a copy of Preset
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PresetImplCopyWith<_$PresetImpl> get copyWith =>
      __$$PresetImplCopyWithImpl<_$PresetImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PresetImplToJson(
      this,
    );
  }
}

abstract class _Preset implements Preset {
  const factory _Preset(
      {required final int id,
      required final Tens tens,
      required final Vibration vibration,
      required final Temperature temperature,
      required final String name}) = _$PresetImpl;

  factory _Preset.fromJson(Map<String, dynamic> json) = _$PresetImpl.fromJson;

  @override
  int get id;
  @override
  Tens get tens;
  @override
  Vibration get vibration;
  @override
  Temperature get temperature;
  @override
  String get name;

  /// Create a copy of Preset
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PresetImplCopyWith<_$PresetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
