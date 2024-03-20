import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pain_drain_mobile_app/controllers/bluetooth_controller.dart';
import 'package:pain_drain_mobile_app/controllers/stimulus_controller.dart';
import 'package:pain_drain_mobile_app/screens/onboarding.dart';
import 'package:pain_drain_mobile_app/widgets/custom_text_field.dart';
import 'package:pain_drain_mobile_app/widgets/drop_down_button.dart';
import 'package:pain_drain_mobile_app/widgets/tens_summary.dart';
import 'package:pain_drain_mobile_app/widgets/vibration_summary.dart';
import '../controllers/presets_controller.dart';
import '../scheme_colors/app_colors.dart';
import '../widgets/temperature_summary.dart';

class NewHomePage extends StatefulWidget {
  const NewHomePage({Key? key}) : super(key: key);

  @override
  State<NewHomePage> createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> with SingleTickerProviderStateMixin {
  final SavedPresets _prefs = Get.find();
  final BluetoothController _bleController = Get.find();
  final StimulusController _stimulusController = Get.find();
  TextEditingController textController = TextEditingController();
  late AnimationController _controller;
  //FocusNode textFocusNode = FocusNode();
  bool isAddingItem = false; // Track whether we are in "add" mode
  bool isLoading = false;


  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Duration for one complete cycle
    );
  }
  @override
  void dispose() {
    textController.dispose();
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
      _prefs.deletePreset2(selectedPreset!);
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
     textController.clear();
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

      //await Future.delayed(const Duration(seconds: 2));
      _controller.stop();
      _controller.reset();
      setState(() {
        isLoading = false;
      });
    }
  }

  void _updateProgress () => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: AppBar(
        title: const Text(
          'Stimulus',
          style: TextStyle(
              fontSize: 40,
              color: Colors.white
          ),
        ),
        automaticallyImplyLeading: false,
        //backgroundColor: AppColors.offWhite,
        backgroundColor: Colors.blue.shade800,

        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => const OnBoarding());
              },
              icon: Icon(Icons.help_outline_rounded, color: Colors.grey.shade400,)
          ),
        ],
        //toolbarHeight: 90,
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
                  //DropDownBox(),
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
                        icon:
                        // const Icon(
                        //   Icons.sync,
                        //   color: Colors.black, // Change the icon color if needed
                        //   size: 25.0,
                        // ),
                        RotationTransition(
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
                            textController: textController,
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
                    child: Text("Temperature", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
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
                        Text("Tens: ${_stimulusController.readTens}", style: TextStyle(fontSize: 18),),
                        Text("phase: ${_stimulusController.readPhase}", style: TextStyle(fontSize: 18)),
                        Text("temperature: ${_stimulusController.readTemp}", style: TextStyle(fontSize: 18)),
                        Text("Vibration: ${_stimulusController.readVibe}", style: TextStyle(fontSize: 18)),
                        const SizedBox(height: 10.0,),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {});
                            },
                            child: const Text("Refresh")
                        ),
                      ],
                    )


                ],
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: 0,
      //   // onTap: () {},
      //   items: const [
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.home),
      //         label: "Home"
      //     ),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.settings),
      //         label: "Settings"
      //     ),
      //
      //   ],
      //
      // ),
    );
  }







//   void addNewItem() async {
//     // Adds a new setting
//     double temperatureSliderValue = globalValues.getSliderValue(globalValues.temperature);
//     double tensAmplitudeSliderValue = globalValues.getSliderValue(globalValues.tensAmplitude);
//     double tensDurationSliderValueCh1 = globalValues.getSliderValue(globalValues.tensDurationCh1);
//     double tensPeriodSliderValueCh1 = globalValues.getSliderValue(globalValues.tensPeriod);
//     double tensDurationSliderValueCh2 = globalValues.getSliderValue(globalValues.tensDurationCh2);
//     double tensPhase = globalValues.getSliderValue(globalValues.tensPhase);
//     double amplitudeSliderValue = globalValues.getSliderValue(globalValues.vibeAmplitude);
//     double frequencySliderValue = globalValues.getSliderValue(globalValues.vibeFreq);
//     double waveformSliderValue = globalValues.getSliderValue(globalValues.vibeWaveform);
//     String waveType = globalValues.getWaveType();
//     final SharedPreferences prefs = _prefs;
//     String newItem = textController.text.trim();
//     // Checks to make sure the name is not empty
//     if (newItem.isNotEmpty) {
//       setState(() {
//         /*
//         Grabbing the index and either updating the name
//         with new values or adding it to the dropdown list
//          */
//         int existingIndex = dropdownItems.indexOf(newItem);
//         if (existingIndex != -1) {
//           // If the item already exists, update it
//           dropdownItems[existingIndex] = newItem;
//         } else {
//           // If the item does not exist, add it to the list
//           dropdownItems.add(newItem);
//         }
//         selectedItem = newItem; // Select the newly added item
//         globalValues.setPresetValue(selectedItem!);
//         textController.clear(); // Clear the text input
//         isAddingItem = false; // Exit "add" mode
//         textFocusNode.unfocus(); // Clear focus from the text input field
//         // Setting key value pair for persistent storage associated with name typed
//         prefs.setString("$selectedItem.setting", selectedItem!);
//         prefs.setString("$selectedItem.${globalValues.vibeWaveType}", waveType);
//         prefs.setDouble("$selectedItem.${globalValues.temperature}", temperatureSliderValue);
//         prefs.setDouble("$selectedItem.${globalValues.tensAmplitude}", tensAmplitudeSliderValue);
//         prefs.setDouble("$selectedItem.${globalValues.tensDurationCh1}", tensDurationSliderValueCh1);
//         prefs.setDouble("$selectedItem.${globalValues.tensPeriod}", tensPeriodSliderValueCh1);
//         prefs.setDouble("$selectedItem.${globalValues.tensDurationCh2}", tensDurationSliderValueCh2);
//         prefs.setDouble("$selectedItem.${globalValues.tensPhase}", tensPhase);
//         prefs.setDouble("$selectedItem.${globalValues.vibeAmplitude}", amplitudeSliderValue);
//         prefs.setDouble("$selectedItem.${globalValues.vibeFreq}", frequencySliderValue);
//         prefs.setDouble("$selectedItem.${globalValues.vibeWaveform}", waveformSliderValue);
//       });
//     } else {
//       setState(() {
//         isAddingItem = false; // Exit "add" mode
//         textFocusNode.unfocus(); // Clear focus from the text input field
//       });
//     }
//   }
//
//   void deleteItem() async {
//     final SharedPreferences prefs = _prefs;
//     setState(() {
//       // Makes sure that the user can't delete the first element in the dropdown button
//       if(selectedItem != "No Preset Selected"){
//         final String? settingName = prefs.getString("$selectedItem.setting");
//         // If the name is found in persistent storage then it will delete it
//         if(settingName != null) {
//           prefs.remove("$settingName.setting");
//           prefs.remove("$settingName.${globalValues.temperature}");
//           prefs.remove("$settingName.${globalValues.tensAmplitude}");
//           prefs.remove("$settingName.${globalValues.tensDurationCh1}");
//           prefs.remove("$settingName.${globalValues.tensPeriod}");
//           prefs.remove("$settingName.${globalValues.tensDurationCh2}");
//           prefs.remove("$settingName.${globalValues.tensPhase}");
//           prefs.remove("$settingName.${globalValues.vibeAmplitude}");
//           prefs.remove("$settingName.${globalValues.vibeFreq}");
//           prefs.remove("$settingName.${globalValues.vibeWaveform}");
//           prefs.remove("$settingName.${globalValues.vibeWaveType}");
//           print("removed $settingName");
//           // Remove string from dropdown button
//           dropdownItems.remove(selectedItem);
//           selectedItem = dropdownItems.first;
//           // Select the first item in the list
//           globalValues.setPresetValue(selectedItem!);
//         }
//
//       }
//     });
//   }
//
//   void loadPreset() async {
//     BluetoothController bluetoothController = Get.find<BluetoothController>();
//     final SharedPreferences prefs = await _prefs;
//     /*
//     Acts as a reset button if user has "Select preset"
//     selected it will reset all the settings
//      */
//     if(selectedItem == dropdownItems.first){
//       setState(() {
//         globalValues.setSliderValue(globalValues.temperature, 0.0);
//         globalValues.setSliderValue(globalValues.tensAmplitude, 0.0);
//         globalValues.setSliderValue(globalValues.tensDurationCh1, 0.1);
//         globalValues.setSliderValue(globalValues.tensPeriod, 0.5);
//         globalValues.setSliderValue(globalValues.tensDurationCh2, 0.1);
//         globalValues.setSliderValue(globalValues.tensPhase, 0.0);
//         globalValues.setSliderValue(globalValues.vibeAmplitude, 0.0);
//         globalValues.setSliderValue(globalValues.vibeFreq, 0.0);
//         globalValues.setSliderValue(globalValues.vibeWaveform, 0.0);
//         globalValues.setWaveType("Sine");
//       });
//     }
//     else {
//       final double? tempValue = prefs.getDouble('$selectedItem.${globalValues.temperature}');
//       final double? tensAmplitudeCh1 = prefs.getDouble('$selectedItem.${globalValues.tensAmplitude}');
//       final double? tensDurationCh1 = prefs.getDouble('$selectedItem.${globalValues.tensDurationCh1}');
//       final double? tensPeriodCh1 = prefs.getDouble('$selectedItem.${globalValues.tensPeriod}');
//       final double? tensDurationCh2 = prefs.getDouble('$selectedItem.${globalValues.tensDurationCh2}');
//       final double? tensPhase = prefs.getDouble('$selectedItem.${globalValues.tensPhase}');
//       final double? ampValue = prefs.getDouble('$selectedItem.${globalValues.vibeAmplitude}');
//       final double? freqValue = prefs.getDouble('$selectedItem.${globalValues.vibeFreq}');
//       final double? waveValue = prefs.getDouble('$selectedItem.${globalValues.vibeWaveform}');
//       final String? waveTypeValue = prefs.getString('$selectedItem.${globalValues.vibeWaveType}');
//       // Sets all sliders and other values to the values associated with the preset name
//       setState(() {
//         globalValues.setSliderValue(globalValues.temperature, tempValue!);
//         globalValues.setSliderValue(globalValues.tensAmplitude, tensAmplitudeCh1!);
//         globalValues.setSliderValue(globalValues.tensDurationCh1, tensDurationCh1!);
//         globalValues.setSliderValue(globalValues.tensPeriod, tensPeriodCh1!);
//         globalValues.setSliderValue(globalValues.tensDurationCh2, tensDurationCh2!);
//         globalValues.setSliderValue(globalValues.tensPhase, tensPhase!);
//         globalValues.setSliderValue(globalValues.vibeAmplitude, ampValue!);
//         globalValues.setSliderValue(globalValues.vibeFreq, freqValue!);
//         globalValues.setSliderValue(globalValues.vibeWaveform, waveValue!);
//         globalValues.setWaveType(waveTypeValue!);
//       });
//     }
//     // Sends a new command with the loaded preset values
//     int channel1 = 1;
//     int channel2 = 2;
//     String stringCommandTensCh1 = "T ${globalValues.getSliderValue(globalValues.tensAmplitude).toInt()} ${globalValues.getSliderValue(globalValues.tensDurationCh1)} ${globalValues.getSliderValue(globalValues.tensPeriod)} $channel1";
//     String stringCommandTensCh2 = "T ${globalValues.getSliderValue(globalValues.tensAmplitude).toInt()} ${globalValues.getSliderValue('tensDurationCh2')} ${globalValues.getSliderValue('tensPeriodCh2')} $channel2";
//     String stringCommandTensPhase = "T p ${globalValues.getSliderValue(globalValues.tensPhase)}";
//
//     String stringCommandTemperature = "t ${globalValues.getSliderValue(globalValues.temperature).round()}";
//     String stringCommandVibration = "v ${globalValues.getWaveType()} ${globalValues.getSliderValue(globalValues.vibeAmplitude).round()} ${globalValues.getSliderValue(globalValues.vibeFreq).round()} ${globalValues.getSliderValue(globalValues.vibeWaveform).round()}";
//     print(stringCommandTemperature);
//     print(stringCommandVibration);
//     print(stringCommandTensCh1);
//     print(stringCommandTensCh2);
//     print(stringCommandTensPhase);
//
//     // writing tens channel 1 command string
//     List<int> hexValue = bluetoothController.stringToHexList(stringCommandTensCh1);
//     bluetoothController.writeToDevice("tens", hexValue);
//
//     // writing tens channel 1 command string
//     hexValue = bluetoothController.stringToHexList(stringCommandTensCh2);
//     bluetoothController.writeToDevice("tens", hexValue);
//
//     // writing tens phase command string
//     hexValue = bluetoothController.stringToHexList(stringCommandTensPhase);
//     bluetoothController.writeToDevice("tens", hexValue);
//
//     // writing temperature command string
//     hexValue = bluetoothController.stringToHexList(stringCommandTemperature);
//     bluetoothController.writeToDevice("temperature", hexValue);
//
//     // writing vibration command string
//     hexValue = bluetoothController.stringToHexList(stringCommandVibration);
//     bluetoothController.writeToDevice("vibration", hexValue);
//   }
}
