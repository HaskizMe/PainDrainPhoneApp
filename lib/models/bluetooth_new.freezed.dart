// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bluetooth_new.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BluetoothNew {
  Queue<List<int>>? get queue =>
      throw _privateConstructorUsedError; // Nullable queue
  String get customServiceUUID => throw _privateConstructorUsedError;
  String get customCharacteristicUUID => throw _privateConstructorUsedError;
  String get batteryServiceUUID => throw _privateConstructorUsedError;
  String get batteryCharacteristicUUID => throw _privateConstructorUsedError;
  String get characteristicConfigurationUUID =>
      throw _privateConstructorUsedError;
  List<BluetoothService> get services => throw _privateConstructorUsedError;
  bool get isCharging => throw _privateConstructorUsedError;
  bool get showChargingAnimation => throw _privateConstructorUsedError;
  BluetoothDescriptor? get customConfigurationDescriptor =>
      throw _privateConstructorUsedError;
  BluetoothService? get customService => throw _privateConstructorUsedError;
  BluetoothService? get batteryService => throw _privateConstructorUsedError;
  BluetoothCharacteristic? get customCharacteristic =>
      throw _privateConstructorUsedError;
  BluetoothCharacteristic? get batteryCharacteristic =>
      throw _privateConstructorUsedError;
  BluetoothDevice? get connectedDevice => throw _privateConstructorUsedError;

  /// Create a copy of BluetoothNew
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BluetoothNewCopyWith<BluetoothNew> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BluetoothNewCopyWith<$Res> {
  factory $BluetoothNewCopyWith(
          BluetoothNew value, $Res Function(BluetoothNew) then) =
      _$BluetoothNewCopyWithImpl<$Res, BluetoothNew>;
  @useResult
  $Res call(
      {Queue<List<int>>? queue,
      String customServiceUUID,
      String customCharacteristicUUID,
      String batteryServiceUUID,
      String batteryCharacteristicUUID,
      String characteristicConfigurationUUID,
      List<BluetoothService> services,
      bool isCharging,
      bool showChargingAnimation,
      BluetoothDescriptor? customConfigurationDescriptor,
      BluetoothService? customService,
      BluetoothService? batteryService,
      BluetoothCharacteristic? customCharacteristic,
      BluetoothCharacteristic? batteryCharacteristic,
      BluetoothDevice? connectedDevice});
}

/// @nodoc
class _$BluetoothNewCopyWithImpl<$Res, $Val extends BluetoothNew>
    implements $BluetoothNewCopyWith<$Res> {
  _$BluetoothNewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BluetoothNew
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? queue = freezed,
    Object? customServiceUUID = null,
    Object? customCharacteristicUUID = null,
    Object? batteryServiceUUID = null,
    Object? batteryCharacteristicUUID = null,
    Object? characteristicConfigurationUUID = null,
    Object? services = null,
    Object? isCharging = null,
    Object? showChargingAnimation = null,
    Object? customConfigurationDescriptor = freezed,
    Object? customService = freezed,
    Object? batteryService = freezed,
    Object? customCharacteristic = freezed,
    Object? batteryCharacteristic = freezed,
    Object? connectedDevice = freezed,
  }) {
    return _then(_value.copyWith(
      queue: freezed == queue
          ? _value.queue
          : queue // ignore: cast_nullable_to_non_nullable
              as Queue<List<int>>?,
      customServiceUUID: null == customServiceUUID
          ? _value.customServiceUUID
          : customServiceUUID // ignore: cast_nullable_to_non_nullable
              as String,
      customCharacteristicUUID: null == customCharacteristicUUID
          ? _value.customCharacteristicUUID
          : customCharacteristicUUID // ignore: cast_nullable_to_non_nullable
              as String,
      batteryServiceUUID: null == batteryServiceUUID
          ? _value.batteryServiceUUID
          : batteryServiceUUID // ignore: cast_nullable_to_non_nullable
              as String,
      batteryCharacteristicUUID: null == batteryCharacteristicUUID
          ? _value.batteryCharacteristicUUID
          : batteryCharacteristicUUID // ignore: cast_nullable_to_non_nullable
              as String,
      characteristicConfigurationUUID: null == characteristicConfigurationUUID
          ? _value.characteristicConfigurationUUID
          : characteristicConfigurationUUID // ignore: cast_nullable_to_non_nullable
              as String,
      services: null == services
          ? _value.services
          : services // ignore: cast_nullable_to_non_nullable
              as List<BluetoothService>,
      isCharging: null == isCharging
          ? _value.isCharging
          : isCharging // ignore: cast_nullable_to_non_nullable
              as bool,
      showChargingAnimation: null == showChargingAnimation
          ? _value.showChargingAnimation
          : showChargingAnimation // ignore: cast_nullable_to_non_nullable
              as bool,
      customConfigurationDescriptor: freezed == customConfigurationDescriptor
          ? _value.customConfigurationDescriptor
          : customConfigurationDescriptor // ignore: cast_nullable_to_non_nullable
              as BluetoothDescriptor?,
      customService: freezed == customService
          ? _value.customService
          : customService // ignore: cast_nullable_to_non_nullable
              as BluetoothService?,
      batteryService: freezed == batteryService
          ? _value.batteryService
          : batteryService // ignore: cast_nullable_to_non_nullable
              as BluetoothService?,
      customCharacteristic: freezed == customCharacteristic
          ? _value.customCharacteristic
          : customCharacteristic // ignore: cast_nullable_to_non_nullable
              as BluetoothCharacteristic?,
      batteryCharacteristic: freezed == batteryCharacteristic
          ? _value.batteryCharacteristic
          : batteryCharacteristic // ignore: cast_nullable_to_non_nullable
              as BluetoothCharacteristic?,
      connectedDevice: freezed == connectedDevice
          ? _value.connectedDevice
          : connectedDevice // ignore: cast_nullable_to_non_nullable
              as BluetoothDevice?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BluetoothNewImplCopyWith<$Res>
    implements $BluetoothNewCopyWith<$Res> {
  factory _$$BluetoothNewImplCopyWith(
          _$BluetoothNewImpl value, $Res Function(_$BluetoothNewImpl) then) =
      __$$BluetoothNewImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Queue<List<int>>? queue,
      String customServiceUUID,
      String customCharacteristicUUID,
      String batteryServiceUUID,
      String batteryCharacteristicUUID,
      String characteristicConfigurationUUID,
      List<BluetoothService> services,
      bool isCharging,
      bool showChargingAnimation,
      BluetoothDescriptor? customConfigurationDescriptor,
      BluetoothService? customService,
      BluetoothService? batteryService,
      BluetoothCharacteristic? customCharacteristic,
      BluetoothCharacteristic? batteryCharacteristic,
      BluetoothDevice? connectedDevice});
}

/// @nodoc
class __$$BluetoothNewImplCopyWithImpl<$Res>
    extends _$BluetoothNewCopyWithImpl<$Res, _$BluetoothNewImpl>
    implements _$$BluetoothNewImplCopyWith<$Res> {
  __$$BluetoothNewImplCopyWithImpl(
      _$BluetoothNewImpl _value, $Res Function(_$BluetoothNewImpl) _then)
      : super(_value, _then);

  /// Create a copy of BluetoothNew
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? queue = freezed,
    Object? customServiceUUID = null,
    Object? customCharacteristicUUID = null,
    Object? batteryServiceUUID = null,
    Object? batteryCharacteristicUUID = null,
    Object? characteristicConfigurationUUID = null,
    Object? services = null,
    Object? isCharging = null,
    Object? showChargingAnimation = null,
    Object? customConfigurationDescriptor = freezed,
    Object? customService = freezed,
    Object? batteryService = freezed,
    Object? customCharacteristic = freezed,
    Object? batteryCharacteristic = freezed,
    Object? connectedDevice = freezed,
  }) {
    return _then(_$BluetoothNewImpl(
      queue: freezed == queue
          ? _value.queue
          : queue // ignore: cast_nullable_to_non_nullable
              as Queue<List<int>>?,
      customServiceUUID: null == customServiceUUID
          ? _value.customServiceUUID
          : customServiceUUID // ignore: cast_nullable_to_non_nullable
              as String,
      customCharacteristicUUID: null == customCharacteristicUUID
          ? _value.customCharacteristicUUID
          : customCharacteristicUUID // ignore: cast_nullable_to_non_nullable
              as String,
      batteryServiceUUID: null == batteryServiceUUID
          ? _value.batteryServiceUUID
          : batteryServiceUUID // ignore: cast_nullable_to_non_nullable
              as String,
      batteryCharacteristicUUID: null == batteryCharacteristicUUID
          ? _value.batteryCharacteristicUUID
          : batteryCharacteristicUUID // ignore: cast_nullable_to_non_nullable
              as String,
      characteristicConfigurationUUID: null == characteristicConfigurationUUID
          ? _value.characteristicConfigurationUUID
          : characteristicConfigurationUUID // ignore: cast_nullable_to_non_nullable
              as String,
      services: null == services
          ? _value._services
          : services // ignore: cast_nullable_to_non_nullable
              as List<BluetoothService>,
      isCharging: null == isCharging
          ? _value.isCharging
          : isCharging // ignore: cast_nullable_to_non_nullable
              as bool,
      showChargingAnimation: null == showChargingAnimation
          ? _value.showChargingAnimation
          : showChargingAnimation // ignore: cast_nullable_to_non_nullable
              as bool,
      customConfigurationDescriptor: freezed == customConfigurationDescriptor
          ? _value.customConfigurationDescriptor
          : customConfigurationDescriptor // ignore: cast_nullable_to_non_nullable
              as BluetoothDescriptor?,
      customService: freezed == customService
          ? _value.customService
          : customService // ignore: cast_nullable_to_non_nullable
              as BluetoothService?,
      batteryService: freezed == batteryService
          ? _value.batteryService
          : batteryService // ignore: cast_nullable_to_non_nullable
              as BluetoothService?,
      customCharacteristic: freezed == customCharacteristic
          ? _value.customCharacteristic
          : customCharacteristic // ignore: cast_nullable_to_non_nullable
              as BluetoothCharacteristic?,
      batteryCharacteristic: freezed == batteryCharacteristic
          ? _value.batteryCharacteristic
          : batteryCharacteristic // ignore: cast_nullable_to_non_nullable
              as BluetoothCharacteristic?,
      connectedDevice: freezed == connectedDevice
          ? _value.connectedDevice
          : connectedDevice // ignore: cast_nullable_to_non_nullable
              as BluetoothDevice?,
    ));
  }
}

/// @nodoc

class _$BluetoothNewImpl implements _BluetoothNew {
  const _$BluetoothNewImpl(
      {this.queue,
      this.customServiceUUID = "3bf00c21-d291-4688-b8e9-5a379e3d9874",
      this.customCharacteristicUUID = "93c836a2-695a-42cc-95ac-1afa0eef6b0a",
      this.batteryServiceUUID = "180f",
      this.batteryCharacteristicUUID = "2a19",
      this.characteristicConfigurationUUID = "2902",
      final List<BluetoothService> services = const [],
      this.isCharging = false,
      this.showChargingAnimation = false,
      this.customConfigurationDescriptor,
      this.customService,
      this.batteryService,
      this.customCharacteristic,
      this.batteryCharacteristic,
      this.connectedDevice})
      : _services = services;

  @override
  final Queue<List<int>>? queue;
// Nullable queue
  @override
  @JsonKey()
  final String customServiceUUID;
  @override
  @JsonKey()
  final String customCharacteristicUUID;
  @override
  @JsonKey()
  final String batteryServiceUUID;
  @override
  @JsonKey()
  final String batteryCharacteristicUUID;
  @override
  @JsonKey()
  final String characteristicConfigurationUUID;
  final List<BluetoothService> _services;
  @override
  @JsonKey()
  List<BluetoothService> get services {
    if (_services is EqualUnmodifiableListView) return _services;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_services);
  }

  @override
  @JsonKey()
  final bool isCharging;
  @override
  @JsonKey()
  final bool showChargingAnimation;
  @override
  final BluetoothDescriptor? customConfigurationDescriptor;
  @override
  final BluetoothService? customService;
  @override
  final BluetoothService? batteryService;
  @override
  final BluetoothCharacteristic? customCharacteristic;
  @override
  final BluetoothCharacteristic? batteryCharacteristic;
  @override
  final BluetoothDevice? connectedDevice;

  @override
  String toString() {
    return 'BluetoothNew(queue: $queue, customServiceUUID: $customServiceUUID, customCharacteristicUUID: $customCharacteristicUUID, batteryServiceUUID: $batteryServiceUUID, batteryCharacteristicUUID: $batteryCharacteristicUUID, characteristicConfigurationUUID: $characteristicConfigurationUUID, services: $services, isCharging: $isCharging, showChargingAnimation: $showChargingAnimation, customConfigurationDescriptor: $customConfigurationDescriptor, customService: $customService, batteryService: $batteryService, customCharacteristic: $customCharacteristic, batteryCharacteristic: $batteryCharacteristic, connectedDevice: $connectedDevice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BluetoothNewImpl &&
            const DeepCollectionEquality().equals(other.queue, queue) &&
            (identical(other.customServiceUUID, customServiceUUID) ||
                other.customServiceUUID == customServiceUUID) &&
            (identical(other.customCharacteristicUUID, customCharacteristicUUID) ||
                other.customCharacteristicUUID == customCharacteristicUUID) &&
            (identical(other.batteryServiceUUID, batteryServiceUUID) ||
                other.batteryServiceUUID == batteryServiceUUID) &&
            (identical(other.batteryCharacteristicUUID,
                    batteryCharacteristicUUID) ||
                other.batteryCharacteristicUUID == batteryCharacteristicUUID) &&
            (identical(other.characteristicConfigurationUUID,
                    characteristicConfigurationUUID) ||
                other.characteristicConfigurationUUID ==
                    characteristicConfigurationUUID) &&
            const DeepCollectionEquality().equals(other._services, _services) &&
            (identical(other.isCharging, isCharging) ||
                other.isCharging == isCharging) &&
            (identical(other.showChargingAnimation, showChargingAnimation) ||
                other.showChargingAnimation == showChargingAnimation) &&
            (identical(other.customConfigurationDescriptor,
                    customConfigurationDescriptor) ||
                other.customConfigurationDescriptor ==
                    customConfigurationDescriptor) &&
            (identical(other.customService, customService) ||
                other.customService == customService) &&
            (identical(other.batteryService, batteryService) ||
                other.batteryService == batteryService) &&
            (identical(other.customCharacteristic, customCharacteristic) ||
                other.customCharacteristic == customCharacteristic) &&
            (identical(other.batteryCharacteristic, batteryCharacteristic) ||
                other.batteryCharacteristic == batteryCharacteristic) &&
            (identical(other.connectedDevice, connectedDevice) ||
                other.connectedDevice == connectedDevice));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(queue),
      customServiceUUID,
      customCharacteristicUUID,
      batteryServiceUUID,
      batteryCharacteristicUUID,
      characteristicConfigurationUUID,
      const DeepCollectionEquality().hash(_services),
      isCharging,
      showChargingAnimation,
      customConfigurationDescriptor,
      customService,
      batteryService,
      customCharacteristic,
      batteryCharacteristic,
      connectedDevice);

  /// Create a copy of BluetoothNew
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BluetoothNewImplCopyWith<_$BluetoothNewImpl> get copyWith =>
      __$$BluetoothNewImplCopyWithImpl<_$BluetoothNewImpl>(this, _$identity);
}

abstract class _BluetoothNew implements BluetoothNew {
  const factory _BluetoothNew(
      {final Queue<List<int>>? queue,
      final String customServiceUUID,
      final String customCharacteristicUUID,
      final String batteryServiceUUID,
      final String batteryCharacteristicUUID,
      final String characteristicConfigurationUUID,
      final List<BluetoothService> services,
      final bool isCharging,
      final bool showChargingAnimation,
      final BluetoothDescriptor? customConfigurationDescriptor,
      final BluetoothService? customService,
      final BluetoothService? batteryService,
      final BluetoothCharacteristic? customCharacteristic,
      final BluetoothCharacteristic? batteryCharacteristic,
      final BluetoothDevice? connectedDevice}) = _$BluetoothNewImpl;

  @override
  Queue<List<int>>? get queue; // Nullable queue
  @override
  String get customServiceUUID;
  @override
  String get customCharacteristicUUID;
  @override
  String get batteryServiceUUID;
  @override
  String get batteryCharacteristicUUID;
  @override
  String get characteristicConfigurationUUID;
  @override
  List<BluetoothService> get services;
  @override
  bool get isCharging;
  @override
  bool get showChargingAnimation;
  @override
  BluetoothDescriptor? get customConfigurationDescriptor;
  @override
  BluetoothService? get customService;
  @override
  BluetoothService? get batteryService;
  @override
  BluetoothCharacteristic? get customCharacteristic;
  @override
  BluetoothCharacteristic? get batteryCharacteristic;
  @override
  BluetoothDevice? get connectedDevice;

  /// Create a copy of BluetoothNew
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BluetoothNewImplCopyWith<_$BluetoothNewImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
