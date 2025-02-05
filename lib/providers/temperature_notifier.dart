import 'package:pain_drain_mobile_app/models/temperature.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'temperature_notifier.g.dart';

@Riverpod(keepAlive: true)
class TemperatureNotifier extends _$TemperatureNotifier {

  @override
  Temperature build() {
    return const Temperature(); // Initial state
  }

  void updateTens({int? temp}) {
    state = state.copyWith(
        temperature: temp ?? state.temperature
    );
  }

}