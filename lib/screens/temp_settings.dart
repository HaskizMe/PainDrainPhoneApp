import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:pain_drain_mobile_app/scheme_colors/app_colors.dart';
import 'package:pain_drain_mobile_app/ble/bluetooth_controller.dart';
import 'package:get/get.dart';
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
  final Duration writeDelay = const Duration(milliseconds: 500);
  Timer? writeTimer;
  Queue<Map<String, dynamic>> writeQueue = Queue<Map<String, dynamic>>();
  bool isWriting = false;


  // Create a function to handle the slider change with debounce
  void handleSliderChange(double newValue) async {
    Map<String, dynamic> writeOperation = {
      'newValue': newValue,
    };
    setState(() {
      globalValues.setSliderValue(globalValues.temperature, newValue);
    });

    // Restarts timer when slider value changes
    writeTimer?.cancel();
    /*
    * Only sends a value if the slider has paused for at
    * least 1 second so we aren't sending a of unnecessary values.
    */
    writeTimer = Timer(writeDelay, () async {
      writeQueue.add(writeOperation);
      if (!isWriting) {
        // Dequeue and execute the next operation
        executeNextWriteOperation();
      }
    });

  }

  void executeNextWriteOperation() async {
    if (writeQueue.isNotEmpty) {
      isWriting = true;
      writeQueue.removeFirst();

      String stringCommand = "t ${globalValues.getSliderValue(globalValues.temperature).round()}";

      List<int> hexValue = bluetoothController.stringToHexList(stringCommand);
      print('Value: $stringCommand');
      print('list hex values $hexValue');
      await bluetoothController.writeToDevice('tens', hexValue);
      readValueList = await bluetoothController.readFromDevice();

      // Update readValue
      setState(() {
        readValue = bluetoothController.hexToString(readValueList);
      });

      isWriting = false;

      // Execute the next write operation in the queue
      executeNextWriteOperation();
    }
  }
  @override
  void dispose() {
    writeTimer?.cancel(); // Cancel the timer when the widget is disposed.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double temperatureSliderValue = globalValues.getSliderValue(globalValues.temperature);
    return Scaffold(
      backgroundColor: AppColors.darkGrey,
      appBar: AppBar(
        title: const Text(
          'Temperature',
          style: TextStyle(
            fontSize: 50,
            color: AppColors.offWhite
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.darkerGrey,
        centerTitle: true,
        //toolbarHeight: 90,
      ),
      body: Align(
        alignment: const Alignment(0, -.25),
        child: SingleChildScrollView(
          child: SliderTheme(
            data: const SliderThemeData(
              trackHeight: 50,
              activeTrackColor: Colors.blue, // Color of the active portion of the track
              inactiveTrackColor: Colors.grey, // Color of the inactive portion of the track
              thumbColor: Colors.blue, // Color of the thumb
              tickMarkShape: RoundSliderTickMarkShape(
                  tickMarkRadius: 0
              ),
              thumbShape: RoundSliderThumbShape(
                enabledThumbRadius: 30.0, // Adjust the radius as needed
              ),// Make ticks invisible
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    elevation: 2.0,
                    color: AppColors.darkerGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)
                    ),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * .6,
                      //color: Colors.pink,
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 5),
                              //color: Colors.green,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: _max.abs().round(),
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(30),
                                            topLeft: Radius.circular(30)
                                          ),
                                          child: Container(
                                            //height: 100,
                                            width: 50,
                                            color: AppColors.offWhite,
                                            child: RotatedBox(
                                              quarterTurns: -1,
                                              child: LinearProgressIndicator(
                                                value: temperatureSliderValue / _max,
                                                color: Colors.red,
                                                backgroundColor: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: _min.abs().round(),
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                            bottomRight: Radius.circular(30),
                                            bottomLeft: Radius.circular(30)
                                          ),
                                          child: Container(
                                            //height: 100,
                                            width: 50,
                                            color: Colors.red,
                                            child: RotatedBox(
                                              quarterTurns: -1,
                                              child: LinearProgressIndicator(
                                                value: 1 - temperatureSliderValue / _min,
                                                color: Colors.grey,
                                                backgroundColor: Colors.blue,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  RotatedBox(
                                      quarterTurns: -1,
                                      child: Slider(
                                        value: temperatureSliderValue,
                                        min: _min,
                                        max: _max,
                                        activeColor: Colors.transparent,
                                        inactiveColor: Colors.transparent,
                                        thumbColor: temperatureSliderValue == 0 ? Colors.grey : temperatureSliderValue > 0 ? Colors.red : Colors.blue,
                                        divisions: ((_min.abs() + _max.abs())/5).round(),
                                        //label: temperatureSliderValue.round().toString(),
                                        onChanged: (double newValue){
                                          setState(() {
                                            handleSliderChange(newValue);
                                          });
                                        },
                                      ),
                                  ),
                                  Center(
                                    child: IgnorePointer(
                                      ignoring: true,
                                      child: Text(
                                        '${temperatureSliderValue.round()}%',
                                        style: const TextStyle(
                                          color: AppColors.offWhite,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Adjust Temperature',
                            style: TextStyle(
                              color: AppColors.offWhite,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                              onPressed: () {
                                handleSliderChange(0);
                              },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)
                              ),
                              backgroundColor: Colors.blue
                            ),
                              child: const Text(
                                "Turn Off",
                                style: TextStyle(
                                  color: Colors.white
                                ),
                              ),
                          ),
                          const SizedBox(height: 20,),
                        ],
                      ),
                    ),
                  ),
                  // const SizedBox(height: 10),
                  // if(readValue.isNotEmpty)
                  //   Text(
                  //     readValue,
                  //     style: const TextStyle(
                  //       color: AppColors.offWhite,
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 20,
                  //     ),
                  //   ),
                ],
              ),
            ),
        ),
    ),
      ),
    );
  }
}
