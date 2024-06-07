import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pain_drain_mobile_app/controllers/bluetooth_controller.dart';
import 'package:pain_drain_mobile_app/controllers/stimulus_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class SavedPresets{
  // Attributes
  //late final SharedPreferences _prefs;
  late final SharedPreferences _prefs;
  //List<String>? _presets;
  String? _currentPreset;
  late final StimulusController _stimController;
  late bool _isDevControls;


  // Constructor
  SavedPresets() {
    _initialize();
  }

  // Methods
  Future<void> _initialize() async {
    _stimController = Get.find();
    // Initialize shared preferences
    _prefs = await SharedPreferences.getInstance();
    _isDevControls = false;
    //_prefs.clear();
  }

  List<String> getPresets() {
    //List<String> presets = _prefs.getKeys().toList()..sort();
    //List<String> presets = _prefs.getKeys().where((key) => key.contains("preset")).toList()..sort();
    //List<String> presets = _prefs.getKeys().where((key) => key.contains("preset.")).map((key) => key.replaceAll("preset.", "")).toList()..sort();
    List<String> presets = _prefs.getKeys().where((key) => key.contains("preset.")).map((key) => key.substring(7)).toList()..sort();



    return presets;
  }
  Set<String> getKeys() {
    final Set<String> allKeys = _prefs.getKeys().where((key) => key.contains("preset")).toSet();
    return allKeys;
  }

  String? getCurrentPreset() {
    // return _currentPreset?.replaceAll("preset.", "");
    return _currentPreset?.substring(7);

  }

  void setCurrentPreset(String? newPreset){
    _currentPreset = "preset.$newPreset";
  }


  deleteAllPresets() async {
    await _prefs.clear();
  }

  void addNewPreset(String presetName) async {
    List<String> presetValues = _stimController.getAllStimulusValues();

    await _prefs.setStringList("preset.$presetName", presetValues);

    print(_prefs.getStringList("preset.$presetName"));
    print(_prefs.getKeys());

  }

  Future<void> deletePreset(String presetName) async {
    print("delete Here 2");
    // Check if the list is not null and contains the presetName
    if (_prefs.getKeys().contains("preset.$presetName")) {
      // Remove the desired value from the list
      await _prefs.remove("preset.$presetName");
    }
    print(_prefs.getKeys());
  }

  void loadPreset(String presetName) {
    if (_prefs.getKeys().contains("preset.$presetName") && _prefs.getStringList("preset.$presetName") != null) {
      List<String> presetValues = _prefs.getStringList("preset.$presetName")!;
      _stimController.setStimulus(_stimController.tensAmp, double.parse(presetValues[0]));
      _stimController.setStimulus(_stimController.tensPeriod, double.parse(presetValues[1]));
      _stimController.setStimulus(_stimController.tensDurCh1, double.parse(presetValues[2]));
      _stimController.setStimulus(_stimController.tensDurCh2, double.parse(presetValues[3]));
      _stimController.setStimulus(_stimController.tensPhase, double.parse(presetValues[4]));
      _stimController.setCurrentChannel(int.parse(presetValues[5]));
      _stimController.setStimulus(_stimController.temp, double.parse(presetValues[6]));
      _stimController.setStimulus(_stimController.vibeIntensity, double.parse(presetValues[7]));
      _stimController.setStimulus(_stimController.vibeFreq, double.parse(presetValues[8]));
      _stimController.setStimulus(_stimController.vibeWaveform, double.parse(presetValues[9]));
      _stimController.setCurrentWaveType(presetValues[10]);
      print(_prefs.getStringList("preset.$presetName"));
    }
  }

  bool getDevControls(){
    return _isDevControls;
  }

  setDevControls(bool isEnabled) {
    _isDevControls = isEnabled;
  }

}