import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/vibration.dart';

part 'vibration_notifier.g.dart';

@Riverpod(keepAlive: true)
class VibrationNotifier extends _$VibrationNotifier {

  @override
  Vibration build() {
    return const Vibration(); // Initial state
  }

  void updateTens({int? freq}) {
    state = state.copyWith(
      frequency: freq ?? state.frequency
    );
  }


}