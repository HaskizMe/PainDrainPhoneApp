import 'package:pain_drain_mobile_app/models/temperature.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/preset.dart';

part 'temperature_notifier.g.dart';

@Riverpod(keepAlive: true)
class TemperatureNotifier extends _$TemperatureNotifier {

  @override
  Temperature build() {
    return const Temperature(); // Initial state
  }

  void updateTemperature({int? temp}) {
    state = state.copyWith(
        temperature: temp ?? state.temperature
    );
  }

  /// Completely replaces the `Tens` state from a preset.
  void updateFromPreset(Preset preset) {
    state = Temperature.fromJson(preset.temperature.toJson());
  }

  void disableTemp(){
    state = const Temperature();
  }

}