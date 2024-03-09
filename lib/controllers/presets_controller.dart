import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class SavedPresets{
  late final SharedPreferences _prefs;
  //final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  // void setPreferences() async{
  //   final SharedPreferences prefs = await _prefs;
  // }

  SavedPresets() {
    _initialize();
  }

  Future<void> _initialize() async {
    _prefs = await SharedPreferences.getInstance();


    //deleteAllPresets();
    // Store dummy data everytime in shared prefs
    await _prefs.setStringList('presets', <String>[
      'preset 1', 'preset 2', 'preset 3', 'preset 4', 'preset 5', 'preset 6'
    ]);
    getPresets();
  }

  List<String>? getPresets() {
    final List<String>? presets = _prefs.getStringList('presets');
    print("All presets: $presets");
    return presets;
  }

  deleteAllPresets() async {
    // Remove data for the 'counter' key.

    await _prefs.remove('pesets');
  }

  void addNewPreset(String name) {

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