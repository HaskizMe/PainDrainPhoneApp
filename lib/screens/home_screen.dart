import 'package:animated_icon/animate_icon.dart';
import 'package:animated_icon/animate_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pain_drain_mobile_app/controllers/bluetooth_controller.dart';
import 'package:pain_drain_mobile_app/controllers/stimulus_controller.dart';
import 'package:pain_drain_mobile_app/screens/onboarding.dart';
import 'package:pain_drain_mobile_app/custom_widgets/custom_text_field.dart';
import 'package:pain_drain_mobile_app/custom_widgets/drop_down_button.dart';
import 'package:pain_drain_mobile_app/custom_widgets/tens_summary.dart';
import 'package:pain_drain_mobile_app/custom_widgets/vibration_summary.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../controllers/presets_controller.dart';
import '../scheme_colors/app_colors.dart';
import '../custom_widgets/temperature_summary.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final SavedPresets _prefs = Get.find();
  final BluetoothController _bleController = Get.find();
  final StimulusController _stimulusController = Get.find();
  final TextEditingController _textController = TextEditingController();
  late AnimationController _controller;
  bool isAddingItem = false; // Track whether we are in "add" mode
  bool isLoading = false;
  double batteryLevel = 100;
  bool isCharging = false;
  Icon batteryIcon = const Icon(Icons.battery_full, color: Colors.green,);
  Color color = Colors.green;


  @override
  void initState() {
    //decrementBattery();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Duration for one complete cycle
    );
    super.initState();
  }

  decrementBattery() async {
    for(int i = 0; i < 100; i++){
      print("battery Level $batteryLevel");
      await Future.delayed(const Duration(milliseconds: 100));
      setState(() => batteryLevel--);
      if(batteryLevel == 0){
        setState(() => isCharging = !isCharging);
        await Future.delayed(const Duration(seconds: 5));
        setState(() => isCharging = !isCharging);

      }
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void showErrorDialog() {
    if(_prefs.getCurrentPreset() != null) {
      showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              title: Text("Are you sure you want to delete preset '${_prefs.getCurrentPreset()}'?"),
              actions: [
                ElevatedButton(
                    onPressed: () => Get.back(),
                    child: const Text("Cancel", style: TextStyle(color: Colors.black),)
                ),
                ElevatedButton(
                    onPressed: handleDeleteButton,
                    child: const Text("Delete", style: TextStyle(color: Colors.red),)
                )
              ],
            );
          }
      );
    }
  }

  void handleDeleteButton() {
    Get.back();
    List<String>? presets = _prefs.getPresets();
    String? selectedPreset = _prefs.getCurrentPreset();
    if(presets != null) {
      print("selected Item: $selectedPreset");
      _prefs.deletePreset(selectedPreset!);
      if(presets.isNotEmpty) {
        // Find the index of the selected item
        int selectedIndex = presets.indexOf(selectedPreset);
        // Select the next index in the list (circular, looping back to the beginning if at the end)
        int nextIndex = (selectedIndex + 1) % presets.length;
        // Set the selectedItem to the item at the next index
        selectedPreset = presets[nextIndex];
        _prefs.setCurrentPreset(selectedPreset);
      }
    }
    setState(() {
      presets = _prefs.getPresets();
      selectedPreset = _prefs.getCurrentPreset();
    });
    print("new selected Item: $selectedPreset");

    print(presets);
  }

  void _handleAddButtonPress(String newValue) {
    print(newValue);
    //newValue = "preset.$newValue";
    _prefs.addNewPreset(newValue);
    _prefs.setCurrentPreset(newValue);
    setState(() {
     _textController.clear();
     isAddingItem = !isAddingItem;
    });
  }

  void _hideTextField() {
    setState(() => isAddingItem = !isAddingItem);
  }

  Future<void> _handleLoadPreset() async {
    setState(() {
      isLoading = true;
    });
    _controller.repeat();
    String? selectedPreset = _prefs.getCurrentPreset();

    if(selectedPreset != null){
      String command;
      _prefs.loadPreset(_prefs.getCurrentPreset()!);
      command = _bleController.getCommand("tens");
      await _bleController.newWriteToDevice(command);
      command = _bleController.getCommand("phase");
      await _bleController.newWriteToDevice(command);
      command = _bleController.getCommand("temperature");
      await _bleController.newWriteToDevice(command);
      command = _bleController.getCommand("vibration");
      await _bleController.newWriteToDevice(command);
    }
    _controller.stop();
    _controller.reset();
    setState(() {
      isLoading = false;
    });
  }

  void _updateProgress () => setState(() {});

  @override
  Widget build(BuildContext context) {
    if(batteryLevel > 99){
      batteryIcon = const Icon(Icons.battery_full, color: Colors.green,);
    } else if(batteryLevel > 85){
      batteryIcon = const Icon(Icons.battery_6_bar_rounded, color: Colors.green,);
    } else if(batteryLevel > 65){
      batteryIcon = const Icon(Icons.battery_5_bar_rounded, color: Colors.green,);
    } else if(batteryLevel > 50){
      batteryIcon = const Icon(Icons.battery_4_bar_rounded, color: Colors.green,);
    } else if(batteryLevel > 35){
      batteryIcon = const Icon(Icons.battery_3_bar_rounded, color: Colors.green,);
    } else if(batteryLevel > 25){
      batteryIcon = Icon(Icons.battery_2_bar_rounded, color: Colors.yellow.shade900,);
    } else if(batteryLevel > 15){
      batteryIcon = Icon(Icons.battery_1_bar_rounded, color: Colors.red.shade700,);
    } else if(batteryLevel == 0){
      batteryIcon = Icon(Icons.battery_0_bar_rounded, color: Colors.red.shade700,);
    }
    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.offWhite,
          appBar: AppBar(
            leading: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Get.to(() => const OnBoarding());
                    },
                    icon: Icon(Icons.help_outline_rounded, color: Colors.grey.shade400,)
                ),
              ],
            ),
            title: const Text(
              'Stimulus',
              style: TextStyle(
                  fontSize: 40,
                  color: Colors.white
              ),
            ),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.blue.shade800,
            centerTitle: true,
            actions: [
              Obx(() => _bleController.isCharging.value
                  ? const Icon(Icons.battery_charging_full_rounded, color: Colors.green,)
                  : batteryIcon),
              Text("${batteryLevel.toInt()}%", style: const TextStyle(color: Colors.white),),
              const SizedBox(width: 10.0,)
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          DropDownBox(selectedItem: _prefs.getCurrentPreset(), items: _prefs.getPresets(), widthSize: 200, dropDownCategory: 'presets',),
                          const SizedBox(width: 2.0,),
                          IconButton(
                            icon: const Icon(
                              Icons.add,
                              color: Colors.black, // Change the icon color if needed
                              size: 25.0,
                            ),
                            onPressed: () {
                              setState(() {
                                isAddingItem = !isAddingItem;
                              });
                            },
                          ),
                          IconButton(
                            icon: RotationTransition(
                              turns: Tween(begin: 0.0, end: -1.0).animate(_controller),
                              child: const Icon(
                                Icons.sync,
                                color: Colors.black,
                                size: 25.0,
                              ),
                            ),
                            onPressed: () {
                              if(!isLoading) {
                                print("Is not loading");
                                _handleLoadPreset();
                              }
                            },
                          ),
                          IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red, // Change the icon color if needed
                                size: 25.0,
                              ),
                              onPressed: showErrorDialog
                          ),
                        ],
                      ),

                      Visibility(
                        visible: isAddingItem,
                        child: Column(
                          children: [
                            const SizedBox(height: 30.0,),
                            Align(
                              alignment: Alignment.center,
                              child: CustomTextField(
                                textController: _textController,
                                onTextFieldChange: _handleAddButtonPress,
                                hideTextField: _hideTextField,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20.0,),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text("TENS", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                      ),
                      const SizedBox(height: 5.0,),
                      TensSummary(update: _updateProgress,),
                      const SizedBox(height: 10.0,),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text("TEMPERATURE", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                      ),
                      const SizedBox(height: 5.0,),
                      TemperatureSummary(update: _updateProgress,),
                      const SizedBox(height: 10.0,),
                      const Align(

                        alignment: Alignment.centerLeft,
                        child: Text("VIBRATION", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                      ),
                      const SizedBox(height: 5.0,),
                      VibrationSummary(update: _updateProgress,),
                      const SizedBox(height: 10.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text("Debug Dev Info:"),
                          const SizedBox(width: 10.0,),
                          const Text("OFF"),

                          Switch(
                            value: _prefs.getDevControls(),
                            onChanged: (bool value) async {
                              setState(() {
                                _prefs.setDevControls(value);
                              });
                            },
                          ),
                          const Text("ON"),

                        ],
                      ),
                      if(_prefs.getDevControls())
                        Column(
                          children: [
                            Text("Tens: ${_stimulusController.readTens}", style: const TextStyle(fontSize: 18),),
                            Text("phase: ${_stimulusController.readPhase}", style: const TextStyle(fontSize: 18)),
                            Text("temperature: ${_stimulusController.readTemp}", style: const TextStyle(fontSize: 18)),
                            Text("Vibration: ${_stimulusController.readVibe}", style: const TextStyle(fontSize: 18)),
                            const SizedBox(height: 10.0,),
                            ElevatedButton(
                                onPressed: () {
                                  setState(() {});
                                },
                                child: const Text("Refresh")
                            ),
                            const SizedBox(height: 20.0,),
                            // ElevatedButton(
                            //     onPressed: () async {
                            //       await _bleController.newWriteToDevice("B 0");
                            //     },
                            //     child: const Text("Not Charging")
                            // ),
                            // ElevatedButton(
                            //     onPressed: () async {
                            //       await _bleController.newWriteToDevice("B 1");
                            //     },
                            //     child: const Text("Charging")
                            // ),
                            ElevatedButton(
                                onPressed: () async {
                                  await _bleController.newWriteToDevice("B 2");
                                },
                                child: const Text("Fully Charged")
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  await _bleController.newWriteToDevice("B 3");
                                },
                                child: const Text("Low Battery")
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  await _bleController.newWriteToDevice("B 4");
                                },
                                child: const Text("Medium Battery")
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  await _bleController.newWriteToDevice("B 5");
                                },
                                child: const Text("Normal Operation")
                            ),
                            // ElevatedButton(
                            //     onPressed: () async {
                            //       await _bleController.newWriteToDevice("B 6");
                            //     },
                            //     child: const Text("Warning")
                            // ),
                            // ElevatedButton(
                            //     onPressed: () async {
                            //       await _bleController.newWriteToDevice("B 7");
                            //     },
                            //     child: const Text("Advertising")
                            // ),
                            // ElevatedButton(
                            //     onPressed: () async {
                            //       await _bleController.newWriteToDevice("B 8");
                            //     },
                            //     child: const Text("Connected")
                            // ),
                            const SizedBox(height: 20.0,),
                            ElevatedButton(
                                onPressed: () async {
                                  await _bleController.disconnectDevice();
                                },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red
                              ),
                                child: const Text("Disconnect Device", style: TextStyle(color: Colors.white),),
                            ),
                            const SizedBox(height: 10.0,),
                          ],
                        )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Obx(() => _bleController.showChargingAnimation.value
            ? ChargingAnimation(batteryLevel: batteryLevel,)
            : const SizedBox.shrink()),
      ],
    );
  }
}

class ChargingAnimation extends StatefulWidget {
  final double batteryLevel;
  const ChargingAnimation({Key? key, required this.batteryLevel}) : super(key: key);

  @override
  State<ChargingAnimation> createState() => _ChargingAnimationState();
}

class _ChargingAnimationState extends State<ChargingAnimation> {


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 170,
                height: 170,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(150)
                ),
                child:
                CircularPercentIndicator(
                  radius: 70.0,
                  animation: true,
                  lineWidth: 10.0,
                  animationDuration: 3000,
                  animateFromLastPercent: true,
                  circularStrokeCap: CircularStrokeCap.round,
                  percent: widget.batteryLevel / 100,
                  arcType: ArcType.FULL,
                  linearGradient: LinearGradient(colors: [Colors.green, Colors.green.shade700]),
                  center: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AnimateIcon(
                          onTap: () {},
                          iconType: IconType.continueAnimation,
                          height: 60,
                          width: 60,
                          color: Colors.white,
                          animateIcon: AnimateIcons.battery,
                        ),
                        Text("${widget.batteryLevel.toInt()}%", style: const TextStyle(color: Colors.white, fontSize: 18),),
                      ]
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}