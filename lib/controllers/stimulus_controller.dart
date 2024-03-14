import 'package:flutter/material.dart';

class StimulusController {
  // Attributes
  late final Map<String, double> _stimuli;
  late final List<String> _waveTypes;
  late String _currentWaveType;
  late int _currentChannel;
  String tensAmp = "tensAmp";
  String tensPeriod = "tensPeriod";
  String tensDurCh1 = "tensDurCh1";
  String tensDurCh2 = "tensDurCh2";
  String tensPhase = "tensPhase";
  String temp = "temp";
  String vibeAmp = "vibeAmp";
  String vibeFreq = "vibeFreq";
  String vibeWaveform = "vibeWaveform";


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
      vibeAmp : 0.0,
      vibeFreq : 0.0,
      vibeWaveform : 0.0,
    };

    // Initialize wave type list
    _waveTypes = ["Sine", "Triangle", "Square", "Sawtooth"];

    // Initialize current wave type to the first element in the the wave type list
    _currentWaveType = _waveTypes.first;

    _currentChannel = 1;
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
  String getCurrentWaveType(){
    return _currentWaveType;
  }

  List<String> getAllWaveTypes(){
    return _waveTypes;
  }

}