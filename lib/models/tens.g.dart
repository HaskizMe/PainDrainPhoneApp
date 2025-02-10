// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tens.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TensImpl _$$TensImplFromJson(Map<String, dynamic> json) => _$TensImpl(
      intensity: (json['intensity'] as num?)?.toInt() ?? 0,
      channels: json['channels'] == null
          ? const [Channel(channelNumber: 1), Channel(channelNumber: 2)]
          : _channelsFromJson(json['channels']),
      currentChannel: (json['currentChannel'] as num?)?.toInt() ?? 1,
      phase: (json['phase'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$TensImplToJson(_$TensImpl instance) =>
    <String, dynamic>{
      'intensity': instance.intensity,
      'channels': _channelsToJson(instance.channels),
      'currentChannel': instance.currentChannel,
      'phase': instance.phase,
    };

_$ChannelImpl _$$ChannelImplFromJson(Map<String, dynamic> json) =>
    _$ChannelImpl(
      channelNumber: (json['channelNumber'] as num).toInt(),
      isPlaying: json['isPlaying'] as bool? ?? false,
      mode: (json['mode'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$$ChannelImplToJson(_$ChannelImpl instance) =>
    <String, dynamic>{
      'channelNumber': instance.channelNumber,
      'isPlaying': instance.isPlaying,
      'mode': instance.mode,
    };
