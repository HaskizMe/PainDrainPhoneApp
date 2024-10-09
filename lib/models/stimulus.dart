import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pain_drain_mobile_app/models/bluetooth.dart';

class Stimulus {
  // Attributes
  late final Map<String, double> _stimuli;
  //late final List<String> _waveTypes;
  //late String _currentWaveType;
  //late int _currentChannel;
  int _currentMode = 1;
  //late BluetoothController _bleController;
  String tensIntensity = "tensAmp";
  String tensModeChannel1 = "tensModeChannel1";
  String tensModeChannel2 = "tensModeChannel2";
  String tensPlayButtonChannel1 = "tensPlayButtonChannel1";
  String tensPlayButtonChannel2 = "tensPlayButtonChannel2";
  String currentChannel = "currentChannel";
  String tensPeriod = "tensPeriod";
  String tensDurCh1 = "tensDurCh1";
  String tensDurCh2 = "tensDurCh2";
  String tensPhase = "tensPhase";
  String tensPlayPause = "tensPlayPause";
  String temp = "temp";
  String vibeIntensity = "vibeIntensity";
  String vibeFreq = "vibeFreq";
  String vibeWaveform = "vibeWaveform";
  String _readTens = "";
  String _readPhase = "";
  String _readTemp = "";
  String _readVibe = "";


  // Constructor
  Stimulus() {
    _initialize();
  }

  // Functions

  // Initializes the class
  _initialize() {

    // Initialize stimuli map
    _stimuli = {
      tensIntensity : 0,
      tensModeChannel1 : 1,
      tensModeChannel2 : 1,
      tensPlayButtonChannel1 : 0,
      tensPlayButtonChannel2 : 0,
      currentChannel : 1,
      tensPhase: 0,
      temp : 0,
      vibeIntensity : 0,
      vibeFreq : 0
    };
    //BluetoothController _bleController = Get.find();

    // Initialize wave type list
    //_waveTypes = ["Sine", "Triangle", "Square", "Sawtooth"];

    // Initialize current wave type to the first element in the the wave type list
    //_currentWaveType = _waveTypes.first;

    //_currentChannel = 1;

    //_currentPhase = 0;
  }

  // Sets the stimuli values
  setStimulus(String stimulusName, double value){
    _stimuli[stimulusName] = value;
  }

  // Gets the stimuli values
  double getStimulus(String stimulusName) {
    return _stimuli[stimulusName] ?? 0.0;
  }

  // Sets wave type string value
  // void setCurrentWaveType(String waveType) {
  //   _currentWaveType = waveType;
  // }

  // void setCurrentChannel(int channel) {
  //   _currentChannel = channel;
  // }

  // int getCurrentChannel() {
  //   return _currentChannel;
  // }

  // void setCurrentMode(int mode) {
  //   _currentMode = mode;
  // }
  //
  // int getCurrentMode() {
  //   return _currentMode;
  // }

  // Get wave type value
  // String getCurrentWaveType(){
  //   return _currentWaveType;
  // }

  // List<String> getAllWaveTypes(){
  //   return _waveTypes;
  // }

  List<String> getAllStimulusValues(){
    List<String> values = [
      _stimuli[tensIntensity].toString(),
      _stimuli[tensModeChannel1].toString(),
      _stimuli[tensModeChannel2].toString(),
      _stimuli[tensPlayButtonChannel1].toString(),
      _stimuli[tensPlayButtonChannel2].toString(),
      _stimuli[currentChannel].toString(),
      _stimuli[tensPhase].toString(),
      _stimuli[temp].toString(),
      _stimuli[vibeIntensity].toString(),
      _stimuli[vibeFreq].toString(),
    ];

    return values;
  }

  bool isPhaseOn() {
    print(_stimuli[tensPhase]);
    if(_stimuli[tensPhase] == 0){
      return false;
    }
    return true;
  }

  String getAbbreviation(String waveType) {
    String abbreviatedWaveType = "";
    switch(waveType){
      case "Sine":
        abbreviatedWaveType = "sin";
        break;
      case "Triangle":
        abbreviatedWaveType = "tri";
        break;
      case "Square":
        abbreviatedWaveType = "sq";
        break;
      case "Sawtooth":
        abbreviatedWaveType = "sw";
        break;
    }
    return abbreviatedWaveType;
  }

  void disableAllStimuli(){
    // Disable Tens
    setStimulus(tensIntensity, 0);
    setStimulus(tensPeriod, 0);
    //setStimulus(tensDurCh1, 0);
    //setStimulus(tensDurCh2, 0);
    //setStimulus(tensDurCh1, 0);
    setStimulus(tensPhase, 0);
    //setCurrentChannel(1);
    // Disable Temperature
    setStimulus(temp, 0);
    // Disable Vibration
    setStimulus(vibeIntensity, 0);
    setStimulus(vibeFreq, 0);
  }


  // Getter for readTens
  String get readTens => _readTens;

  // Setter for readTens
  set readTens(String value) {
    _readTens = value;
  }

  // Getter for readPhase
  String get readPhase => _readPhase;

  // Setter for readPhase
  set readPhase(String value) {
    _readPhase = value;
  }

  // Getter for readTemp
  String get readTemp => _readTemp;

  // Setter for readTemp
  set readTemp(String value) {
    _readTemp = value;
  }

  // Getter for readVibe
  String get readVibe => _readVibe;

  // Setter for readVibe
  set readVibe(String value) {
    _readVibe = value;
  }

}