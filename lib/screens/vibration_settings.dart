import 'package:flutter/material.dart';
import 'package:pain_drain_mobile_app/ble/bluetooth_controller.dart';
import 'package:get/get.dart';
import 'package:pain_drain_mobile_app/global_slider_values.dart';
import 'package:pain_drain_mobile_app/scheme_colors/app_colors.dart';


class VibrationSettings extends StatefulWidget {
  const VibrationSettings({Key? key}) : super(key: key);

  @override
  State<VibrationSettings> createState() => _VibrationSettingsState();
}

class _VibrationSettingsState extends State<VibrationSettings> {
  final sliderValuesSingleton = SliderValuesSingleton();
  final BluetoothController bluetoothController = Get.find<BluetoothController>();

  String _selectedItem = 'Sine';


  @override
  Widget build(BuildContext context) {
    double sliderValueAmplitude = sliderValuesSingleton.getSliderValue('amplitude');
    double sliderValueFrequency = sliderValuesSingleton.getSliderValue('frequency');
    double sliderValueWaveform = sliderValuesSingleton.getSliderValue('waveform');
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

          child: SizedBox(
            width: MediaQuery
                .of(context)
                .size
                .width * 0.80,
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
                children: [
                  Slider(
                    value: sliderValueAmplitude,
                    min: 0,
                    max: 100,
                    onChanged: (newValue) {
                      setState(() {
                        sliderValuesSingleton.setSliderValue('amplitude', newValue);
                      });
                      // Makes a command string for the vibration
                      String stringCommand = "v ${_selectedItem.toLowerCase()} ${newValue.round()} ${sliderValueFrequency.toInt()} ${sliderValueWaveform.toInt()}";
                      List<int> hexValue = bluetoothController.stringToHexList(stringCommand);
                      print(stringCommand);
                      bluetoothController.writeToDevice("vibration", hexValue);
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
                        sliderValuesSingleton.setSliderValue('frequency', newValue);
                      });
                      // Makes a command string for the vibration
                      String stringCommand = "v ${_selectedItem.toLowerCase()} ${sliderValueAmplitude.toInt()} ${newValue.round()} ${sliderValueWaveform.toInt()}";
                      List<int> hexValue = bluetoothController.stringToHexList(stringCommand);
                      print(stringCommand);
                      bluetoothController.writeToDevice("vibration", hexValue);
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
                        sliderValuesSingleton.setSliderValue('waveform', newValue);
                      });

                      // Makes a command string for the vibration
                      String stringCommand = "v ${_selectedItem.toLowerCase()} ${sliderValueAmplitude.toInt()} ${sliderValueFrequency.toInt()} ${newValue.round()}";
                      List<int> hexValue = bluetoothController.stringToHexList(stringCommand);
                      print(stringCommand);
                      bluetoothController.writeToDevice("vibration", hexValue);
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
                        value: _selectedItem,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedItem = newValue!;
                          });
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

                ],
              ),
            ),

          ),
        ),
    );
  }
}