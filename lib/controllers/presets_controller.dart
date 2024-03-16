import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pain_drain_mobile_app/controllers/bluetooth_controller.dart';
import 'package:pain_drain_mobile_app/controllers/stimulus_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class SavedPresets{
  // Attributes
  late final SharedPreferences _prefs;
  //List<String>? _presets;
  String? _currentPreset;
  late final StimulusController _stimController;


  // Constructor
  SavedPresets() {
    _initialize();
  }

  // Methods
  Future<void> _initialize() async {
    _stimController = Get.find();
    // Initialize shared preferences
    _prefs = await SharedPreferences.getInstance();
  }

  List<String> getPresets() {
    List<String> presets = _prefs.getKeys().toList()..sort();
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
    await _prefs.clear();
  }

  void addNewPreset(String presetName) async {
    List<String> presetValues = _stimController.getAllStimulusValues();

    await _prefs.setStringList(presetName, presetValues);

    print(_prefs.getStringList(presetName));
    print(_prefs.getKeys());

  }

  Future<void> deletePreset2(String presetName) async {
    // Check if the list is not null and contains the presetName
    if (_prefs.getKeys().contains(presetName)) {
      // Remove the desired value from the list
      await _prefs.remove(presetName);
    }
    print(_prefs.getKeys());
  }

  void loadPreset(String presetName) {
    if (_prefs.getKeys().contains(presetName) && _prefs.getStringList(presetName) != null) {
      // Remove the desired value from the list
      List<String> presetValues = _prefs.getStringList(presetName)!;
      _stimController.setStimulus(_stimController.tensAmp, double.parse(presetValues[0]));
      _stimController.setStimulus(_stimController.tensPeriod, double.parse(presetValues[1]));
      _stimController.setStimulus(_stimController.tensDurCh1, double.parse(presetValues[2]));
      _stimController.setStimulus(_stimController.tensDurCh2, double.parse(presetValues[3]));
      _stimController.setStimulus(_stimController.tensPhase, double.parse(presetValues[4]));
      _stimController.setCurrentChannel(int.parse(presetValues[5]));
      _stimController.setStimulus(_stimController.temp, double.parse(presetValues[6]));
      _stimController.setStimulus(_stimController.vibeAmp, double.parse(presetValues[7]));
      _stimController.setStimulus(_stimController.vibeFreq, double.parse(presetValues[8]));
      _stimController.setStimulus(_stimController.vibeWaveform, double.parse(presetValues[9]));
      _stimController.setCurrentWaveType(presetValues[10]);
      print(_prefs.getStringList(presetName));
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