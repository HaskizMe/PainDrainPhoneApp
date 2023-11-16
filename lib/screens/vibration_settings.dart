import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pain_drain_mobile_app/ble/bluetooth_controller.dart';
import 'package:get/get.dart';
import 'package:pain_drain_mobile_app/scheme_colors/app_colors.dart';

import '../main.dart';
import '../widgets/custom_card.dart';
import '../widgets/custom_slider.dart';


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
  void handleSliderChange(var newValue, String stimulus, int channel) async {
    setState(() {
      if(stimulus == globalValues.vibeWaveform){
        globalValues.setSliderValue(globalValues.vibeWaveform, newValue);
      }
      else if(stimulus == globalValues.vibeAmplitude){
        globalValues.setSliderValue(globalValues.vibeAmplitude, newValue);
      }
      else if(stimulus == globalValues.vibeFreq){
        globalValues.setSliderValue(globalValues.vibeFreq, newValue);
      }
      else if(stimulus == globalValues.vibeWaveType){
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
      String stringCommand = "v ${globalValues.getWaveType().toLowerCase()} ${globalValues.getSliderValue(globalValues.vibeAmplitude).toInt()} ${globalValues.getSliderValue(globalValues.vibeFreq).toInt()} ${globalValues.getSliderValue(globalValues.vibeWaveform).toInt()}";
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
    double sliderValueAmplitude = globalValues.getSliderValue(globalValues.vibeAmplitude);
    double sliderValueFrequency = globalValues.getSliderValue(globalValues.vibeFreq);
    double sliderValueWaveform = globalValues.getSliderValue(globalValues.vibeWaveform);
    List<Widget> vibeSliders = [
      CustomSlider(
        min: 0,
        max: 100,
        divisions: 20,
        handleSliderChange: handleSliderChange,
        value: sliderValueAmplitude,
        trackHeight: 50.0,
        activeTrackColor: Colors.blue,
        inactiveTrackColor: Colors.grey,
        thumbColor: Colors.blue,
        thumbRadius: 30.0,
        sliderName: globalValues.vibeAmplitude,
        sliderLabel: 'Amplitude',
        valueLabel: "${sliderValueAmplitude.round()}%",
        channel: 0,
        height: MediaQuery.of(context).size.height * 0.55,
      ),
      CustomSlider(
        min: 0,
        max: 100,
        divisions: 20,
        handleSliderChange: handleSliderChange,
        value: sliderValueFrequency,
        trackHeight: 50.0,
        activeTrackColor: Colors.blue,
        inactiveTrackColor: Colors.grey,
        thumbColor: Colors.blue,
        thumbRadius: 30.0,
        sliderName: globalValues.vibeFreq,
        sliderLabel: 'Frequency',
        valueLabel: "${sliderValueFrequency.round()}%",
        channel: 0,
        height: MediaQuery.of(context).size.height * 0.55
      ),
      CustomSlider(
        min: 0,
        max: 100,
        divisions: 20,
        handleSliderChange: handleSliderChange,
        value: sliderValueWaveform,
        trackHeight: 50.0,
        activeTrackColor: Colors.blue,
        inactiveTrackColor: Colors.grey,
        thumbColor: Colors.blue,
        thumbRadius: 30.0,
        sliderName: globalValues.vibeWaveform,
        sliderLabel: 'Waveform',
        valueLabel: "${sliderValueWaveform.round()}%",
        channel: 0,
        height: MediaQuery.of(context).size.height * 0.55
      ),
      // You can add more sliders here
    ];
    return Scaffold(
      backgroundColor: AppColors.darkGrey,
      appBar: AppBar(
        title: const Text(
          'Vibration',
          style: TextStyle(
            fontSize: 50,
            color: AppColors.offWhite
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[900],
        centerTitle: true,
        //toolbarHeight: 90,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomCard(widgets: vibeSliders, width: double.infinity, spacing: 10.0,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    margin: const EdgeInsets.fromLTRB(0, 25, 20, 0),
                    decoration: BoxDecoration(
                      color: AppColors.offWhite,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:
                    DropdownButton(
                      value: globalValues.getWaveType(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedItem = newValue!;
                          //globalValues.setWaveType(selectedItem);
                          handleSliderChange(selectedItem, globalValues.vibeWaveType, 0);

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
                      color: AppColors.offWhite,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                const SizedBox(height: 80)
              ],
            )
          ],
        ),
      ),
    );
  }
}