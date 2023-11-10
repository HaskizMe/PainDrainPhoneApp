import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pain_drain_mobile_app/ble/bluetooth_controller.dart';
import 'package:get/get.dart';
import '../main.dart';
import '../widgets/custom_card.dart';
import '../widgets/custom_slider.dart';



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


  // Create a function to handle the slider change
  void handleSliderChange(var newValue, String stimulus, [int? channel]) async {
    // Makes changes to channel 1
    if(channel == 1 || channel == 0){
      setState(() {

        if(stimulus == 'tensDurationCh1'){
          globalValues.setSliderValue(globalValues.tensDurationCh1, newValue);
        }
        else if(stimulus == 'tensAmplitude'){
          globalValues.setSliderValue(globalValues.tensAmplitude, newValue);
        }
        else if(stimulus == 'tensPeriod'){
          globalValues.setSliderValue(globalValues.tensPeriod, newValue);
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
        String stringCommand = "T ${globalValues.getSliderValue(globalValues.tensAmplitude)} ${globalValues.getSliderValue(globalValues.tensDurationCh1)} ${globalValues.getSliderValue(globalValues.tensPeriod)} $channel";
        List<int> hexValue = bluetoothController.stringToHexList(stringCommand);
        print('Value: $stringCommand');
        print('list hex values $hexValue');
        await bluetoothController.writeToDevice('tens', hexValue);
        readValueList = await bluetoothController.readFromDevice();

        // Update readValue
        setState(() {
          readValue = bluetoothController.hexToString(readValueList); // Replace with your actual value
        });
      });
    }
    // Makes changes to channel 2
    else if(channel == 2){
      setState(() {
        if(stimulus == 'tensDurationCh2'){
          globalValues.setSliderValue(globalValues.tensDurationCh2, newValue);
        }
        else if(stimulus == 'tensAmplitude'){
          globalValues.setSliderValue(globalValues.tensAmplitude, newValue);
        }
        else if(stimulus == 'tensPeriod'){
          globalValues.setSliderValue(globalValues.tensPeriod, newValue);
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
        String stringCommand = "T ${globalValues.getSliderValue(globalValues.tensAmplitude)} ${globalValues.getSliderValue(globalValues.tensDurationCh2)} ${globalValues.getSliderValue(globalValues.tensPeriod)} $channel";
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
      });
    }
    else{
      print("ERROR");
    }


  }

  bool phaseValue = false;

  void onSwitchChanged(bool newValue) async {
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
    print('Phase value ${globalValues.getSliderValue(globalValues.tensPhase)}');
    // When phase changes it sends channel 1 values
    String stringCommand = "T p ${globalValues.getSliderValue(globalValues.tensPhase)}";
    List<int> hexValue = bluetoothController.stringToHexList(stringCommand);
    print('Value: $stringCommand');
    print('list hex values $hexValue');
    await bluetoothController.writeToDevice('tens', hexValue);
    readValueList = await bluetoothController.readFromDevice();

    setState(() {
      readValue = bluetoothController.hexToString(readValueList);
    });
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
        min: 0.1,
        max: 1.0,
        divisions: 9,
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
        min: 0.1,
        max: 1.0,
        divisions: 9,
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
        //toolbarHeight: 50,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          //color: Colors.green,
          child: Column(
            children: [
              CustomCard(
                  height: MediaQuery.of(context).size.height * .3,
                  width: MediaQuery.of(context).size.width * 1,
                  sliders: topSliders,
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
                            color: Colors.white,
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
                              color: Colors.white,
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
                        height: MediaQuery.of(context).size.height * .3,
                        width: MediaQuery.of(context).size.width * .4,
                        sliders: bottomSliderLeft
                    ),
                  ),
                  Expanded(
                    child: CustomCard(
                        height: MediaQuery.of(context).size.height * .3,
                        width: MediaQuery.of(context).size.width * .4,
                        sliders: bottomSliderRight
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
                            color: Colors.white
                          ),
                        ),
                        const SizedBox(width: 15,),
                        Transform.scale(
                          scale: 2.0,
                          child: Switch(
                            value: phaseValue,
                            onChanged: onSwitchChanged,
                            activeColor: Colors.blue, // Color when switch is ON
                            inactiveTrackColor: Colors.grey, // Color of the inactive track
                            inactiveThumbColor: Colors.grey, // Color of the switch's thumb when OFF
                          ),
                        ),
                        const SizedBox(width: 15,),
                        const Text(
                          '180',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white
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
      )
    );
  }
}