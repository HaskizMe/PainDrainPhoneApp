import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pain_drain_mobile_app/global_values.dart';
import 'package:pain_drain_mobile_app/scheme_colors/app_colors.dart';
import 'package:pain_drain_mobile_app/ble/bluetooth_controller.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import '../main.dart';
import '../widgets/custom_channel_widget.dart';



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
  void handleSliderChange(var newValue, String stimulus, int channel) async {
    // Makes changes to channel 1
    if(channel == 1){
      setState(() {

        if(stimulus == 'tensDuration'){
          globalValues.setSliderValue('tensDurationCh1', newValue);
        }
        else if(stimulus == 'tensAmplitude'){
          globalValues.setSliderValue('tensAmplitudeCh1', newValue);
        }
        else if(stimulus == 'tensPeriod'){
          globalValues.setSliderValue('tensPeriodCh1', newValue);
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
        String stringCommand = "T ${globalValues.getSliderValue('tensAmplitudeCh1')} ${globalValues.getSliderValue('tensDurationCh1')} ${globalValues.getSliderValue('tensPeriodCh1')} $channel";
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
    // Makes changes to channel 2
    else if(channel == 2){
      setState(() {
        if(stimulus == 'tensDuration'){
          globalValues.setSliderValue('tensDurationCh2', newValue);
        }
        else if(stimulus == 'tensAmplitude'){
          globalValues.setSliderValue('tensAmplitudeCh2', newValue);
        }
        else if(stimulus == 'tensPeriod'){
          globalValues.setSliderValue('tensPeriodCh2', newValue);
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
        String stringCommand = "T ${globalValues.getSliderValue('tensAmplitudeCh2')} ${globalValues.getSliderValue('tensDurationCh2')} ${globalValues.getSliderValue('tensPeriodCh2')} $channel";
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
    int channel1 = 1;
    int channel2 = 2;
    if(newValue == false){
      globalValues.setSliderValue('tensPhase', 0);
    }
    else if(newValue = true){
      globalValues.setSliderValue('tensPhase', 180);
    }
    else {
      print("ERROR");
    }
    setState(() {
      phaseValue = newValue;
    });
    print('Phase value ${globalValues.getSliderValue("tensPhase")}');
    // When phase changes it sends channel 1 values
    String stringCommand = "T p ${globalValues.getSliderValue("tensPhase")}";
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
    double sliderValuePeriodChannel1 = globalValues.getSliderValue('tensPeriodCh1');
    double sliderValueDurationChannel1 = globalValues.getSliderValue('tensDurationCh1');
    double sliderValueAmplitudeChannel1 = globalValues.getSliderValue('tensAmplitudeCh1');
    double sliderValueAmplitudeChannel2 = globalValues.getSliderValue('tensAmplitudeCh2');
    double sliderValueDurationChannel2 = globalValues.getSliderValue('tensDurationCh2');
    double sliderValuePeriodChannel2 = globalValues.getSliderValue('tensPeriodCh2');
    double sliderValuePhase = globalValues.getSliderValue('tensPhase');
    if(sliderValuePhase == 0){
       phaseValue = false;
    }
    else{
      phaseValue = true;
    }

    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.all(35.0),
          child: const Text(
            'TENS',
            style: TextStyle(
              color: Colors.white,
              fontSize: 50,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[900],
        centerTitle: true,
        //toolbarHeight: 50,
      ),
      body: SliderTheme(
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
          height: MediaQuery.of(context).size.height,
          //color: Colors.green,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    "Channel 1",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
             // SizedBox(height: 15,),
              ChannelWidget(
                  sliderValuePeriod: sliderValuePeriodChannel1,
                  sliderValueDuration: sliderValueDurationChannel1,
                  sliderValueAmplitude: sliderValueAmplitudeChannel1,
                  handleSliderChange: handleSliderChange,
                  //height: 260,
                  height: MediaQuery.of(context).size.height * .3,
                  width: MediaQuery.of(context).size.width * 1,
                  //color: Colors.green,
                  channel: 1,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Padding(
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
              ),
              ChannelWidget(
                  sliderValuePeriod: sliderValuePeriodChannel2,
                  sliderValueDuration: sliderValueDurationChannel2,
                  sliderValueAmplitude: sliderValueAmplitudeChannel2,
                  handleSliderChange: handleSliderChange,
                  //height: 260,
                  height: MediaQuery.of(context).size.height * .3,

                //width: 300,
                  width: MediaQuery.of(context).size.width * 1,
                  //color: Colors.pink,
                  channel: 2,
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 5.0, 10.0, 0.0),
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