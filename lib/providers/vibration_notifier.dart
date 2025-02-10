import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/preset.dart';
import '../models/vibration.dart';

part 'vibration_notifier.g.dart';

@Riverpod(keepAlive: true)
class VibrationNotifier extends _$VibrationNotifier {

  @override
  Vibration build() {
    return const Vibration(); // Initial state
  }

  void updateVibration({int? freq}) {
    state = state.copyWith(
      frequency: freq ?? state.frequency
    );
  }

  /// Completely replaces the `Tens` state from a preset.
  void updateFromPreset(Preset preset) {
    state = Vibration.fromJson(preset.vibration.toJson());
  }

  void disableVibe(){
    state = const Vibration();
  }


}