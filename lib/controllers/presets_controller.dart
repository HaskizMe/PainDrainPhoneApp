import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class SavedPresets{
  // Attributes
  late final SharedPreferences _prefs;
  List<String>? _presets;
  String? _currentPreset;

  // Constructor
  SavedPresets() {
    _initialize();
  }

  // Methods
  Future<void> _initialize() async {
    // Initialize shared preferences
    _prefs = await SharedPreferences.getInstance();
    //deleteAllPresets();
    // Store dummy data everytime in shared prefs
    await _prefs.setStringList('presets', [
      'preset 1', 'preset 2', 'preset 3', 'preset 4', 'preset 5', 'preset 6', 'preset 7'
    ]);
    if(getPresets() != null){
      print(getPresets());
      _presets = getPresets();
      if(_presets!.isNotEmpty && _presets!.isNotEmpty){
        _currentPreset = _presets!.first;
      }
      print(getKeys());
    }
  }

  List<String>? getPresets() {
    final List<String>? presets = _prefs.getStringList('presets');
    return presets;
  }
  Set<String> getKeys() {
    final Set<String> allKeys = _prefs.getKeys();
    return allKeys;
  }

  String? getCurrentPreset() {
    return _currentPreset;
  }

  void setCurrentPreset(String? newPreset){
    _currentPreset = newPreset;
  }


  deleteAllPresets() async {
    // Remove data for the 'counter' key.
    await _prefs.remove('presets');
  }

  void addNewPreset(String presetName) async {
    List<String>? presets = _prefs.getStringList('presets');

    if (presets == null || presets!.isEmpty) {
      await _prefs.setStringList('presets', <String>[presetName]);
    }
    else if(presets.contains(presetName)) {
      int index = presets!.indexOf(presetName);
      presets[index] = presetName; // Update the existing value
      await _prefs.setStringList('presets', presets);
    }
    else {
      presets?.add(presetName);
      await _prefs.setStringList('presets', presets!);
    }
  }

  Future<void> deletePreset2(String presetName) async {
    List<String>? presets = _prefs.getStringList('presets');

    // Check if the list is not null and contains the presetName
    if (presets != null && presets.contains(presetName)) {
      // Remove the desired value from the list
      presets.remove(presetName);

      // Save the updated list back to SharedPreferences
      await _prefs.setStringList('presets', presets);
    }
  }

  Future<void> deletePreset(String name) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // final SharedPreferences prefs = _prefs;
    // Makes sure that the user can't delete the first element in the dropdown button
    if(name != "Select preset"){
      final String? settingName = prefs.getString("$name.setting");
      // If the name is found in persistent storage then it will delete it
      if(settingName != null) {
        prefs.remove("$settingName.setting");
        prefs.remove("$settingName.${globalValues.temperature}");
        prefs.remove("$settingName.${globalValues.tensAmplitude}");
        prefs.remove("$settingName.${globalValues.tensDurationCh1}");
        prefs.remove("$settingName.${globalValues.tensPeriod}");
        prefs.remove("$settingName.${globalValues.tensDurationCh2}");
        prefs.remove("$settingName.${globalValues.tensPhase}");
        prefs.remove("$settingName.${globalValues.vibeAmplitude}");
        prefs.remove("$settingName.${globalValues.vibeFreq}");
        prefs.remove("$settingName.${globalValues.vibeWaveform}");
        prefs.remove("$settingName.${globalValues.vibeWaveType}");
        print("removed $settingName");
        // Remove string from dropdown button
        // dropdownItems.remove(selectedItem);
        // selectedItem = dropdownItems.first;
        // Select the first item in the list
        globalValues.setPresetValue(name!);
      }

    }
  }

}