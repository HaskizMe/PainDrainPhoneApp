import 'package:pain_drain_mobile_app/providers/preset_list_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/preset.dart';

part 'current_preset_notifier.g.dart';

@Riverpod(keepAlive: true)
class CurrentPresetNotifier extends _$CurrentPresetNotifier {

  @override
  Preset? build() {
    return null; // Initial state
  }

  void updateCurrentPreset({String? presetKey}) {
    if(presetKey == null) return;
    final presets = ref.read(presetListNotifierProvider);

    // Find the preset whose name matches the presetKey.
    try {
      final currentPreset = presets.firstWhere((preset) => preset.name == presetKey);
      state = currentPreset;
    } catch (e) {
      // Handle the case when no matching preset is found.
      print('Preset with key $presetKey not found.');
    }
  }

}