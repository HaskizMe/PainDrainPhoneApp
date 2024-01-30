
/*
This class is responsible for maintaining the slider's values through the whole app
without resetting them after changing to different pages
*/
import 'package:shared_preferences/shared_preferences.dart';

class GlobalValues {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  static final GlobalValues _instance = GlobalValues._internal();
  final Map<String, double> _sliderValues = {
    'tensPeriod' : .5,
  };

  bool deviceConnected = false;
  String waveType = "Sine";
  String presetType = "Select preset";
  List<String> presets = ["Select preset"];
  String tensAmplitude = "tensAmplitude";
  String tensDurationCh1 = "tensDurationCh1";
  String tensPeriod = "tensPeriod";
  String tensDurationCh2 = "tensDurationCh2";
  String tensPhase = "tensPhase";
  String temperature = "temperature";
  String vibeAmplitude = "vibrationAmplitude";
  String vibeFreq = "vibrationFrequency";
  String vibeWaveform = "vibrationWaveform";
  String vibeWaveType = "vibrationWaveType";

  // New map for registers
  final Map<int, String> registers = {
    // for (var item in List.generate(0x7D, (index) => index)) item : ''
    0x00 : '', 0x01 : '', 0x02 : '', 0x03 : '', 0x04 : '', 0x07 : '', 0x0A : '',
    0x1D : '', 0x1E : '', 0x20 : '', 0x26 : '', 0x2D : '', 0x35 : '', 0x36 : '',
    0x40 : '', 0x41 : '', 0x42 : '', 0x43 : '', 0x44 : '', 0x45 : '', 0x46 : '',
    0x47 : '', 0x48 : '', 0x49 : '', 0x4A : '', 0x4B : '', 0x7E : '', 0x60 : '',
    0x61 : '', 0x62 : '', 0x64 : '', 0x65 : '', 0x66 : '', 0x6D : '', 0x75 : '',
    0x7C : '',
  };
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
    //await prefs.clear();
    
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
    //presets.clear();
    return presets;
  }
}