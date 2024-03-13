import 'package:flutter/material.dart';

class StimulusController {
  // Attributes
  late final Map<String, double> _stimuli;
  late final List<String> _waveTypes;
  late String _currentWaveType;

  // Constructor
  StimulusController() {
    _initialize();
  }

  // Functions

  // Initializes the class
  _initialize() {

    // Initialize stimuli map
    _stimuli = {
      "tensAmp" : 0.0,
      "tensPeriod" : 0.0,
      "tensDurCh1" : 0.0,
      "tensDurCh2" : 0.0,
      "tensPhase" : 0.0,
      "temp" : 0.0,
      "vibeAmp" : 0.0,
      "vibeFreq" : 0.0,
      "vibeWaveform" : 0.0,
    };

    // Initialize wave type list
    _waveTypes = ["Sine", "Triangle", "Square", "Sawtooth"];

    // Initialize current wave type to the first element in the the wave type list
    _currentWaveType = _waveTypes.first;
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

  // Get wave type value
  String getCurrentWaveType(){
    return _currentWaveType;
  }

  List<String> getAllWaveTypes(){
    return _waveTypes;
  }

}