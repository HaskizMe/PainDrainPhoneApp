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
  int get intensity =>
      throw _privateConstructorUsedError; // Ensure proper serialization & deserialization
  @JsonKey(fromJson: _channelsFromJson, toJson: _channelsToJson)
  List<Channel> get channels => throw _privateConstructorUsedError;
  int get currentChannel => throw _privateConstructorUsedError;
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
  $Res call(
      {int intensity,
      @JsonKey(fromJson: _channelsFromJson, toJson: _channelsToJson)
      List<Channel> channels,
      int currentChannel,
      int phase});
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
    Object? channels = null,
    Object? currentChannel = null,
    Object? phase = null,
  }) {
    return _then(_value.copyWith(
      intensity: null == intensity
          ? _value.intensity
          : intensity // ignore: cast_nullable_to_non_nullable
              as int,
      channels: null == channels
          ? _value.channels
          : channels // ignore: cast_nullable_to_non_nullable
              as List<Channel>,
      currentChannel: null == currentChannel
          ? _value.currentChannel
          : currentChannel // ignore: cast_nullable_to_non_nullable
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
  $Res call(
      {int intensity,
      @JsonKey(fromJson: _channelsFromJson, toJson: _channelsToJson)
      List<Channel> channels,
      int currentChannel,
      int phase});
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
    Object? channels = null,
    Object? currentChannel = null,
    Object? phase = null,
  }) {
    return _then(_$TensImpl(
      intensity: null == intensity
          ? _value.intensity
          : intensity // ignore: cast_nullable_to_non_nullable
              as int,
      channels: null == channels
          ? _value._channels
          : channels // ignore: cast_nullable_to_non_nullable
              as List<Channel>,
      currentChannel: null == currentChannel
          ? _value.currentChannel
          : currentChannel // ignore: cast_nullable_to_non_nullable
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
      @JsonKey(fromJson: _channelsFromJson, toJson: _channelsToJson)
      final List<Channel> channels = const [
        Channel(channelNumber: 1),
        Channel(channelNumber: 2)
      ],
      this.currentChannel = 1,
      this.phase = 0})
      : _channels = channels;

  factory _$TensImpl.fromJson(Map<String, dynamic> json) =>
      _$$TensImplFromJson(json);

  @override
  @JsonKey()
  final int intensity;
// Ensure proper serialization & deserialization
  final List<Channel> _channels;
// Ensure proper serialization & deserialization
  @override
  @JsonKey(fromJson: _channelsFromJson, toJson: _channelsToJson)
  List<Channel> get channels {
    if (_channels is EqualUnmodifiableListView) return _channels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_channels);
  }

  @override
  @JsonKey()
  final int currentChannel;
  @override
  @JsonKey()
  final int phase;

  @override
  String toString() {
    return 'Tens(intensity: $intensity, channels: $channels, currentChannel: $currentChannel, phase: $phase)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TensImpl &&
            (identical(other.intensity, intensity) ||
                other.intensity == intensity) &&
            const DeepCollectionEquality().equals(other._channels, _channels) &&
            (identical(other.currentChannel, currentChannel) ||
                other.currentChannel == currentChannel) &&
            (identical(other.phase, phase) || other.phase == phase));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, intensity,
      const DeepCollectionEquality().hash(_channels), currentChannel, phase);

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
      @JsonKey(fromJson: _channelsFromJson, toJson: _channelsToJson)
      final List<Channel> channels,
      final int currentChannel,
      final int phase}) = _$TensImpl;

  factory _Tens.fromJson(Map<String, dynamic> json) = _$TensImpl.fromJson;

  @override
  int get intensity; // Ensure proper serialization & deserialization
  @override
  @JsonKey(fromJson: _channelsFromJson, toJson: _channelsToJson)
  List<Channel> get channels;
  @override
  int get currentChannel;
  @override
  int get phase;

  /// Create a copy of Tens
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TensImplCopyWith<_$TensImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Channel _$ChannelFromJson(Map<String, dynamic> json) {
  return _Channel.fromJson(json);
}

/// @nodoc
mixin _$Channel {
  int get channelNumber => throw _privateConstructorUsedError;
  bool get isPlaying => throw _privateConstructorUsedError;
  int get mode => throw _privateConstructorUsedError;

  /// Serializes this Channel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Channel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChannelCopyWith<Channel> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChannelCopyWith<$Res> {
  factory $ChannelCopyWith(Channel value, $Res Function(Channel) then) =
      _$ChannelCopyWithImpl<$Res, Channel>;
  @useResult
  $Res call({int channelNumber, bool isPlaying, int mode});
}

/// @nodoc
class _$ChannelCopyWithImpl<$Res, $Val extends Channel>
    implements $ChannelCopyWith<$Res> {
  _$ChannelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Channel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? channelNumber = null,
    Object? isPlaying = null,
    Object? mode = null,
  }) {
    return _then(_value.copyWith(
      channelNumber: null == channelNumber
          ? _value.channelNumber
          : channelNumber // ignore: cast_nullable_to_non_nullable
              as int,
      isPlaying: null == isPlaying
          ? _value.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool,
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChannelImplCopyWith<$Res> implements $ChannelCopyWith<$Res> {
  factory _$$ChannelImplCopyWith(
          _$ChannelImpl value, $Res Function(_$ChannelImpl) then) =
      __$$ChannelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int channelNumber, bool isPlaying, int mode});
}

/// @nodoc
class __$$ChannelImplCopyWithImpl<$Res>
    extends _$ChannelCopyWithImpl<$Res, _$ChannelImpl>
    implements _$$ChannelImplCopyWith<$Res> {
  __$$ChannelImplCopyWithImpl(
      _$ChannelImpl _value, $Res Function(_$ChannelImpl) _then)
      : super(_value, _then);

  /// Create a copy of Channel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? channelNumber = null,
    Object? isPlaying = null,
    Object? mode = null,
  }) {
    return _then(_$ChannelImpl(
      channelNumber: null == channelNumber
          ? _value.channelNumber
          : channelNumber // ignore: cast_nullable_to_non_nullable
              as int,
      isPlaying: null == isPlaying
          ? _value.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool,
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChannelImpl implements _Channel {
  const _$ChannelImpl(
      {required this.channelNumber, this.isPlaying = false, this.mode = 1});

  factory _$ChannelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChannelImplFromJson(json);

  @override
  final int channelNumber;
  @override
  @JsonKey()
  final bool isPlaying;
  @override
  @JsonKey()
  final int mode;

  @override
  String toString() {
    return 'Channel(channelNumber: $channelNumber, isPlaying: $isPlaying, mode: $mode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChannelImpl &&
            (identical(other.channelNumber, channelNumber) ||
                other.channelNumber == channelNumber) &&
            (identical(other.isPlaying, isPlaying) ||
                other.isPlaying == isPlaying) &&
            (identical(other.mode, mode) || other.mode == mode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, channelNumber, isPlaying, mode);

  /// Create a copy of Channel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChannelImplCopyWith<_$ChannelImpl> get copyWith =>
      __$$ChannelImplCopyWithImpl<_$ChannelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChannelImplToJson(
      this,
    );
  }
}

abstract class _Channel implements Channel {
  const factory _Channel(
      {required final int channelNumber,
      final bool isPlaying,
      final int mode}) = _$ChannelImpl;

  factory _Channel.fromJson(Map<String, dynamic> json) = _$ChannelImpl.fromJson;

  @override
  int get channelNumber;
  @override
  bool get isPlaying;
  @override
  int get mode;

  /// Create a copy of Channel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChannelImplCopyWith<_$ChannelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
