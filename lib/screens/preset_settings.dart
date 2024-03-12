import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pain_drain_mobile_app/controllers/presets_controller.dart';
import 'package:pain_drain_mobile_app/widgets/custom_button.dart';
import 'package:pain_drain_mobile_app/widgets/drop_down_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pain_drain_mobile_app/controllers//bluetooth_controller.dart';
import '../main.dart';
import '../scheme_colors/app_colors.dart';

/*
USE NEW HOME PAGE SCREEN FOR PRESETS FOR NOW!!!!!!!!!!!!!!!!!!!!!!!!
 */




class PresetSettings extends StatefulWidget {
  const PresetSettings({Key? key}) : super(key: key);

  @override
  State<PresetSettings> createState() => _PresetSettingsState();
}

class _PresetSettingsState extends State<PresetSettings> {
  final BluetoothController bluetoothController = Get.find();
  final SavedPresets presets = Get.find();
  late SharedPreferences _prefs;
  // String? selectedItem = globalValues.getPresetValue();
  List<String> dropdownItems = []; // Initialize as an empty list
  TextEditingController textController = TextEditingController();
  FocusNode textFocusNode = FocusNode();
  bool isAddingItem = false; // Track whether we are in "add" mode
  bool isLoading = false;
  String? selectedItem;
  List<String>? items;
  @override
  void dispose() {
    textController.dispose();
    textFocusNode.dispose();
    super.dispose();
  }
  @override
  /*
  init state to grab the persistent storage of the presets
  and grab the preset names for the drop down list
  */
  void initState() {
    super.initState();
    items = presets.getPresets();
    // init();
  }

  // Future init() async {
  //   //_prefs = await SharedPreferences.getInstance();
  //   //List<String> items = await globalValues.getPresets();
  //   //dropdownItems = items;
  //   // setState(() {
  //   //   dropdownItems = items;
  //   // });
  // }
  void _handleButtonPress() {
    // Simulate loading for 2 seconds
    setState(() {
      isLoading = true;
      loadPreset();
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  void loaderAnimation(AnimationController controller) async {
    controller.forward();
    print("delay start");
    await Future.delayed(const Duration(seconds: 3), () {});
    print("delay stop");
    controller.reset();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: AppBar(
        title: const Text(
          'Presets',
          style: TextStyle(
            fontSize: 40,
            color: Colors.white
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.green,
        centerTitle: true,
        //toolbarHeight: 90,
      ),
      body:
      Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(height: 20,),
          // DropDownBox(dropDownMenuItems: dropdownItems,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // DropDownBox(selectedItem: selectedItem,),
              // DropdownButtonHideUnderline(
              //   child: DropdownButton2<String>(
              //     isExpanded: true,
              //     hint: const Row(
              //       children: [
              //         Expanded(
              //           child: Text(
              //             'No Preset Selected',
              //             style: TextStyle(
              //               fontSize: 14,
              //               color: Colors.black38,
              //             ),
              //             overflow: TextOverflow.ellipsis,
              //           ),
              //         ),
              //       ],
              //     ),
              //     items: items.map((String item) => DropdownMenuItem<String>(
              //         value: item,
              //         child: Text(
              //           item,
              //           style: const TextStyle(
              //             fontSize: 14,
              //             fontWeight: FontWeight.bold,
              //             color: Colors.black,
              //           ),
              //           overflow: TextOverflow.ellipsis,
              //         )
              //     )).toList(),
              //     value: selectedItem,
              //     onChanged: (value) {
              //       setState(() {
              //         selectedItem = value!;
              //         globalValues.setPresetValue(selectedItem!);
              //       });
              //     },
              //     buttonStyleData: ButtonStyleData(
              //       height: 50,
              //       width: 210,
              //       padding: const EdgeInsets.only(left: 14, right: 14),
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(14),
              //         border: Border.all(
              //           color: Colors.black26,
              //         ),
              //         color: Colors.white,
              //       ),
              //       elevation: 2,
              //     ),
              //     iconStyleData: const IconStyleData(
              //       icon: Icon(
              //         Icons.arrow_drop_down_outlined,
              //       ),
              //       iconSize: 30,
              //       iconEnabledColor: Colors.black,
              //       iconDisabledColor: Colors.grey,
              //     ),
              //     dropdownStyleData: DropdownStyleData(
              //       maxHeight: 200,
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(14),
              //         color: Colors.white,
              //       ),
              //       scrollbarTheme: ScrollbarThemeData(
              //         radius: const Radius.circular(40),
              //         thickness: MaterialStateProperty.all(6),
              //         thumbVisibility: MaterialStateProperty.all(true),
              //       ),
              //     ),
              //     menuItemStyleData: const MenuItemStyleData(
              //       height: 40,
              //       padding: EdgeInsets.only(left: 14, right: 14),
              //     ),
              //   ),
              // ),
             // DropDownBox(items: items, selectedItem: selectedItem,),
              const SizedBox(width: 5.0,),
              Column(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.add,
                      color: Colors.black, // Change the icon color if needed
                      size: 30.0,
                    ),
                    onPressed: () {
                      setState(() {
                        isAddingItem = true;
                      });
                    },
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(
                  Icons.sync,
                  color: Colors.black, // Change the icon color if needed
                  size: 25.0,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red, // Change the icon color if needed
                  size: 25.0,
                ),
                onPressed: () {
                  setState(() {
                    items?.remove(selectedItem);
                    if (items!.isEmpty) {
                      // selectedItem = null;
                    } else {
                      selectedItem = items?.first;
                    }
                  });
                  print(items);
                },
              ),
              // const SizedBox(width: 5.0,),
              // TextButton(
              //     onPressed: () async {
              //       print("PRESSED");
              //       setState(() {
              //         selectedItem = null; // Select the first item in the list
              //       });
              //     },
              //     child: Text("Clear Preset")
              // )
              // Ink(
              //   width: 50,
              //   height: 50,
              //   decoration: const ShapeDecoration(
              //     color: Colors.white,
              //     shape: CircleBorder(),
              //   ),
              //   child: IconButton(
              //     icon: const Icon(
              //       Icons.add,
              //       color: Colors.black, // Change the icon color if needed
              //       size: 20.0,
              //     ),
              //     onPressed: () {},
              //   ),
              // ),
              // IconButton(
              //     onPressed: () {},
              //     icon: Icon(Icons.add),
              // )
              // CustomButton(buttonTitle: 'ADD', handleFunction: () {},),
              // CustomButton(buttonTitle: 'LOAD', handleFunction: () {},),
              // CustomButton(buttonTitle: 'DELETE', handleFunction: () {},),

            ],
          ),

          if (isAddingItem) // Show TextField when adding item
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 200,
                  child:
                  TextField(
                    controller: textController,
                    focusNode: textFocusNode,
                    decoration: const InputDecoration(
                      labelText: 'Enter a new item',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (value) {
                      // Add the new item to the list
                      if(value.isNotEmpty){
                        setState(() {
                          items?.add(value);
                          selectedItem = value;
                          textController.clear();
                        });
                      }
                      setState(() {
                        isAddingItem = false;
                      });
                    },
                  ),
                ),
              ),
            ),
          // ElevatedButton(
          //     onPressed: () {
          //       print(globalValues.getPresetValue());
          //     },
          //     child: Text("ADD"),
          // ),
          // DropdownButton<String>(
          //   focusColor: AppColors.offWhite,
          //   iconEnabledColor: AppColors.offWhite,
          //   isExpanded: true,
          //   value: selectedItem,
          //   underline: Container(),
          //   onChanged: (String? newValue) {
          //     setState(() {
          //       selectedItem = newValue!;
          //       globalValues.setPresetValue(selectedItem);
          //     });
          //   },
          //   items: dropdownItems.map<DropdownMenuItem<String>>((String value) {
          //     return DropdownMenuItem<String>(
          //       value: value,
          //       child: Text(value),
          //     );
          //   }).toList(),
          //   icon: const Icon(Icons.arrow_drop_down_outlined, color: Colors.grey,),
          // ),

        ],
      ),


      // Align(
      //   alignment: const Alignment(0, -.25),
      //   child: Padding(
      //     padding: EdgeInsets.all(10.0),
      //     child: Card(
      //       elevation: 2.0,
      //       color: AppColors.darkerGrey,
      //       shape: RoundedRectangleBorder(
      //           borderRadius: BorderRadius.circular(20.0)
      //       ),
      //       child: SizedBox(
      //         height: MediaQuery.of(context).size.height * .3,
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             Container(
      //               width: 150,
      //               decoration: BoxDecoration(
      //                 color: AppColors.offWhite,
      //                 borderRadius: BorderRadius.circular(10),
      //               ),
      //               child: DropdownButton<String>(
      //                 focusColor: AppColors.offWhite,
      //                 iconEnabledColor: AppColors.offWhite,
      //                 isExpanded: true,
      //                 value: selectedItem,
      //                 underline: Container(),
      //                 onChanged: (String? newValue) {
      //                   setState(() {
      //                     selectedItem = newValue!;
      //                     globalValues.setPresetValue(selectedItem);
      //                   });
      //                 },
      //                 items: dropdownItems.map<DropdownMenuItem<String>>((String value) {
      //                   return DropdownMenuItem<String>(
      //                     value: value,
      //                     child: Text(value),
      //                   );
      //                 }).toList(),
      //                 icon: const Icon(Icons.arrow_drop_down_outlined, color: Colors.grey,),
      //               ),
      //             ),
      //             const SizedBox(height: 40),
      //             if (isAddingItem)
      //               Padding(
      //                 padding: const EdgeInsets.all(20.0),
      //                 child: SizedBox(
      //                   //margin: const EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
      //                   width: 200,
      //                   child: Row(
      //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                     children: [
      //                       Expanded(
      //                         child: SizedBox(
      //                           child: TextFormField(
      //                             controller: textController,
      //                             focusNode: textFocusNode, // Request focus on the text input field
      //                             decoration: const InputDecoration(
      //                               labelText: 'Add item:',
      //                               labelStyle: TextStyle(
      //                                 color: Colors.white
      //                               ),
      //                               focusedBorder: UnderlineInputBorder(
      //                                 borderSide: BorderSide(color: Colors.white)
      //                               ),
      //                             ),
      //                             onFieldSubmitted: (value) {
      //                               addNewItem();
      //                             },
      //                             textInputAction: TextInputAction.done, // Show "done" action button
      //                             onEditingComplete: () {
      //                               addNewItem();
      //                             },
      //                             maxLength: 15, // Set a max length of 10 characters
      //                             style: const TextStyle(fontSize: 26, color: AppColors.offWhite), // Set a smaller font size
      //                             cursorColor: Colors.white,
      //                           ),
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               )
      //             else
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                 children: [
      //                   ElevatedButton(
      //                     onPressed: dropdownItems.length <= 5 ? () {
      //                       setState(() {
      //                         isAddingItem = true;
      //                         textController.clear();
      //                         textFocusNode.requestFocus(); // Request focus when the "Add Item" button is pressed
      //                       });
      //                     } : null, // Disable the button when list length is greater than 5
      //                     style: ElevatedButton.styleFrom(
      //                       padding: const EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 15.0),
      //                       shape: RoundedRectangleBorder(
      //                           borderRadius: BorderRadius.circular(15.0)
      //                       ),
      //                       backgroundColor: Colors.blue
      //                     ),
      //                     child: const Text(
      //                         'ADD',
      //                       style: TextStyle(
      //                         color: Colors.white
      //                       ),
      //                     ),
      //                   ),
      //
      //
      //                   ElevatedButton(
      //                     onPressed: () {
      //                       setState(() {
      //                         deleteItem();
      //                       });
      //                     },
      //                     style: ElevatedButton.styleFrom(
      //                       padding: const EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 15.0),
      //                       shape: RoundedRectangleBorder(
      //                         borderRadius: BorderRadius.circular(15.0)
      //                       ),
      //                       backgroundColor: Colors.blue
      //                     ),
      //                     child: const Text(
      //                         'DELETE',
      //                       style: TextStyle(
      //                         color: Colors.white
      //                       ),
      //                     ),
      //                   ),
      //
      //                   TextButton(
      //                     style: TextButton.styleFrom(
      //                       padding: const EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 15.0),
      //                       shape: RoundedRectangleBorder(
      //                         borderRadius: BorderRadius.circular(15.0),
      //                       ),
      //                       backgroundColor: Colors.blue
      //                     ),
      //                       onPressed: isLoading ? null : _handleButtonPress,
      //                       child: Container(
      //                         child: isLoading
      //                         ? const SizedBox(
      //                           height: 15,
      //                           width: 15,
      //                           child: CircularProgressIndicator(
      //                             color: AppColors.offWhite,
      //                           ),
      //                         ) : const Text(
      //                             "LOAD",
      //                           style: TextStyle(
      //                             color: Colors.white
      //                           ),
      //                         )
      //                       )
      //                   ),
      //
      //
      //                 ]
      //
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        // onTap: () {},
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings"
          ),

        ],

      ),
    );
  }
  void addNewItem() async {
    // Adds a new setting
    double temperatureSliderValue = globalValues.getSliderValue(globalValues.temperature);
    double tensAmplitudeSliderValue = globalValues.getSliderValue(globalValues.tensAmplitude);
    double tensDurationSliderValueCh1 = globalValues.getSliderValue(globalValues.tensDurationCh1);
    double tensPeriodSliderValueCh1 = globalValues.getSliderValue(globalValues.tensPeriod);
    double tensDurationSliderValueCh2 = globalValues.getSliderValue(globalValues.tensDurationCh2);
    double tensPhase = globalValues.getSliderValue(globalValues.tensPhase);
    double amplitudeSliderValue = globalValues.getSliderValue(globalValues.vibeAmplitude);
    double frequencySliderValue = globalValues.getSliderValue(globalValues.vibeFreq);
    double waveformSliderValue = globalValues.getSliderValue(globalValues.vibeWaveform);
    String waveType = globalValues.getWaveType();
    final SharedPreferences prefs = _prefs;
    String newItem = textController.text.trim();
    // Checks to make sure the name is not empty
    if (newItem.isNotEmpty) {
      setState(() {
        /*
        Grabbing the index and either updating the name
        with new values or adding it to the dropdown list
         */
        int existingIndex = dropdownItems.indexOf(newItem);
        if (existingIndex != -1) {
          // If the item already exists, update it
          dropdownItems[existingIndex] = newItem;
        } else {
          // If the item does not exist, add it to the list
          dropdownItems.add(newItem);
        }
        selectedItem = newItem; // Select the newly added item
        globalValues.setPresetValue(selectedItem!);
        textController.clear(); // Clear the text input
        isAddingItem = false; // Exit "add" mode
        textFocusNode.unfocus(); // Clear focus from the text input field
        // Setting key value pair for persistent storage associated with name typed
        prefs.setString("$selectedItem.setting", selectedItem!);
        prefs.setString("$selectedItem.${globalValues.vibeWaveType}", waveType);
        prefs.setDouble("$selectedItem.${globalValues.temperature}", temperatureSliderValue);
        prefs.setDouble("$selectedItem.${globalValues.tensAmplitude}", tensAmplitudeSliderValue);
        prefs.setDouble("$selectedItem.${globalValues.tensDurationCh1}", tensDurationSliderValueCh1);
        prefs.setDouble("$selectedItem.${globalValues.tensPeriod}", tensPeriodSliderValueCh1);
        prefs.setDouble("$selectedItem.${globalValues.tensDurationCh2}", tensDurationSliderValueCh2);
        prefs.setDouble("$selectedItem.${globalValues.tensPhase}", tensPhase);
        prefs.setDouble("$selectedItem.${globalValues.vibeAmplitude}", amplitudeSliderValue);
        prefs.setDouble("$selectedItem.${globalValues.vibeFreq}", frequencySliderValue);
        prefs.setDouble("$selectedItem.${globalValues.vibeWaveform}", waveformSliderValue);
      });
    } else {
      setState(() {
        isAddingItem = false; // Exit "add" mode
        textFocusNode.unfocus(); // Clear focus from the text input field
      });
    }
  }

  void deleteItem() async {
    final SharedPreferences prefs = _prefs;
    setState(() {
      // Makes sure that the user can't delete the first element in the dropdown button
      if(selectedItem != "Select preset"){
        final String? settingName = prefs.getString("$selectedItem.setting");
        // If the name is found in persistent storage then it will delete it
        if(settingName != null) {
          prefs.remove("$settingName.setting");
          prefs.remove("$settingName.${globalValues.temperature}");
          prefs.remove("$settingName.${globalValues.tensAmplitude}");
          prefs.remove("$settingName.${globalValues.tensDurationCh1}");
          prefs.remove("$settingName.${globalValues.tensPeriod}");
          prefs.remove("$settingName.${globalValues.tensDurationCh2}");
          prefs.remove("$settingName.${globalValues.tensPhase}");
          prefs.remove("$settingName.${globalValues.vibeAmplitude}");
          prefs.remove("$settingName.${globalValues.vibeFreq}");
          prefs.remove("$settingName.${globalValues.vibeWaveform}");
          prefs.remove("$settingName.${globalValues.vibeWaveType}");
          print("removed $settingName");
          // Remove string from dropdown button
          dropdownItems.remove(selectedItem);
          selectedItem = dropdownItems.first;
          // Select the first item in the list
          globalValues.setPresetValue(selectedItem!);
        }

      }
    });
  }

  void loadPreset() async {
    final SharedPreferences prefs = await _prefs;
    /*
    Acts as a reset button if user has "Select preset"
    selected it will reset all the settings
     */
    if(selectedItem == dropdownItems.first){
      setState(() {
        globalValues.setSliderValue(globalValues.temperature, 0.0);
        globalValues.setSliderValue(globalValues.tensAmplitude, 0.0);
        globalValues.setSliderValue(globalValues.tensDurationCh1, 0.1);
        globalValues.setSliderValue(globalValues.tensPeriod, 0.5);
        globalValues.setSliderValue(globalValues.tensDurationCh2, 0.1);
        globalValues.setSliderValue(globalValues.tensPhase, 0.0);
        globalValues.setSliderValue(globalValues.vibeAmplitude, 0.0);
        globalValues.setSliderValue(globalValues.vibeFreq, 0.0);
        globalValues.setSliderValue(globalValues.vibeWaveform, 0.0);
        globalValues.setWaveType("Sine");
      });
    }
    else {
      final double? tempValue = prefs.getDouble('$selectedItem.${globalValues.temperature}');
      final double? tensAmplitudeCh1 = prefs.getDouble('$selectedItem.${globalValues.tensAmplitude}');
      final double? tensDurationCh1 = prefs.getDouble('$selectedItem.${globalValues.tensDurationCh1}');
      final double? tensPeriodCh1 = prefs.getDouble('$selectedItem.${globalValues.tensPeriod}');
      final double? tensDurationCh2 = prefs.getDouble('$selectedItem.${globalValues.tensDurationCh2}');
      final double? tensPhase = prefs.getDouble('$selectedItem.${globalValues.tensPhase}');
      final double? ampValue = prefs.getDouble('$selectedItem.${globalValues.vibeAmplitude}');
      final double? freqValue = prefs.getDouble('$selectedItem.${globalValues.vibeFreq}');
      final double? waveValue = prefs.getDouble('$selectedItem.${globalValues.vibeWaveform}');
      final String? waveTypeValue = prefs.getString('$selectedItem.${globalValues.vibeWaveType}');
      // Sets all sliders and other values to the values associated with the preset name
      setState(() {
        globalValues.setSliderValue(globalValues.temperature, tempValue!);
        globalValues.setSliderValue(globalValues.tensAmplitude, tensAmplitudeCh1!);
        globalValues.setSliderValue(globalValues.tensDurationCh1, tensDurationCh1!);
        globalValues.setSliderValue(globalValues.tensPeriod, tensPeriodCh1!);
        globalValues.setSliderValue(globalValues.tensDurationCh2, tensDurationCh2!);
        globalValues.setSliderValue(globalValues.tensPhase, tensPhase!);
        globalValues.setSliderValue(globalValues.vibeAmplitude, ampValue!);
        globalValues.setSliderValue(globalValues.vibeFreq, freqValue!);
        globalValues.setSliderValue(globalValues.vibeWaveform, waveValue!);
        globalValues.setWaveType(waveTypeValue!);
      });
    }
    // Sends a new command with the loaded preset values
    int channel1 = 1;
    int channel2 = 2;
    String stringCommandTensCh1 = "T ${globalValues.getSliderValue(globalValues.tensAmplitude).toInt()} ${globalValues.getSliderValue(globalValues.tensDurationCh1)} ${globalValues.getSliderValue(globalValues.tensPeriod)} $channel1";
    String stringCommandTensCh2 = "T ${globalValues.getSliderValue(globalValues.tensAmplitude).toInt()} ${globalValues.getSliderValue('tensDurationCh2')} ${globalValues.getSliderValue('tensPeriodCh2')} $channel2";
    String stringCommandTensPhase = "T p ${globalValues.getSliderValue(globalValues.tensPhase)}";

    String stringCommandTemperature = "t ${globalValues.getSliderValue(globalValues.temperature).round()}";
    String stringCommandVibration = "v ${globalValues.getWaveType()} ${globalValues.getSliderValue(globalValues.vibeAmplitude).round()} ${globalValues.getSliderValue(globalValues.vibeFreq).round()} ${globalValues.getSliderValue(globalValues.vibeWaveform).round()}";
    print(stringCommandTemperature);
    print(stringCommandVibration);
    print(stringCommandTensCh1);
    print(stringCommandTensCh2);
    print(stringCommandTensPhase);

    // writing tens channel 1 command string
    List<int> hexValue = bluetoothController.stringToHexList(stringCommandTensCh1);
    bluetoothController.writeToDevice("tens", hexValue);

    // writing tens channel 1 command string
    hexValue = bluetoothController.stringToHexList(stringCommandTensCh2);
    bluetoothController.writeToDevice("tens", hexValue);

    // writing tens phase command string
    hexValue = bluetoothController.stringToHexList(stringCommandTensPhase);
    bluetoothController.writeToDevice("tens", hexValue);

    // writing temperature command string
    hexValue = bluetoothController.stringToHexList(stringCommandTemperature);
    bluetoothController.writeToDevice("temperature", hexValue);

    // writing vibration command string
    hexValue = bluetoothController.stringToHexList(stringCommandVibration);
    bluetoothController.writeToDevice("vibration", hexValue);
  }
}
