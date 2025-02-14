// import 'package:animated_icon/animate_icon.dart';
// import 'package:animated_icon/animate_icons.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:get/get.dart';
// import 'package:pain_drain_mobile_app/models/bluetooth.dart';
// import 'package:pain_drain_mobile_app/models/stimulus.dart';
// import 'package:pain_drain_mobile_app/providers/current_preset_notifier.dart';
// import 'package:pain_drain_mobile_app/providers/preset_list_notifier.dart';
// import 'package:pain_drain_mobile_app/providers/temperature_notifier.dart';
// import 'package:pain_drain_mobile_app/providers/tens_notifier.dart';
// import 'package:pain_drain_mobile_app/providers/vibration_notifier.dart';
// import 'package:pain_drain_mobile_app/screens/home/local_widgets/onboarding.dart';
// import 'package:pain_drain_mobile_app/utils/globals.dart';
// import 'package:pain_drain_mobile_app/widgets/custom_text_field.dart';
// import 'package:pain_drain_mobile_app/widgets/drop_down_button.dart';
// import 'package:pain_drain_mobile_app/widgets/tens_summary.dart';
// import 'package:pain_drain_mobile_app/widgets/vibration_summary.dart';
// import 'package:percent_indicator/circular_percent_indicator.dart';
// import '../../models/preset.dart';
// import '../../models/presets.dart';
// import '../../utils/app_colors.dart';
// import '../../widgets/temperature_summary.dart';
//
//
// class HomeScreen extends ConsumerStatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   ConsumerState<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends ConsumerState<HomeScreen> with SingleTickerProviderStateMixin {
//   final Presets _prefs = Get.find();
//   final Bluetooth _bleController = Get.find();
//   final Stimulus _stimulusController = Get.find();
//   final TextEditingController _textController = TextEditingController();
//   late AnimationController _controller;
//   bool isAddingItem = false; // Track whether we are in "add" mode
//   bool isLoading = false;
//   double batteryLevel = 100;
//   bool isCharging = false;
//   Icon batteryIcon = const Icon(Icons.battery_full, color: Colors.green,);
//   Color color = Colors.green;
//
//
//   @override
//   void initState() {
//     //decrementBattery();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2), // Duration for one complete cycle
//     );
//     super.initState();
//   }
//
//   decrementBattery() async {
//     for(int i = 0; i < 100; i++){
//       print("battery Level $batteryLevel");
//       await Future.delayed(const Duration(milliseconds: 100));
//       setState(() => batteryLevel--);
//       if(batteryLevel == 0){
//         setState(() => isCharging = !isCharging);
//         await Future.delayed(const Duration(seconds: 5));
//         setState(() => isCharging = !isCharging);
//
//       }
//     }
//   }
//
//   @override
//   void dispose() {
//     _textController.dispose();
//     _controller.dispose();
//     super.dispose();
//   }
//
//   void showErrorDialog() {
//     if(_prefs.getCurrentPreset() != null) {
//       showDialog(
//           context: context,
//           builder: (BuildContext context){
//             return AlertDialog(
//               title: Text("Are you sure you want to delete preset '${_prefs.getCurrentPreset()}'?"),
//               actions: [
//                 ElevatedButton(
//                     onPressed: () => Get.back(),
//                     child: const Text("Cancel", style: TextStyle(color: Colors.black),)
//                 ),
//                 ElevatedButton(
//                     onPressed: handleDeleteButton,
//                     child: const Text("Delete", style: TextStyle(color: Colors.red),)
//                 )
//               ],
//             );
//           }
//       );
//     }
//   }
//
//   void handleDeleteButton() {
//     Get.back();
//     List<String>? presets = _prefs.getPresets();
//     String? selectedPreset = _prefs.getCurrentPreset();
//     if(presets != null) {
//       print("selected Item: $selectedPreset");
//       _prefs.deletePreset(selectedPreset!);
//       if(presets.isNotEmpty) {
//         // Find the index of the selected item
//         int selectedIndex = presets.indexOf(selectedPreset);
//         // Select the next index in the list (circular, looping back to the beginning if at the end)
//         int nextIndex = (selectedIndex + 1) % presets.length;
//         // Set the selectedItem to the item at the next index
//         selectedPreset = presets[nextIndex];
//         _prefs.setCurrentPreset(selectedPreset);
//       }
//     }
//     setState(() {
//       presets = _prefs.getPresets();
//       selectedPreset = _prefs.getCurrentPreset();
//     });
//     print("new selected Item: $selectedPreset");
//
//     print(presets);
//   }
//
//   void _handleAddButtonPress(String newValue) {
//     print(newValue);
//     //newValue = "preset.$newValue";
//     _prefs.addNewPreset(newValue);
//     _prefs.setCurrentPreset(newValue);
//     setState(() {
//      _textController.clear();
//      isAddingItem = !isAddingItem;
//     });
//   }
//
//   void _hideTextField() {
//     setState(() => isAddingItem = !isAddingItem);
//   }
//
//   Future<void> _handleLoadPreset() async {
//     setState(() {
//       isLoading = true;
//     });
//     _controller.repeat();
//     String? selectedPreset = _prefs.getCurrentPreset();
//
//     if(selectedPreset != null){
//       String command;
//       _prefs.loadPreset(_prefs.getCurrentPreset()!);
//       command = _bleController.getCommand("tens");
//       await _bleController.newWriteToDevice(command);
//       command = _bleController.getCommand("temperature");
//       await _bleController.newWriteToDevice(command);
//       command = _bleController.getCommand("vibration");
//       await _bleController.newWriteToDevice(command);
//     }
//     _controller.stop();
//     _controller.reset();
//     setState(() {
//       isLoading = false;
//     });
//   }
//
//   void _updateProgress () => setState(() {});
//
//   @override
//   Widget build(BuildContext context) {
//     final savedPresets = ref.watch(presetListNotifierProvider);
//     final tens = ref.watch(tensNotifierProvider);
//     final vibe = ref.watch(vibrationNotifierProvider);
//     final temp = ref.watch(temperatureNotifierProvider);
//
//
//     if(batteryLevel > 99){
//       batteryIcon = const Icon(Icons.battery_full, color: Colors.green,);
//     } else if(batteryLevel > 85){
//       batteryIcon = const Icon(Icons.battery_6_bar_rounded, color: Colors.green,);
//     } else if(batteryLevel > 65){
//       batteryIcon = const Icon(Icons.battery_5_bar_rounded, color: Colors.green,);
//     } else if(batteryLevel > 50){
//       batteryIcon = const Icon(Icons.battery_4_bar_rounded, color: Colors.green,);
//     } else if(batteryLevel > 35){
//       batteryIcon = const Icon(Icons.battery_3_bar_rounded, color: Colors.green,);
//     } else if(batteryLevel > 25){
//       batteryIcon = Icon(Icons.battery_2_bar_rounded, color: Colors.yellow.shade900,);
//     } else if(batteryLevel > 15){
//       batteryIcon = Icon(Icons.battery_1_bar_rounded, color: Colors.red.shade700,);
//     } else if(batteryLevel == 0){
//       batteryIcon = Icon(Icons.battery_0_bar_rounded, color: Colors.red.shade700,);
//     }
//
//
//     return Stack(
//       children: [
//         Scaffold(
//           backgroundColor: AppColors.offWhite,
//           appBar: AppBar(
//             leading: Row(
//               children: [
//                 IconButton(
//                     onPressed: () {
//                       Get.to(() => const OnBoarding());
//                     },
//                     icon: Icon(Icons.help_outline_rounded, color: Colors.grey.shade400,)
//                 ),
//               ],
//             ),
//             title: const Text(
//               'Pain Drain',
//               style: TextStyle(
//                   fontSize: 40,
//                   color: Colors.white
//               ),
//             ),
//             automaticallyImplyLeading: false,
//             backgroundColor: Colors.blue.shade800,
//             centerTitle: true,
//             // actions: [
//             //   Obx(() => _bleController.isCharging.value
//             //       ? const Icon(Icons.battery_charging_full_rounded, color: Colors.green,)
//             //       : batteryIcon),
//             //   Text("${batteryLevel.toInt()}%", style: const TextStyle(color: Colors.white),),
//             //   const SizedBox(width: 10.0,)
//             // ],
//           ),
//           body: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: Stack(
//                 children: [
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       const SizedBox(height: 20,),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           DropDownBox(selectedItem: _prefs.getCurrentPreset(), items: _prefs.getPresets(), widthSize: 200, dropDownCategory: 'presets',),
//                           const SizedBox(width: 2.0,),
//                           IconButton(
//                             icon: const Icon(
//                               Icons.add,
//                               color: Colors.black, // Change the icon color if needed
//                               size: 25.0,
//                             ),
//                             onPressed: () {
//                               setState(() {
//                                 isAddingItem = !isAddingItem;
//                               });
//                             },
//                           ),
//                           IconButton(
//                             icon: RotationTransition(
//                               turns: Tween(begin: 0.0, end: -1.0).animate(_controller),
//                               child: const Icon(
//                                 Icons.sync,
//                                 color: Colors.black,
//                                 size: 25.0,
//                               ),
//                             ),
//                             onPressed: () {
//                               if(!isLoading) {
//                                 _handleLoadPreset();
//                               }
//                             },
//                           ),
//                           IconButton(
//                               icon: const Icon(
//                                 Icons.delete,
//                                 color: Colors.red, // Change the icon color if needed
//                                 size: 25.0,
//                               ),
//                               onPressed: showErrorDialog
//                           ),
//                         ],
//                       ),
//
//                       Visibility(
//                         visible: isAddingItem,
//                         child: Column(
//                           children: [
//                             const SizedBox(height: 30.0,),
//                             Align(
//                               alignment: Alignment.center,
//                               child: CustomTextField(
//                                 textController: _textController,
//                                 onTextFieldChange: _handleAddButtonPress,
//                                 hideTextField: _hideTextField,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 20.0,),
//                       const Align(
//                         alignment: Alignment.centerLeft,
//                         child: Text("TENS", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
//                       ),
//                       const SizedBox(height: 5.0,),
//                       TensSummary(update: _updateProgress,),
//                       const SizedBox(height: 10.0,),
//                       const Align(
//                         alignment: Alignment.centerLeft,
//                         child: Text("TEMPERATURE", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
//                       ),
//                       const SizedBox(height: 5.0,),
//                       TemperatureSummary(update: _updateProgress,),
//                       const SizedBox(height: 10.0,),
//                       const Align(
//
//                         alignment: Alignment.centerLeft,
//                         child: Text("VIBRATION", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
//                       ),
//                       const SizedBox(height: 5.0,),
//                       VibrationSummary(update: _updateProgress,),
//                       const SizedBox(height: 10.0,),
//                       if(showDebugTools)
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             const Text("Debug Dev Info:"),
//                             const SizedBox(width: 10.0,),
//                             const Text("OFF"),
//
//                             Switch(
//                               value: _prefs.getDevControls(),
//                               onChanged: (bool value) async {
//                                 setState(() {
//                                   _prefs.setDevControls(value);
//                                 });
//                               },
//                             ),
//                             const Text("ON"),
//
//                           ],
//                         ),
//                       if(_prefs.getDevControls())
//                         Column(
//                           children: [
//                             Text("Tens: ${_stimulusController.readTens}", style: const TextStyle(fontSize: 18),),
//                             Text("phase: ${_stimulusController.readPhase}", style: const TextStyle(fontSize: 18)),
//                             Text("temperature: ${_stimulusController.readTemp}", style: const TextStyle(fontSize: 18)),
//                             Text("Vibration: ${_stimulusController.readVibe}", style: const TextStyle(fontSize: 18)),
//                             const SizedBox(height: 10.0,),
//                             ElevatedButton(
//                                 onPressed: () {
//                                   setState(() {});
//                                 },
//                                 child: const Text("Refresh")
//                             ),
//                             const SizedBox(height: 20.0,),
//                             // ElevatedButton(
//                             //     onPressed: () async {
//                             //       await _bleController.newWriteToDevice("B 0");
//                             //     },
//                             //     child: const Text("Not Charging")
//                             // ),
//                             // ElevatedButton(
//                             //     onPressed: () async {
//                             //       await _bleController.newWriteToDevice("B 1");
//                             //     },
//                             //     child: const Text("Charging")
//                             // ),
//                             ElevatedButton(
//                                 onPressed: () async {
//                                   await _bleController.newWriteToDevice("B 2");
//                                 },
//                                 child: const Text("Fully Charged")
//                             ),
//                             ElevatedButton(
//                                 onPressed: () async {
//                                   await _bleController.newWriteToDevice("B 3");
//                                 },
//                                 child: const Text("Low Battery")
//                             ),
//                             ElevatedButton(
//                                 onPressed: () async {
//                                   await _bleController.newWriteToDevice("B 4");
//                                 },
//                                 child: const Text("Medium Battery")
//                             ),
//                             ElevatedButton(
//                                 onPressed: () async {
//                                   await _bleController.newWriteToDevice("B 5");
//                                 },
//                                 child: const Text("Normal Operation")
//                             ),
//                             // ElevatedButton(
//                             //     onPressed: () async {
//                             //       await _bleController.newWriteToDevice("B 6");
//                             //     },
//                             //     child: const Text("Warning")
//                             // ),
//                             // ElevatedButton(
//                             //     onPressed: () async {
//                             //       await _bleController.newWriteToDevice("B 7");
//                             //     },
//                             //     child: const Text("Advertising")
//                             // ),
//                             // ElevatedButton(
//                             //     onPressed: () async {
//                             //       await _bleController.newWriteToDevice("B 8");
//                             //     },
//                             //     child: const Text("Connected")
//                             // ),
//                             const SizedBox(height: 20.0,),
//                             ElevatedButton(
//                                 onPressed: () async {
//                                   await _bleController.disconnectDevice();
//                                 },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.red
//                               ),
//                                 child: const Text("Disconnect Device", style: TextStyle(color: Colors.white),),
//                             ),
//                             const SizedBox(height: 10.0,),
//                           ],
//                         )
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         Obx(() => _bleController.showChargingAnimation.value
//             ? ChargingAnimation(batteryLevel: batteryLevel,)
//             : const SizedBox.shrink()),
//       ],
//     );
//   }
// }
//
// class ChargingAnimation extends StatefulWidget {
//   final double batteryLevel;
//   const ChargingAnimation({Key? key, required this.batteryLevel}) : super(key: key);
//
//   @override
//   State<ChargingAnimation> createState() => _ChargingAnimationState();
// }
//
// class _ChargingAnimationState extends State<ChargingAnimation> {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.black.withOpacity(0.5),
//       child: Center(
//         child: Stack(
//           children: [
//             Align(
//               alignment: Alignment.center,
//               child: Container(
//                 width: 170,
//                 height: 170,
//                 decoration: BoxDecoration(
//                     color: Colors.black.withOpacity(0.7),
//                     borderRadius: BorderRadius.circular(150)
//                 ),
//                 child:
//                 CircularPercentIndicator(
//                   radius: 70.0,
//                   animation: true,
//                   lineWidth: 10.0,
//                   animationDuration: 3000,
//                   animateFromLastPercent: true,
//                   circularStrokeCap: CircularStrokeCap.round,
//                   percent: widget.batteryLevel / 100,
//                   arcType: ArcType.FULL,
//                   linearGradient: LinearGradient(colors: [Colors.green, Colors.green.shade700]),
//                   center: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         AnimateIcon(
//                           onTap: () {},
//                           iconType: IconType.continueAnimation,
//                           height: 60,
//                           width: 60,
//                           color: Colors.white,
//                           animateIcon: AnimateIcons.battery,
//                         ),
//                         Text("${widget.batteryLevel.toInt()}%", style: const TextStyle(color: Colors.white, fontSize: 18),),
//                       ]
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




import 'package:animated_icon/animate_icon.dart';
import 'package:animated_icon/animate_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pain_drain_mobile_app/main.dart';
import 'package:pain_drain_mobile_app/models/temperature.dart';
import 'package:pain_drain_mobile_app/models/vibration.dart';
import 'package:pain_drain_mobile_app/providers/preset_list_notifier.dart';
import 'package:pain_drain_mobile_app/providers/temperature_notifier.dart';
import 'package:pain_drain_mobile_app/providers/tens_notifier.dart';
import 'package:pain_drain_mobile_app/providers/vibration_notifier.dart';
import 'package:pain_drain_mobile_app/screens/home/local_widgets/onboarding.dart';
import 'package:pain_drain_mobile_app/widgets/custom_text_field.dart';
import 'package:pain_drain_mobile_app/widgets/drop_down_button.dart';
import 'package:pain_drain_mobile_app/widgets/tens_summary.dart';
import 'package:pain_drain_mobile_app/widgets/vibration_summary.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../models/preset.dart';
import '../../models/tens.dart';
import '../../providers/bluetooth_notifier.dart';
import '../../utils/app_colors.dart';
import '../../widgets/temperature_summary.dart';

List<String> presetOptions = ['Preset 1', 'Preset 2', 'Preset 3'];



class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  bool isAddingItem = false; // Track whether we are in "add" mode
  bool isLoading = false;
  double batteryLevel = 100;
  bool isCharging = false;
  bool uploadingPreset = false;
  Icon batteryIcon = const Icon(Icons.battery_full, color: Colors.green,);
  Color color = Colors.green;
  String currentOption = presetOptions[0];
  String uploadToDeviceString = "Uploading preset to device...";
  late AnimationController _controller;

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
  void initState() {
    //decrementBattery();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Duration for one complete cycle
    );
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void confirmDelete() {
    final currentPreset = ref.read(presetListNotifierProvider).selectedPreset;
    if(currentPreset != null) {
      showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              title: Text("Are you sure you want to delete preset '${currentPreset.name}'?"),
              actions: [
                ElevatedButton(
                    onPressed: () => Navigator.pop(context),
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

  void showErrorDialog(String errorMessage) {
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text(errorMessage),
            actions: [
              ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Ok", style: TextStyle(color: Colors.black),)
              ),
            ],
          );
        }
    );
  }

  void handleDeleteButton() {
    // Read the current preset.
    final currentPreset = ref.read(presetListNotifierProvider).selectedPreset;
    if (currentPreset != null) {
      ref.read(presetListNotifierProvider.notifier).removePreset(currentPreset.id);
      Preset emptyPreset = Preset(
          id: currentPreset.id,
          tens: const Tens(),
          vibration: const Vibration(),
          temperature: const Temperature(),
          name: ""
      );
      setState(() {
        uploadToDeviceString = "Removing preset from device...";
      });
      uploadPreset(emptyPreset);
    }
    Navigator.pop(context);
  }

  void _hideTextField() {
    setState(() => isAddingItem = !isAddingItem);
  }

  Future<void> _showBottomSheet() async {
    // Use a local variable to track the radio selection in the bottom sheet.
    String bottomSheetCurrentOption = currentOption;

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true, // Makes the bottom sheet take up more space if needed.
      builder: (BuildContext context) {
        // Use StatefulBuilder so that the bottom sheet can rebuild its UI.
        return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setModalState) {
            return Padding(
              padding: EdgeInsets.only(top: 20, bottom: MediaQuery.of(context).viewInsets.bottom + 30),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 150,
                      height: 3,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(.8),
                        borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                    const SizedBox(height: 30,),
                    const Text("Create Preset", style: TextStyle(fontSize: 24),),
                    const SizedBox(height: 30,),
                    // Optionally, include your custom text field widget.
                    CustomTextField(
                      textController: _textController,
                      hideTextField: _hideTextField,
                    ),
                    const SizedBox(height: 16),
                    // Radio button for Preset 1
                    ListTile(
                      title: const Text("Preset 1"),
                      leading: Radio<String>(
                        activeColor: Colors.blue.shade700,
                        value: presetOptions[0],
                        groupValue: bottomSheetCurrentOption,
                        onChanged: (String? value) {
                          setModalState(() {
                            bottomSheetCurrentOption = value!;
                          });
                        },
                      ),
                    ),
                    // Radio button for Preset 2
                    ListTile(
                      title: const Text("Preset 2"),
                      leading: Radio<String>(
                        activeColor: Colors.blue.shade700,
                        value: presetOptions[1],
                        groupValue: bottomSheetCurrentOption,
                        onChanged: (String? value) {
                          setModalState(() {
                            bottomSheetCurrentOption = value!;
                          });
                        },
                      ),
                    ),
                    // Radio button for Preset 3
                    ListTile(
                      title: const Text("Preset 3"),
                      leading: Radio<String>(
                        activeColor: Colors.blue.shade700,
                        value: presetOptions[2],
                        groupValue: bottomSheetCurrentOption,
                        onChanged: (String? value) {
                          setModalState(() {
                            bottomSheetCurrentOption = value!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Confirm button that updates the parent widget's state, if necessary.
                    Center(
                      child: SizedBox(
                        width: 200,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade700,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                            ),
                          ),
                          onPressed: () {
                            // Get preset ID
                            int presetId = presetOptions.indexOf(bottomSheetCurrentOption) + 1;
                            _addPreset(presetId);

                            // Optionally update the parent state here.
                            setState(() {
                              currentOption = bottomSheetCurrentOption;
                            });
                            Navigator.pop(context);
                          },
                          child: const Text("Save", style: TextStyle(fontSize: 16),),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _addPreset(int presetId){
    // Make Preset object and save it
    Preset preset = Preset(
        id: presetId,
        tens: ref.read(tensNotifierProvider),
        vibration: ref.read(vibrationNotifierProvider),
        temperature: ref.read(temperatureNotifierProvider),
        name: _textController.text
    );

    ref.read(presetListNotifierProvider.notifier).savePreset(preset);
    setState(() {
      uploadToDeviceString = "Uploading preset to device...";
    });
    uploadPreset(preset);
  }




  Future<void> _handleLoadPreset() async {
    setState(() {
      isLoading = true;
    });

    _controller.repeat();
    final selectedPreset = ref.read(presetListNotifierProvider).selectedPreset;

    if(selectedPreset != null){
      String command;
      ref.read(tensNotifierProvider.notifier).updateFromPreset(selectedPreset);
      ref.read(vibrationNotifierProvider.notifier).updateFromPreset(selectedPreset);
      ref.read(temperatureNotifierProvider.notifier).updateFromPreset(selectedPreset);


      command = ref.read(bluetoothNotifierProvider.notifier).getCommand("tens");
      await ref.read(bluetoothNotifierProvider.notifier).newWriteToDevice(command);
      command = ref.read(bluetoothNotifierProvider.notifier).getCommand("temperature");
      await ref.read(bluetoothNotifierProvider.notifier).newWriteToDevice(command);
      command = ref.read(bluetoothNotifierProvider.notifier).getCommand("vibration");
      await ref.read(bluetoothNotifierProvider.notifier).newWriteToDevice(command);
    }

    await Future.delayed(const Duration(seconds: 2));
    _controller.stop();
    _controller.reset();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> uploadPreset(Preset preset) async {
    setState(() => uploadingPreset = true);
    await ref.read(bluetoothNotifierProvider.notifier).uploadPresetToDevice(preset);
    await Future.delayed(const Duration(seconds: 3));
    setState(() => uploadingPreset = false);
  }


  void _updateProgress () => setState(() {});

  @override
  Widget build(BuildContext context) {
    final presets = ref.watch(presetListNotifierProvider);
    // final selectPreset = ref.watch(currentPresetNotifierProvider);
    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.offWhite,
          appBar: AppBar(
            leading: Row(
              children: [
                IconButton(
                    onPressed: () {
                      context.push('/onboarding');
                    },
                    icon: Icon(Icons.help_outline_rounded, color: Colors.grey.shade400,)
                ),
              ],
            ),
            title: const Text(
              'Pain Drain',
              style: TextStyle(
                  fontSize: 40,
                  color: Colors.white
              ),
            ),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.blue.shade800,
            centerTitle: true,
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(child: DropDownButton(widthSize: 0, items: presets.presets, selectedPreset: presets.selectedPreset,)),
                          const SizedBox(width: 2.0,),
                          IconButton(
                            icon: const Icon(
                              Icons.add,
                              color: Colors.black, // Change the icon color if needed
                              size: 25.0,
                            ),
                            onPressed: () => _showBottomSheet(),
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
                              onPressed: () => confirmDelete(),
                          ),
                          // ElevatedButton(
                          //   onPressed: () => _showBottomSheet(),
                          //   style: ElevatedButton.styleFrom(
                          //     backgroundColor: Colors.grey[600],
                          //     overlayColor: Colors.white,
                          //     shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(10), // Adjust radius as needed
                          //     ),
                          //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Optional: Adjust button size
                          //   ),
                          //   child: const Text("Save", style: TextStyle(color: Colors.white),),
                          // ),
                          // // ElevatedButton(
                          // //   onPressed: () => uploadPreset(),
                          // //   style: ElevatedButton.styleFrom(
                          // //     backgroundColor: Colors.grey[600],
                          // //     overlayColor: Colors.white,
                          // //     shape: RoundedRectangleBorder(
                          // //       borderRadius: BorderRadius.circular(10), // Adjust radius as needed
                          // //     ),
                          // //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Optional: Adjust button size
                          // //   ),
                          // //   child: const Text("Upload", style: TextStyle(color: Colors.white),),
                          // // ),
                          // ElevatedButton(
                          //   onPressed: () => _handleLoadPreset(),
                          //   style: ElevatedButton.styleFrom(
                          //     backgroundColor: Colors.grey[600],
                          //     overlayColor: Colors.white,
                          //     shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(10), // Rounded corners
                          //     ),
                          //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Controls button size
                          //   ),
                          //   child: isLoading
                          //       ? const SizedBox(
                          //     width: 24, // Match the button’s height
                          //     height: 24,
                          //     child: CircularProgressIndicator(
                          //       color: Colors.white,
                          //       strokeWidth: 3, // Adjust thickness
                          //     ),
                          //   )
                          //       : const Text("Load", style: TextStyle(color: Colors.white)),
                          // ),
                          // ElevatedButton(
                          //   onPressed: () => confirmDelete(),
                          //   style: ElevatedButton.styleFrom(
                          //     backgroundColor: Colors.red[800],
                          //     overlayColor: Colors.white,
                          //     shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(10), // Adjust radius as needed
                          //     ),
                          //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Optional: Adjust button size
                          //   ),
                          //   child: const Text("Delete", style: TextStyle(color: Colors.white),),
                          // ),
                        ],
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
                      // if(showDebugTools)
                      //   Row(
                      //     mainAxisAlignment: MainAxisAlignment.end,
                      //     children: [
                      //       const Text("Debug Dev Info:"),
                      //       const SizedBox(width: 10.0,),
                      //       const Text("OFF"),
                      //
                      //       Switch(
                      //         value: _prefs.getDevControls(),
                      //         onChanged: (bool value) async {
                      //           setState(() {
                      //             _prefs.setDevControls(value);
                      //           });
                      //         },
                      //       ),
                      //       const Text("ON"),
                      //
                      //     ],
                      //   ),
                      // if(_prefs.getDevControls())
                      //   Column(
                      //     children: [
                      //       Text("Tens: ${tens.intensity}", style: const TextStyle(fontSize: 18),),
                      //       Text("phase: ${tens.phase}", style: const TextStyle(fontSize: 18)),
                      //       Text("temperature: ${temp.temperature}", style: const TextStyle(fontSize: 18)),
                      //       Text("Vibration: ${vibe.frequency}", style: const TextStyle(fontSize: 18)),
                      //       const SizedBox(height: 10.0,),
                      //       ElevatedButton(
                      //           onPressed: () {
                      //             setState(() {});
                      //           },
                      //           child: const Text("Refresh")
                      //       ),
                      //       const SizedBox(height: 20.0,),
                      //       ElevatedButton(
                      //           onPressed: () async {
                      //             await ref.read(bluetoothNotifierProvider.notifier).newWriteToDevice("B 2");
                      //           },
                      //           child: const Text("Fully Charged")
                      //       ),
                      //       ElevatedButton(
                      //           onPressed: () async {
                      //             await ref.read(bluetoothNotifierProvider.notifier).newWriteToDevice("B 3");
                      //           },
                      //           child: const Text("Low Battery")
                      //       ),
                      //       ElevatedButton(
                      //           onPressed: () async {
                      //             await ref.read(bluetoothNotifierProvider.notifier).newWriteToDevice("B 4");
                      //           },
                      //           child: const Text("Medium Battery")
                      //       ),
                      //       ElevatedButton(
                      //           onPressed: () async {
                      //             await ref.read(bluetoothNotifierProvider.notifier).newWriteToDevice("B 5");
                      //           },
                      //           child: const Text("Normal Operation")
                      //       ),
                      //       const SizedBox(height: 20.0,),
                      //       ElevatedButton(
                      //         onPressed: () async {
                      //           await ref.read(bluetoothNotifierProvider.notifier).disconnectDevice();
                      //         },
                      //         style: ElevatedButton.styleFrom(
                      //             backgroundColor: Colors.red
                      //         ),
                      //         child: const Text("Disconnect Device", style: TextStyle(color: Colors.white),),
                      //       ),
                      //       const SizedBox(height: 10.0,),
                      //     ],
                      //   )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        if(uploadingPreset)
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5), // Semi-transparent background overlay
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40), // Inner padding
                  decoration: BoxDecoration(
                    color: Colors.white, // Solid white background for the box
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2), // Subtle shadow for depth
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // Only takes the space it needs
                    crossAxisAlignment: CrossAxisAlignment.center, // Ensures text is centered
                    children: [
                      const CircularProgressIndicator(color: Colors.blue,), // Loading indicator
                      const SizedBox(height: 20),
                      Text(
                        uploadToDeviceString,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600, // Slightly bolder for Material feel
                          color: Colors.black87, // Dark text for contrast
                        ),
                        textAlign: TextAlign.center, // Centers the text inside the box
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )

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