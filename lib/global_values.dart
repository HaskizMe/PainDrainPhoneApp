
/*
This class is responsible for maintaining the slider's values through the whole app
without resetting them after changing to different pages
*/
import 'package:shared_preferences/shared_preferences.dart';

class GlobalValues {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  static final GlobalValues _instance = GlobalValues._internal();
  final Map<String, double> _sliderValues = {};
  // final Map<String, String> _dropDownValue = {};
  String waveType = "Sine";
  String presetType = "Select preset";
  List<String> presets = ["Select preset"];

  factory GlobalValues() {
    return _instance;
  }

  GlobalValues._internal();

  double getSliderValue(String sliderName) {
    return _sliderValues[sliderName] ?? 0;
  }

  void setSliderValue(String sliderName, double newValue) {
    _sliderValues[sliderName] = newValue;
  }

  void setWaveType(String wave) {
    waveType = wave;
  }

  String getWaveType(){
    return waveType;
  }
  void setPresetValue(String preset) {
    presetType = preset;
  }

  String getPresetValue(){
    return presetType;
  }

  Future<List<String>> getPresets() async {
    final SharedPreferences prefs = await _prefs;
   // await prefs.clear();
    
    List<String> keys = prefs.getKeys().toList();
    for (String element in keys){
      if(element.contains("setting")){
        final value = prefs.getString(element);
        if(value != null && !presets.contains(value)){
          presets.add(value);
        }
      }
    }
    print("My map ${prefs.getKeys()}");
    print("My presets list $presets");
    return presets;
  }
}