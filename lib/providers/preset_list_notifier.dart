// preset_list_notifier.dart
import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/preset.dart';

part 'preset_list_notifier.g.dart';

@Riverpod(keepAlive: true)
class PresetListNotifier extends _$PresetListNotifier {
  static const String _presetsKey = 'presets_key';

  @override
  List<Preset> build() {
    // Optionally load the presets from SharedPreferences on initialization.
    _loadPresets();
    return <Preset>[];
  }

  Future<void> _loadPresets() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_presetsKey);
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      state = jsonList.map((json) => Preset.fromJson(json)).toList();
    }
  }

  Future<void> _savePresets() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = state.map((preset) => preset.toJson()).toList();
    await prefs.setString(_presetsKey, json.encode(jsonList));
  }

  /// Adds a new preset to the list and saves to SharedPreferences.
  void addPreset(Preset preset) {
    state = [...state, preset];
    _savePresets();
  }

  /// Updates a preset with a matching id.
  void updatePreset(int id, Preset updatedPreset) {
    state = state.map((preset) => preset.id == id ? updatedPreset : preset).toList();
    _savePresets();
  }

  /// Removes a preset with a matching id.
  void removePreset(int id) {
    state = state.where((preset) => preset.id != id).toList();
    _savePresets();
  }
}
