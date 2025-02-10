import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/preset.dart';
import '../models/tens.dart';

part 'tens_notifier.g.dart';

// @freezed
// class Tens with _$Tens {
//   const factory Tens({
//     @Default(0) int intensity,
//     @Default([Channel(channelNumber: 1), Channel(channelNumber: 2)])
//     @Default(1) int currentChannel,
//     @Default(0) int phase,
//   }) = _Tens;
//
//   factory Tens.fromJson(Map<String, dynamic> json) => _$TensFromJson(json);
// }
//
// @freezed
// class Channel with _$Channel {
//   const factory Channel({
//     required int channelNumber,
//     @Default(false) bool isPlaying,
//   }) = _Channel;
//
//   factory Channel.fromJson(Map<String, dynamic> json) => _$ChannelFromJson(json);
// }

@Riverpod(keepAlive: true)
class TensNotifier extends _$TensNotifier {

  @override
  Tens build() {
    return const Tens(); // Initial state
  }

  // void updateTens({
  //   int? intensity,
  //   int? mode,
  //   bool? isPlaying,
  //   int? channel,
  //   int? phase,
  // }) {
  //   state = state.copyWith(
  //     intensity: intensity ?? state.intensity,
  //     mode: mode ?? state.mode,
  //     isPlaying: isPlaying ?? state.isPlaying,
  //     channel: channel ?? state.channel,
  //     phase: phase ?? state.phase,
  //   );
  // }

  void updateTens({
    int? intensity,
    int? phase,
    int? channelNumber, // Specify which channel to update
    bool? isPlaying,
    int? mode,
  }) {
    state = state.copyWith(
      intensity: intensity ?? state.intensity,
      currentChannel: channelNumber ?? state.currentChannel,
      phase: phase ?? state.phase,
      channels: state.channels.map((channel) {
        if (channel.channelNumber == channelNumber) {
          // Update only the specified channel
          return channel.copyWith(
            isPlaying: isPlaying ?? channel.isPlaying,
            mode: mode ?? channel.mode,
          );
        }
        return channel; // Keep other channels unchanged
      }).toList(),
    );
  }




  /// Completely replaces the `Tens` state from a preset.
  void updateFromPreset(Preset preset) {
    state = Tens.fromJson(preset.tens.toJson());
  }

  void disableTens() {
    state = const Tens(); // Resets to initial values
  }

}