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

  String selectedItem = 'Sine';
  List<int> readValueList = [];
  String readValue = "";
  double sliderValue = 0;

  // Create a function to handle the slider change with debounce
  void handleSliderChange(var newValue, String stimulus) async {
    setState(() {
      if(stimulus == 'waveform'){
        globalValues.setSliderValue('waveform', newValue);
      }
      else if(stimulus == 'amplitude'){
        globalValues.setSliderValue('amplitude', newValue);
      }
      else if(stimulus == 'frequency'){
        globalValues.setSliderValue('frequency', newValue);
      }
      else if(stimulus == 'waveType'){
        globalValues.setWaveType(newValue);
      }

    });

    // Implement your async operations here
    String stringCommand = "v ${globalValues.getWaveType().toLowerCase()} ${globalValues.getSliderValue('amplitude').toInt()} ${globalValues.getSliderValue('frequency').toInt()} ${globalValues.getSliderValue('waveform').toInt()}";
    List<int> hexValue = bluetoothController.stringToHexList(stringCommand);
    print(stringCommand);
    print('list hex values $hexValue');
    await bluetoothController.writeToDevice('vibration', hexValue);
    readValueList = await bluetoothController.readFromDevice();
    print('value: $readValue');

    // Update readValue
    setState(() {
      readValue = bluetoothController.hexToString(readValueList); // Replace with your actual value
    });
  }

  void handleDropboxChange(String newValue){

  }
  @override
  Widget build(BuildContext context) {
    double sliderValueAmplitude = globalValues.getSliderValue('amplitude');
    double sliderValueFrequency = globalValues.getSliderValue('frequency');
    double sliderValueWaveform = globalValues.getSliderValue('waveform');
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
        toolbarHeight: 90,
      ),
      body: Center(
        child: Scrollbar(
          child: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.90,
              child: SliderTheme(
                data: const SliderThemeData(
                  trackHeight: 15,
                  activeTrackColor: Colors.blue, // Color of the active portion of the track
                  inactiveTrackColor: Colors.white, // Color of the inactive portion of the track
                  thumbColor: AppColors.blue, // Color of the thumb
                  tickMarkShape: RoundSliderTickMarkShape(
                      tickMarkRadius: 0
                  ),
                  thumbShape: RoundSliderThumbShape(
                    enabledThumbRadius: 15.0, // Adjust the radius as needed
                  ),// Make ticks invisible
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Slider(
                      value: sliderValueAmplitude,
                      min: 0,
                      max: 100,
                      onChanged: (newValue) {
                        setState(() {
                          //globalValues.setSliderValue('amplitude', newValue);
                          handleSliderChange(newValue, 'amplitude');
                        });
                        // Makes a command string for the vibration
                        // String stringCommand = "v ${globalValues.getWaveType().toLowerCase()} ${newValue.round()} ${sliderValueFrequency.toInt()} ${sliderValueWaveform.toInt()}";
                        // List<int> hexValue = bluetoothController.stringToHexList(stringCommand);
                        // print(stringCommand);
                        // bluetoothController.writeToDevice("vibration", hexValue);
                      },
                      label: sliderValueAmplitude.round().abs().toString(),
                      divisions: 20,

                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Adjust amplitude',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,

                      ),
                    ),
                    const SizedBox(height: 40),
                    Slider(
                      value: sliderValueFrequency,
                      min: 0,
                      max: 100,
                      onChanged: (newValue) {
                        setState(() {
                          // globalValues.setSliderValue('frequency', newValue);
                          handleSliderChange(newValue, 'frequency');
                        });
                        // Makes a command string for the vibration
                        // String stringCommand = "v ${globalValues.getWaveType().toLowerCase()} ${sliderValueAmplitude.toInt()} ${newValue.round()} ${sliderValueWaveform.toInt()}";
                        // List<int> hexValue = bluetoothController.stringToHexList(stringCommand);
                        // print(stringCommand);
                        // bluetoothController.writeToDevice("vibration", hexValue);
                        },
                      label: sliderValueFrequency.round().abs().toString(),
                      divisions: 20,

                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Adjust Frequency',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 40),
                    Slider(
                      value: sliderValueWaveform,
                      min: 0,
                      max: 100,
                      onChanged: (newValue) {
                        setState(() {
                          //globalValues.setSliderValue('waveform', newValue);
                          handleSliderChange(newValue, 'waveform');
                        });

                        // Makes a command string for the vibration
                        // String stringCommand = "v ${globalValues.getWaveType().toLowerCase()} ${sliderValueAmplitude.toInt()} ${sliderValueFrequency.toInt()} ${newValue.round()}";
                        // List<int> hexValue = bluetoothController.stringToHexList(stringCommand);
                        // print(stringCommand);
                        // bluetoothController.writeToDevice("vibration", hexValue);
                      },
                      label: sliderValueWaveform.round().abs().toString(),
                      divisions: 20,

                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Adjust Waveform',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
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
                              handleSliderChange(selectedItem, 'waveType');

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
                    const SizedBox(height: 20),
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
                ),
              ),

            ),
          ),
        ),
      ),
    );
  }
}