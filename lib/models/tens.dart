import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tens.freezed.dart';
part 'tens.g.dart';

@freezed
class Tens with _$Tens {
  const factory Tens({
    @Default(0) int intensity,

    // Ensure proper serialization & deserialization
    @JsonKey(fromJson: _channelsFromJson, toJson: _channelsToJson)
    @Default([Channel(channelNumber: 1), Channel(channelNumber: 2)])
    List<Channel> channels,

    @Default(1) int currentChannel,
    @Default(0) int phase,
  }) = _Tens;

  factory Tens.fromJson(Map<String, dynamic> json) => _$TensFromJson(json);
}

// Custom functions for JSON serialization/deserialization of `channels`
List<Channel> _channelsFromJson(dynamic json) {
  if (json is List) {
    return json.map((e) => Channel.fromJson(e as Map<String, dynamic>)).toList();
  }
  return [const Channel(channelNumber: 1), const Channel(channelNumber: 2)]; // Default in case of an issue
}

List<Map<String, dynamic>> _channelsToJson(List<Channel> channels) {
  return channels.map((e) => e.toJson()).toList();
}



@freezed
class Channel with _$Channel {
  const factory Channel({
    required int channelNumber,
    @Default(false) bool isPlaying,
    @Default(1) int mode
  }) = _Channel;

  factory Channel.fromJson(Map<String, dynamic> json) => _$ChannelFromJson(json);
}