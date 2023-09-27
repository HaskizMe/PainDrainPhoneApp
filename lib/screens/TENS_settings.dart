import 'package:flutter/material.dart';
import 'package:pain_drain_mobile_app/global_values.dart';
import 'package:pain_drain_mobile_app/scheme_colors/app_colors.dart';
import 'package:pain_drain_mobile_app/ble/bluetooth_controller.dart';
import 'package:get/get.dart';

import '../main.dart';



class TENSSettings extends StatefulWidget with WidgetsBindingObserver {
  const TENSSettings({Key? key}) : super(key: key);

  @override
  State<TENSSettings> createState() => _TENSSettingsState();
}

class _TENSSettingsState extends State<TENSSettings> with WidgetsBindingObserver {

  final BluetoothController bluetoothController = Get.find<BluetoothController>();
  List<int> readValueList = [];
  String readValue = "";
  double sliderValue = 0;

  // A function to handle the slider change with debounce
  void handleSliderChange(double newValue) async {
      setState(() {
        globalValues.setSliderValue('tens', newValue);
      });

      // Implement your async operations here
      print('Slider value: ${newValue.round()}');
      String stringCommand = "T ${newValue.round()}";
      List<int> hexValue = bluetoothController.stringToHexList(stringCommand);
      await bluetoothController.writeToDevice("tens", hexValue);
      readValueList = await bluetoothController.readFromDevice();
      print('value: $readValue');

      // Update readValue
      setState(() {
        readValue = bluetoothController.hexToString(readValueList); // Replace with your actual value
      });
  }

  @override
  Widget build(BuildContext context) {
    double sliderValue = globalValues.getSliderValue('tens');
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: const Text(
          'TENS',
          style: TextStyle(
            color: Colors.white,
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
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.70,
              child: SliderTheme(
                data: SliderThemeData(
                  trackHeight: 15,
                  activeTrackColor: AppColors.blue, // Color of the active portion of the track
                  inactiveTrackColor: Colors.white, // Color of the inactive portion of the track
                  thumbColor: Colors.blue[600], // Color of the thumb
                  tickMarkShape: const RoundSliderTickMarkShape(
                      tickMarkRadius: 0
                  ),
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 15.0, // Adjust the radius as needed
                  ),// Make ticks invisible
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Slider(
                      value: sliderValue,
                      min: 0,
                      max: 100,
                      onChanged: (newValue) {
                        setState(() {
                          handleSliderChange(newValue);
                        });
                      },
                      label: sliderValue.round().toString(),
                      divisions: 20,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Adjust TENS',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
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
                ),
              ),

            ),
          ),
        ),
      )
    );
  }
}

