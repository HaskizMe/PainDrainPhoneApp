import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/tens.dart';

part 'tens_notifier.g.dart';

@Riverpod(keepAlive: true)
class TensNotifier extends _$TensNotifier {

  @override
  Tens build() {
    return const Tens(); // Initial state
  }

  void updateTens({
    int? intensity,
    int? mode,
    bool? isPlaying,
    int? channel,
    int? phase,
  }) {
    state = state.copyWith(
      intensity: intensity ?? state.intensity,
      mode: mode ?? state.mode,
      isPlaying: isPlaying ?? state.isPlaying,
      channel: channel ?? state.channel,
      phase: phase ?? state.phase,
    );
  }
}