import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/preset.dart';

part 'current_preset_notifier.g.dart';

@Riverpod(keepAlive: true)
class CurrentPreset extends _$CurrentPreset {

  @override
  Preset? build() {
    return null; // Initial state
  }

  void updateCurrentPreset({required Preset currentPreset}) {
    state = currentPreset;
  }
}