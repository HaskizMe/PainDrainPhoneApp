import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:pain_drain_mobile_app/controllers//bluetooth_controller.dart';
import 'package:get/get.dart';
import '../main.dart';
import '../widgets/custom_card.dart';
import '../widgets/custom_slider.dart';
import 'package:pain_drain_mobile_app/scheme_colors/app_colors.dart';



class TENSSettings extends StatefulWidget with WidgetsBindingObserver {
  const TENSSettings({Key? key}) : super(key: key);

  @override
  State<TENSSettings> createState() => _TENSSettingsState();
}

class _TENSSettingsState extends State<TENSSettings> with WidgetsBindingObserver {

  final BluetoothController bluetoothController = Get.find<BluetoothController>();
  List<int> readValueList = [];
  String readValue = "";
  final Duration writeDelay = const Duration(milliseconds: 500);
  Timer? writeTimer;
  Queue<Map<String, dynamic>> writeQueue = Queue<Map<String, dynamic>>();
  bool isWriting = false;
  bool phaseValue = false;

  void handleSliderChange(var newValue, String? stimulus, int? channel) async {
    Map<String, dynamic> writeOperation = {
      'newValue': newValue,
      'stimulus': stimulus,
      'channel': channel,
    };

    if(channel == 1 || channel == 0) {
      setState(() {
        if (stimulus == 'tensDurationCh1') {
          globalValues.setSliderValue(globalValues.tensDurationCh1, newValue);
        }
        else if (stimulus == 'tensAmplitude') {
          globalValues.setSliderValue(globalValues.tensAmplitude, newValue);
        }
        else if (stimulus == 'tensPeriod') {
          globalValues.setSliderValue(globalValues.tensPeriod, newValue);
        }
      });
    }
    else if(channel == 2) {
      setState(() {
        if (stimulus == 'tensDurationCh2') {
          globalValues.setSliderValue(globalValues.tensDurationCh2, newValue);
        }
        else if (stimulus == 'tensAmplitude') {
          globalValues.setSliderValue(globalValues.tensAmplitude, newValue);
        }
        else if (stimulus == 'tensPeriod') {
          globalValues.setSliderValue(globalValues.tensPeriod, newValue);
        }
      });
    }
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
    print('queue $writeQueue');
    String stringCommand = "";
    if (writeQueue.isNotEmpty) {
      isWriting = true;
      Map<String, dynamic> writeOperation = writeQueue.removeFirst();

      int? channel = writeOperation['channel'];
      bool? value = writeOperation['newBool'];
      //print('new value write operation $newValue');

      if(value != null){
        stringCommand = "T p ${globalValues.getSliderValue(globalValues.tensPhase)}";
      }
      else if(channel == 1 || channel == 0){
        stringCommand = "T ${globalValues.getSliderValue(globalValues.tensAmplitude)} ${globalValues.getSliderValue(globalValues.tensDurationCh1)} ${globalValues.getSliderValue(globalValues.tensPeriod)} $channel";
      }
      else if(channel == 2){
        stringCommand = "T ${globalValues.getSliderValue(globalValues.tensAmplitude)} ${globalValues.getSliderValue(globalValues.tensDurationCh2)} ${globalValues.getSliderValue(globalValues.tensPeriod)} $channel";
      }
      else{
        print("ERROR");
      }

      // stringCommand = "T p ${globalValues.getSliderValue(globalValues.tensPhase)}";
      List<int> hexValue = bluetoothController.stringToHexList(stringCommand);
      print('Value: $stringCommand');
      print('list hex values $hexValue');
      await bluetoothController.writeToDevice('tens', hexValue);
      readValueList = await bluetoothController.readFromDevice();

      // Update readValue
      setState(() {
        readValue = bluetoothController.hexToString(readValueList); // Replace with your actual value
      });

      isWriting = false;

      // Execute the next write operation in the queue
      executeNextWriteOperation();
    }
  }


  void onSwitchChanged(bool newValue) async {
    Map<String, dynamic> writeOperation = {
      'newBool': newValue,
    };
    if(newValue == false){
      globalValues.setSliderValue(globalValues.tensPhase, 0);
    }
    else if(newValue = true){
      globalValues.setSliderValue(globalValues.tensPhase, 180);
    }
    else {
      print("ERROR");
    }
    setState(() {
      phaseValue = newValue;
    });
    writeQueue.add(writeOperation);
    if (!isWriting) {
      // Dequeue and execute the next operation
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
    double sliderValuePeriod = globalValues.getSliderValue(globalValues.tensPeriod);
    double sliderValueDurationChannel1 = globalValues.getSliderValue(globalValues.tensDurationCh1);
    double sliderValueAmplitude = globalValues.getSliderValue(globalValues.tensAmplitude);
    double sliderValueDurationChannel2 = globalValues.getSliderValue(globalValues.tensDurationCh2);
    double sliderValuePhase = globalValues.getSliderValue(globalValues.tensPhase);
    // The two sliders I want in the top portion
    List<Widget> topSliders = [
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
        sliderName: globalValues.tensAmplitude,
        sliderLabel: 'Amplitude',
        valueLabel: "${sliderValueAmplitude.round()}%",
        channel: 0,
      ),
      CustomSlider(
        min: 0.5,
        max: 10,
        divisions: (10.0 - 0.5) ~/ 0.5,
        // divisions: 10,
        handleSliderChange: handleSliderChange,
        value: sliderValuePeriod,
        trackHeight: 50.0,
        activeTrackColor: Colors.blue,
        inactiveTrackColor: Colors.grey,
        thumbColor: Colors.blue,
        thumbRadius: 30.0,
        sliderName: "tensPeriod",
        sliderLabel: 'Period',
        valueLabel: "${sliderValuePeriod}s",
        channel: 0,
      ),
      // You can add more sliders here
    ];

    // Slider that I want in the bottom left
    List<Widget> bottomSliderLeft = [
      CustomSlider(
        min: 0,
        max: 1.0,
        divisions: 10,
        handleSliderChange: handleSliderChange,
        value: sliderValueDurationChannel1,
        trackHeight: 50.0,
        activeTrackColor: Colors.blue,
        inactiveTrackColor: Colors.grey,
        thumbColor: Colors.blue,
        thumbRadius: 30.0,
        sliderName: globalValues.tensDurationCh1,
        sliderLabel: 'Duration',
        valueLabel: "${sliderValueDurationChannel1}s",
        channel: 1,
      ),
      // You can add more sliders here
    ];
    // Slider that I want in the bottom right
    List<Widget> bottomSliderRight = [
      CustomSlider(
        min: 0,
        max: 1.0,
        divisions: 10,
        handleSliderChange: handleSliderChange,
        value: sliderValueDurationChannel2,
        trackHeight: 50.0,
        activeTrackColor: Colors.blue,
        inactiveTrackColor: Colors.grey,
        thumbColor: Colors.blue,
        thumbRadius: 30.0,
        sliderName: globalValues.tensDurationCh2,
        sliderLabel: 'Duration',
        valueLabel: "${sliderValueDurationChannel2}s",
        channel: 2,
      ),
    ];
    if(sliderValuePhase == 0){
       phaseValue = false;
    }
    else{
      phaseValue = true;
    }

    return Scaffold(
      backgroundColor: AppColors.darkGrey,
      appBar: AppBar(
        title: const Text(
          'TENS',
          style: TextStyle(
            color: AppColors.offWhite,
            fontSize: 50,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.darkerGrey,
        centerTitle: true,
        //toolbarHeight: 50,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                CustomCard(
                    width: MediaQuery.of(context).size.width,
                    widgets: topSliders,
                ),
                const Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Channel 1",
                            style: TextStyle(
                              color: AppColors.offWhite,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text(
                              "Channel 2",
                              style: TextStyle(
                                color: AppColors.offWhite,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomCard(
                          width: MediaQuery.of(context).size.width * .4,
                          widgets: bottomSliderLeft,
                      ),
                    ),
                    Expanded(
                      child: CustomCard(
                          width: MediaQuery.of(context).size.width * .4,
                          widgets: bottomSliderRight
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(
                            '0',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: AppColors.offWhite
                            ),
                          ),
                          const SizedBox(width: 15,),
                          Transform.scale(
                            scale: 1.2,
                            child: Switch(
                              value: phaseValue,
                              onChanged: onSwitchChanged,
                              activeColor: Colors.blue, // Color when switch is ON
                              inactiveTrackColor: Colors.grey, // Color of the inactive track
                              inactiveThumbColor: Colors.blue, // Color of the switch's thumb when OFF
                            ),
                          ),
                          const SizedBox(width: 15,),
                          const Text(
                            '180',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: AppColors.offWhite
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    if(readValue.isNotEmpty)
                      Text(
                        readValue,
                        style: const TextStyle(
                          color: AppColors.offWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      )
    );
  }
}