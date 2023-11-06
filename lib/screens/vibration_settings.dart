import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pain_drain_mobile_app/ble/bluetooth_controller.dart';
import 'package:get/get.dart';
import 'package:pain_drain_mobile_app/scheme_colors/app_colors.dart';

import '../main.dart';


class VibrationSettings extends StatefulWidget {
  const VibrationSettings({Key? key}) : super(key: key);

  @override
  State<VibrationSettings> createState() => _VibrationSettingsState();
}

class _VibrationSettingsState extends State<VibrationSettings> {
  //final sliderValuesSingleton = SliderValuesSingleton();
  final BluetoothController bluetoothController = Get.find<BluetoothController>();
  final Duration writeDelay = const Duration(milliseconds: 500);
  Timer? writeTimer;
  String selectedItem = 'Sine';
  List<int> readValueList = [];
  String readValue = "";
  double sliderValue = 0;

  // Create a function to handle the slider change with debounce
  void handleSliderChange(var newValue, String stimulus) async {
    setState(() {
      if(stimulus == 'vibrationWaveform'){
        globalValues.setSliderValue('vibrationWaveform', newValue);
      }
      else if(stimulus == 'vibrationAmplitude'){
        globalValues.setSliderValue('vibrationAmplitude', newValue);
      }
      else if(stimulus == 'vibrationFrequency'){
        globalValues.setSliderValue('vibrationFrequency', newValue);
      }
      else if(stimulus == 'vibrationWaveType'){
        globalValues.setWaveType(newValue);
      }

    });
    // Restarts timer when slider value changes
    writeTimer?.cancel();
    /*
    * Only sends a value if the slider has paused for at
    * least 1 second so we aren't sending a of unnecessary values.
    */
    writeTimer = Timer(writeDelay, () async {
      // Implement your async operations here
      String stringCommand = "v ${globalValues.getWaveType().toLowerCase()} ${globalValues.getSliderValue('vibrationAmplitude').toInt()} ${globalValues.getSliderValue('vibrationFrequency').toInt()} ${globalValues.getSliderValue('vibrationWaveform').toInt()}";
      List<int> hexValue = bluetoothController.stringToHexList(stringCommand);
      print(stringCommand);
      print('list hex values $hexValue');
      await bluetoothController.writeToDevice('vibration', hexValue);
      readValueList = await bluetoothController.readFromDevice();
      //print('value: $readValue');
      // Update readValue
      setState(() {
        readValue = bluetoothController.hexToString(readValueList); // Replace with your actual value
      });
    });
  }

  @override
  void dispose() {
    writeTimer?.cancel(); // Cancel the timer when the widget is disposed.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double sliderValueAmplitude = globalValues.getSliderValue('vibrationAmplitude');
    double sliderValueFrequency = globalValues.getSliderValue('vibrationFrequency');
    double sliderValueWaveform = globalValues.getSliderValue('vibrationWaveform');
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: const Text(
          'Vibration',
          style: TextStyle(
            fontSize: 50,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[900],
        centerTitle: true,
        //toolbarHeight: 90,
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * .65,
          //color: Colors.green,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                elevation: 20.0,
                color: Colors.grey[700],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)
                ),
                child: Container(
                  //color: Colors.black,
                  //width: MediaQuery.of(context).size.width * 0.90,
                  height: MediaQuery.of(context).size.height * .5,
                  child: SliderTheme(
                    data: const SliderThemeData(
                      trackHeight: 50,
                      activeTrackColor: Colors.blue, // Color of the active portion of the track
                      inactiveTrackColor: Colors.grey, // Color of the inactive portion of the track
                      thumbColor: AppColors.blue, // Color of the thumb
                      tickMarkShape: RoundSliderTickMarkShape(
                          tickMarkRadius: 0
                      ),
                      thumbShape: RoundSliderThumbShape(
                        enabledThumbRadius: 30.0, // Adjust the radius as needed
                      ),// Make ticks invisible
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 100,
                          child: Column(
                            children: [
                              Expanded(
                                child: Stack(
                                  children: [
                                    RotatedBox(
                                      quarterTurns: -1,
                                      child: Slider(
                                        value: sliderValueAmplitude,
                                        min: 0,
                                        max: 100,
                                        onChanged: (newValue) {
                                          setState(() {
                                            //globalValues.setSliderValue('amplitude', newValue);
                                            handleSliderChange(newValue, 'vibrationAmplitude');
                                          });
                                          // Makes a command string for the vibration
                                          // String stringCommand = "v ${globalValues.getWaveType().toLowerCase()} ${newValue.round()} ${sliderValueFrequency.toInt()} ${sliderValueWaveform.toInt()}";
                                          // List<int> hexValue = bluetoothController.stringToHexList(stringCommand);
                                          // print(stringCommand);
                                          // bluetoothController.writeToDevice("vibration", hexValue);
                                        },
                                        //label: sliderValueAmplitude.round().abs().toString(),
                                        divisions: 20,

                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: IgnorePointer(
                                          ignoring: true,
                                          child: Text(
                                            '${sliderValueAmplitude.round()}%',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                                child: Text(
                                  'Amplitude',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white,

                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Stack(
                                  children: [
                                    RotatedBox(
                                      quarterTurns: -1,
                                      child: Slider(
                                        value: sliderValueFrequency,
                                        min: 0,
                                        max: 100,
                                        onChanged: (newValue) {
                                          setState(() {
                                            // globalValues.setSliderValue('frequency', newValue);
                                            handleSliderChange(newValue, 'vibrationFrequency');
                                          });
                                          // Makes a command string for the vibration
                                          // String stringCommand = "v ${globalValues.getWaveType().toLowerCase()} ${sliderValueAmplitude.toInt()} ${newValue.round()} ${sliderValueWaveform.toInt()}";
                                          // List<int> hexValue = bluetoothController.stringToHexList(stringCommand);
                                          // print(stringCommand);
                                          // bluetoothController.writeToDevice("vibration", hexValue);
                                        },
                                        //label: sliderValueFrequency.round().abs().toString(),
                                        divisions: 20,

                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: IgnorePointer(
                                          ignoring: true,
                                          child: Text(
                                            '${sliderValueFrequency.round()}%',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),

                              ),
                              const SizedBox(height: 10),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                                child: Text(
                                  'Frequency',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Stack(
                                  children: [
                                    RotatedBox(
                                      quarterTurns: -1,
                                      child: Slider(
                                        value: sliderValueWaveform,
                                        min: 0,
                                        max: 100,
                                        onChanged: (newValue) {
                                          setState(() {
                                            //globalValues.setSliderValue('waveform', newValue);
                                            handleSliderChange(newValue, 'vibrationWaveform');
                                          });

                                          // Makes a command string for the vibration
                                          // String stringCommand = "v ${globalValues.getWaveType().toLowerCase()} ${sliderValueAmplitude.toInt()} ${sliderValueFrequency.toInt()} ${newValue.round()}";
                                          // List<int> hexValue = bluetoothController.stringToHexList(stringCommand);
                                          // print(stringCommand);
                                          // bluetoothController.writeToDevice("vibration", hexValue);
                                        },
                                        //label: sliderValueWaveform.round().abs().toString(),
                                        divisions: 20,

                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: IgnorePointer(
                                          ignoring: true,
                                          child: Text(
                                            '${sliderValueWaveform.round()}%',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                                child: Text(
                                  'Waveform',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      margin: const EdgeInsets.fromLTRB(0, 25, 20, 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child:
                      DropdownButton(
                        value: globalValues.getWaveType(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedItem = newValue!;
                            //globalValues.setWaveType(selectedItem);
                            handleSliderChange(selectedItem, 'vibrationWaveType');

                          });
                          // String stringCommand = "v ${globalValues.getWaveType().toLowerCase()} ${sliderValueAmplitude.toInt()} ${sliderValueFrequency.toInt()} ${sliderValueWaveform.toInt()}";
                          // List<int> hexValue = bluetoothController.stringToHexList(stringCommand);
                          // print(stringCommand);
                          // bluetoothController.writeToDevice("vibration", hexValue);
                        },
                        items: <String>['Sine', 'Square', 'Triangle', 'Sawtooth']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        underline: Container(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  if(readValue.isNotEmpty)
                    Text(
                      readValue,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}