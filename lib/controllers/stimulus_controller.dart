import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pain_drain_mobile_app/controllers/bluetooth_controller.dart';

class StimulusController {
  // Attributes
  late final Map<String, double> _stimuli;
  //late final List<String> _waveTypes;
  late String _currentWaveType;
  late int _currentChannel;
  //late BluetoothController _bleController;
  String tensAmp = "tensAmp";
  String tensPeriod = "tensPeriod";
  String tensDurCh1 = "tensDurCh1";
  String tensDurCh2 = "tensDurCh2";
  String tensPhase = "tensPhase";
  String temp = "temp";
  String vibeIntensity = "vibeIntensity";
  String vibeFreq = "vibeFreq";
  String vibeWaveform = "vibeWaveform";
  String _readTens = "";
  String _readPhase = "";
  String _readTemp = "";
  String _readVibe = "";


  // Constructor
  StimulusController() {
    _initialize();
  }

  // Functions

  // Initializes the class
  _initialize() {

    // Initialize stimuli map
    _stimuli = {
      tensAmp : 0.0,
      tensPeriod : 0.0,
      tensDurCh1 : 0.0,
      tensDurCh2 : 0.0,
      tensPhase : 0.0,
      temp : 0.0,
      vibeIntensity : 0.0,
      vibeFreq : 0.0,
      vibeWaveform : 0.0,
    };
    //BluetoothController _bleController = Get.find();

    // Initialize wave type list
    //_waveTypes = ["Sine", "Triangle", "Square", "Sawtooth"];

    // Initialize current wave type to the first element in the the wave type list
    //_currentWaveType = _waveTypes.first;

    _currentChannel = 1;

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
  void setCurrentWaveType(String waveType) {
    _currentWaveType = waveType;
  }

  void setCurrentChannel(int channel) {
    _currentChannel = channel;
  }

  int getCurrentChannel() {
    return _currentChannel;
  }

  // Get wave type value
  // String getCurrentWaveType(){
  //   return _currentWaveType;
  // }

  // List<String> getAllWaveTypes(){
  //   return _waveTypes;
  // }

  List<String> getAllStimulusValues(){
    List<String> values = [
      _stimuli[tensAmp].toString(),
      _stimuli[tensPeriod].toString(),
      _stimuli[tensDurCh1].toString(),
      _stimuli[tensDurCh2].toString(),
      _stimuli[tensPhase].toString(),
      _currentChannel.toString(),
      _stimuli[temp].toString(),
      _stimuli[vibeIntensity].toString(),
      _stimuli[vibeFreq].toString(),
      _stimuli[vibeWaveform].toString(),
      _currentWaveType,
    ];

    return values;
  }

  bool isPhaseOn() {
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
    setStimulus(tensAmp, 0);
    setStimulus(tensPeriod, 0);
    setStimulus(tensDurCh1, 0);
    setStimulus(tensDurCh2, 0);
    setStimulus(tensDurCh1, 0);
    setStimulus(tensPhase, 0);
    setCurrentChannel(1);
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