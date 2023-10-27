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
                //color: Colors.black,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20,),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.45,
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
                                    color: Colors.white,
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
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
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
      ),
    );
  }
}
