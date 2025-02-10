import 'dart:convert';
import 'package:pain_drain_mobile_app/models/presets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/preset.dart';

part 'preset_list_notifier.g.dart';

@Riverpod(keepAlive: true)
class PresetListNotifier extends _$PresetListNotifier {
  static const String _presetsKey = 'presets_key';

  @override
  Presets build() {
    // Optionally load the presets from SharedPreferences on initialization.
    _loadPresets();
    return const Presets(presets: [], selectedPreset: null);
  }

  Future<void> _loadPresets() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_presetsKey);
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      print(jsonList);
      state = state.copyWith(presets: jsonList.map((json) => Preset.fromJson(json)).toList());
    }
  }

  Future<void> _savePresets() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = state.presets.map((preset) => preset.toJson()).toList();
    await prefs.setString(_presetsKey, json.encode(jsonList));
  }

  void updateCurrentPreset({Preset? preset}) {
    state = state.copyWith(selectedPreset: preset);
  }

  /// Saves a preset.
  /// If a preset with the same id already exists, it is updated.
  /// Otherwise, the new preset is added.
  /// Ensures presets remain sorted by `id`.
  void savePreset(Preset preset) {
    final presets = List<Preset>.from(state.presets); // Create a mutable copy

    // Find the index of the existing preset
    final index = presets.indexWhere((p) => p.id == preset.id);
    if (index != -1) {
      // Update existing preset at the correct index
      presets[index] = preset;
    } else {
      // Add the new preset
      presets.add(preset);
    }

    // Sort the presets list by id
    presets.sort((a, b) => a.id.compareTo(b.id));

    // Update state with sorted list
    state = state.copyWith(presets: presets, selectedPreset: preset);
    _savePresets();
  }



  /// Removes a preset with a matching id.
  void removePreset(int id) {
    final presets = List<Preset>.from(state.presets);
    final index = presets.indexWhere((p) => p.id == id);

    if (index == -1) return; // Exit if the preset is not found

    // Remove the preset
    presets.removeAt(index);

    // Determine the next selected preset index in a circular manner
    Preset? newSelectedPreset;
    if (presets.isNotEmpty) {
      final nextIndex = index % presets.length; // Circular selection
      newSelectedPreset = presets[nextIndex];
    }

    // Update state with new list and selected preset
    state = state.copyWith(presets: presets, selectedPreset: newSelectedPreset);
    _savePresets();
  }

}

