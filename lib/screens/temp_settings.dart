import 'package:flutter/material.dart';
import 'package:pain_drain_mobile_app/scheme_colors/app_colors.dart';
import 'package:pain_drain_mobile_app/ble/bluetooth_controller.dart';
import 'package:get/get.dart';
import '../global_values.dart';
import '../main.dart';

class TempSettings extends StatefulWidget {
  const TempSettings({Key? key}) : super(key: key);

  @override
  State<TempSettings> createState() => _TempSettingsState();
}

class _TempSettingsState extends State<TempSettings> {
  // final sliderValuesSingleton = SliderValuesSingleton();
  final BluetoothController bluetoothController = Get.find<BluetoothController>();

  final double _min = -100;
  final double _max = 100;
  List<int> readValueList = [];
  String readValue = "";
  double sliderValue = 0;

  // Create a function to handle the slider change with debounce
  void handleSliderChange(double newValue) async {
    setState(() {
      globalValues.setSliderValue('temperature', newValue);
    });

    // Implement your async operations here
    print('Slider value: ${newValue.round()}');
    String stringCommand = "t ${newValue.round()}";
    List<int> hexValue = bluetoothController.stringToHexList(stringCommand);
    print(hexValue);
    await bluetoothController.writeToDevice("temperature", hexValue);
    readValueList = await bluetoothController.readFromDevice();
    print('value: $readValue');

    // Update readValue
    setState(() {
      readValue = bluetoothController.hexToString(readValueList); // Replace with your actual value
    });
  }
  @override
  Widget build(BuildContext context) {
    double temperatureSliderValue = globalValues.getSliderValue('temperature');
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: const Text(
          'Temperature',
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
              width: MediaQuery.of(context).size.width * 0.80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: _min.abs().round(),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(100.0),
                                  bottomLeft: Radius.circular(100.0)
                                ),
                                child: SizedBox(
                                  height: 15,
                                  child: LinearProgressIndicator(
                                    value: 1 - temperatureSliderValue / _min,
                                    color: Colors.white,
                                    backgroundColor: Colors.blue,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: _max.abs().round(),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(100.0),
                                    bottomRight: Radius.circular(100.0)
                                ),
                                child: SizedBox(
                                  height: 15,
                                  child: LinearProgressIndicator(
                                    value: temperatureSliderValue / _max,
                                    color: Colors.red,
                                    backgroundColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SliderTheme(
                        data: const SliderThemeData(
                          trackHeight: 15.0,
                          thumbShape: RoundSliderThumbShape(
                            enabledThumbRadius: 15.0,
                          ),
                          // Customize other properties as needed
                        ),
                        child: Slider(
                          value: temperatureSliderValue,
                          activeColor: Colors.transparent,
                          inactiveColor: Colors.transparent,
                          thumbColor: temperatureSliderValue == 0
                              ? Colors.blue
                              : temperatureSliderValue > 0
                              ? Colors.red
                              : Colors.blue,
                          min: _min,
                          max: _max,
                          divisions: ((_min.abs() + _max.abs())/5).round(),
                          label: temperatureSliderValue.round().toString(),
                          onChanged: (double newValue) {
                            setState(() {
                              handleSliderChange(newValue);
                              //globalValues.setSliderValue('temperature', newValue);
                            });
                            // print('Slider value: ${newValue.round()}');
                            // String stringCommand = "t ${newValue.round()}";
                            // List<int> hexValue = bluetoothController.stringToHexList(stringCommand);
                            // print(hexValue);
                            // bluetoothController.writeToDevice("temperature", hexValue);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Adjust Temperature',
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
    );
  }
}
