import 'package:flutter/material.dart';
import 'package:pain_drain_mobile_app/global_values.dart';
import 'package:pain_drain_mobile_app/scheme_colors/app_colors.dart';
import 'package:pain_drain_mobile_app/ble/bluetooth_controller.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
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
  //double sliderValue = 0;

  // A function to handle the slider change with debounce
  // void handleSliderChange(double newValue) async {
  //     setState(() {
  //       globalValues.setSliderValue('tens', newValue);
  //     });
  //
  //     // Implement your async operations here
  //     print('Slider value: ${newValue.round()}');
  //     String stringCommand = "T ${newValue.round()}";
  //     List<int> hexValue = bluetoothController.stringToHexList(stringCommand);
  //     await bluetoothController.writeToDevice("tens", hexValue);
  //     readValueList = await bluetoothController.readFromDevice();
  //     print('value: $readValue');
  //
  //     // Update readValue
  //     setState(() {
  //       readValue = bluetoothController.hexToString(readValueList); // Replace with your actual value
  //     });
  // }

  // Create a function to handle the slider change with debounce
  void handleSliderChange(var newValue, String stimulus) async {
    setState(() {
      if(stimulus == 'tensDuration'){
        globalValues.setSliderValue('tensDuration', newValue);
      }
      else if(stimulus == 'tensAmplitude'){
        globalValues.setSliderValue('tensAmplitude', newValue);
      }
      else if(stimulus == 'tensPeriod'){
        globalValues.setSliderValue('tensPeriod', newValue);
      }
    });

    // Implement your async operations here
    String stringCommand = "T ${globalValues.getSliderValue('tensAmplitude').toInt()} ${globalValues.getSliderValue('tensDuration')} ${globalValues.getSliderValue('tensPeriod')}";
    List<int> hexValue = bluetoothController.stringToHexList(stringCommand);
    print('Value: $stringCommand');
    print('list hex values $hexValue');
    await bluetoothController.writeToDevice('tens', hexValue);
    readValueList = await bluetoothController.readFromDevice();
    //print('value: $');

    // Update readValue
    setState(() {
      readValue = bluetoothController.hexToString(readValueList); // Replace with your actual value
    });
  }
  @override
  Widget build(BuildContext context) {
    double sliderValuePeriod = globalValues.getSliderValue('tensPeriod');
    double sliderValueDuration = globalValues.getSliderValue('tensDuration');
    double sliderValueAmplitude = globalValues.getSliderValue('tensAmplitude');
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
          child: Container(
            height: MediaQuery.of(context).size.height * 0.65,
            //color: Colors.green,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  //color: Colors.black,
                  height: MediaQuery.of(context).size.height * .5,
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
                                          handleSliderChange(newValue, 'tensAmplitude');
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
                            const Text(
                              'Amplitude',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white,

                              ),
                            ),
                          ],
                        ),
                      ),
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
                                      value: sliderValueDuration,
                                      min: 0.1,
                                      max: 1.0,
                                      onChanged: (newValue) {
                                        setState(() {
                                          //globalValues.setSliderValue('amplitude', newValue);
                                          handleSliderChange(newValue, 'tensDuration');
                                        });
                                        // Makes a command string for the vibration
                                        // String stringCommand = "v ${globalValues.getWaveType().toLowerCase()} ${newValue.round()} ${sliderValueFrequency.toInt()} ${sliderValueWaveform.toInt()}";
                                        // List<int> hexValue = bluetoothController.stringToHexList(stringCommand);
                                        // print(stringCommand);
                                        // bluetoothController.writeToDevice("vibration", hexValue);
                                      },
                                      //label: sliderValueAmplitude.round().abs().toString(),
                                      divisions: 9,
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: IgnorePointer(
                                        ignoring: true,
                                        child: Text(
                                          '${sliderValueDuration}s',
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
                            const Text(
                              'Duration',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white,

                              ),
                            ),
                          ],
                        ),
                      ),
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
                                      value: sliderValuePeriod,
                                      min: 0.5,
                                      max: 10,
                                      divisions: (10.0 - 0.5) ~/ 0.5,
                                      onChanged: (newValue) {
                                        setState(() {
                                          //globalValues.setSliderValue('amplitude', newValue);
                                          handleSliderChange(newValue, 'tensPeriod');
                                        });
                                        // Makes a command string for the vibration
                                        // String stringCommand = "v ${globalValues.getWaveType().toLowerCase()} ${newValue.round()} ${sliderValueFrequency.toInt()} ${sliderValueWaveform.toInt()}";
                                        // List<int> hexValue = bluetoothController.stringToHexList(stringCommand);
                                        // print(stringCommand);
                                        // bluetoothController.writeToDevice("vibration", hexValue);
                                      },

                                    ),
                                  ),
                                  Positioned.fill(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: IgnorePointer(
                                        ignoring: true,
                                        child: Text(
                                          '${sliderValuePeriod}s',
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
                            const Text(
                              'Period',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white,

                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
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
          // child: Container(
          //   height: MediaQuery.of(context).size.height * 0.5,
          //   color: Colors.green,
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Expanded(
          //         child: Container(
          //           color: Colors.black,
          //           //height: MediaQuery.of(context).size.height * 0.5,
          //           child: Column(
          //              //mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Expanded(
          //                 child: Container(
          //                   color: Colors.pink,
          //                   child: Stack(
          //                     alignment: Alignment.center,
          //                     children: [
          //                       RotatedBox(
          //                         quarterTurns: 3,
          //                         child: Container(
          //                           child: Slider(
          //                             value: sliderValue,
          //                             min: 0,
          //                             max: 100,
          //                             onChanged: (newValue) {
          //                               setState(() {
          //                                 handleSliderChange(newValue);
          //                               });
          //                             },
          //                             //label: sliderValue.round().toString(),
          //                             divisions: 20,
          //                           ),
          //                         ),
          //                       ),
          //                       Center(
          //                         child: IgnorePointer(
          //                           ignoring: true,
          //                           child: Text(
          //                             '${sliderValue.round()}',
          //                             style: const TextStyle(
          //                               color: Colors.white,
          //                               fontWeight: FontWeight.bold,
          //                               fontSize: 24,
          //                             ),
          //                           ),
          //                         ),
          //                       )
          //                     ],
          //
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //
          //       const SizedBox(height: 10),
          //       const Text(
          //         'Adjust TENS',
          //         style: TextStyle(
          //           color: Colors.white,
          //           fontWeight: FontWeight.bold,
          //           fontSize: 20,
          //         ),
          //       ),
          //       const SizedBox(height: 10),
          //       if(readValue.isNotEmpty)
          //         Text(
          //           readValue,
          //           style: const TextStyle(
          //             color: Colors.white,
          //             fontWeight: FontWeight.bold,
          //             fontSize: 20,
          //           ),
          //         ),
          //     ],
          //   ),
          // ),
        ),
      )
    );
  }
}

