import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../ble/bluetooth_controller.dart';
import '../main.dart';

class PresetSettings extends StatefulWidget {
  const PresetSettings({Key? key}) : super(key: key);

  @override
  State<PresetSettings> createState() => _PresetSettingsState();
}

class _PresetSettingsState extends State<PresetSettings> {
  final BluetoothController bluetoothController = Get.find<BluetoothController>();
  late SharedPreferences _prefs;
  String selectedItem = globalValues.getPresetValue();
  List<String> dropdownItems = []; // Initialize as an empty list
  TextEditingController textController = TextEditingController();
  FocusNode textFocusNode = FocusNode();
  bool isAddingItem = false; // Track whether we are in "add" mode
  bool isLoading = false;

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
    init();
  }

  Future init() async {
    _prefs = await SharedPreferences.getInstance();
    List<String> items = await globalValues.getPresets();
    setState(() {
      dropdownItems = items;
    });
  }
  void _handleButtonPress() {
    // Simulate loading for 2 seconds
    setState(() {
      isLoading = true;
      loadPreset();
    });

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  void httpJob(AnimationController controller) async {
    controller.forward();
    print("delay start");
    await Future.delayed(Duration(seconds: 3), () {});
    print("delay stop");
    controller.reset();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: const Text(
          'Presets',
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButton<String>(
                isExpanded: true,
                value: selectedItem,
                underline: Container(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedItem = newValue!;
                    globalValues.setPresetValue(selectedItem);
                  });
                },
                items: dropdownItems.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 40),
            if (isAddingItem)
              Container(
                //margin: const EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
                width: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SizedBox(
                        child: TextFormField(
                          controller: textController,
                          focusNode: textFocusNode, // Request focus on the text input field
                          decoration: const InputDecoration(
                            labelText: 'Add item:',
                          ),
                          onFieldSubmitted: (value) {
                            addNewItem();
                          },
                          textInputAction: TextInputAction.done, // Show "done" action button
                          onEditingComplete: () {
                            addNewItem();
                          },
                          maxLength: 15, // Set a max length of 10 characters
                          style: TextStyle(fontSize: 26, color: Colors.white), // Set a smaller font size
                        ),
                      ),
                    ),
                  ],
                ),
              )
            else
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: dropdownItems.length <= 5 ? () {
                      setState(() {
                        isAddingItem = true;
                        textController.clear();
                        textFocusNode.requestFocus(); // Request focus when the "Add Item" button is pressed
                      });
                    } : null, // Disable the button when list length is greater than 5
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 15.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)
                      ),
                    ),
                    child: const Text('ADD'),
                  ),


                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        deleteItem();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)
                      ),
                    ),
                    child: const Text('DELETE'),
                  ),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     setState(() {
                  //       loadPreset();
                  //     });
                  //   },
                  //   style: ElevatedButton.styleFrom(
                  //     padding: EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 15.0),
                  //     shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(15.0)
                  //     ),
                  //   ),
                  //   child: const Text('LOAD'),
                  // ),

                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      backgroundColor: Colors.blue
                    ),
                      onPressed: isLoading ? null : _handleButtonPress,
                      child: Container(
                        child: isLoading
                        ? Container(
                          height: 15,
                          width: 15,
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ) : const Text(
                            "LOAD",
                          style: TextStyle(
                            color: Colors.white
                          ),
                        )
                      )
                  ),


                ]

            ),
          ],
        ),
      ),
    );
  }
  void addNewItem() async {
    // Adds a new setting
    double temperatureSliderValue = globalValues.getSliderValue('temperature');
    double tensSliderValue = globalValues.getSliderValue('tensAmplitude');
    double tensDurationSliderValue = globalValues.getSliderValue('tensDuration');
    double tensPeriodSliderValue = globalValues.getSliderValue('tensPeriod');
    double amplitudeSliderValue = globalValues.getSliderValue('vibrationAmplitude');
    double frequencySliderValue = globalValues.getSliderValue('vibrationFrequency');
    double waveformSliderValue = globalValues.getSliderValue('vibrationWaveform');
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
        globalValues.setPresetValue(selectedItem);
        textController.clear(); // Clear the text input
        isAddingItem = false; // Exit "add" mode
        textFocusNode.unfocus(); // Clear focus from the text input field
        // Setting key value pair for persistent storage associated with name typed
        prefs.setString("$selectedItem.setting", selectedItem);
        prefs.setString("$selectedItem.vibrationWaveType", waveType);
        prefs.setDouble("$selectedItem.temperature", temperatureSliderValue);
        prefs.setDouble("$selectedItem.tensAmplitude", tensSliderValue);
        prefs.setDouble("$selectedItem.tensDuration", tensDurationSliderValue);
        prefs.setDouble("$selectedItem.tensPeriod", tensPeriodSliderValue);
        prefs.setDouble("$selectedItem.vibrationAmplitude", amplitudeSliderValue);
        prefs.setDouble("$selectedItem.vibrationFrequency", frequencySliderValue);
        prefs.setDouble("$selectedItem.vibrationWaveform", waveformSliderValue);
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
          prefs.remove("$settingName.temperature");
          prefs.remove("$settingName.tensAmplitude");
          prefs.remove("$settingName.tensDuration");
          prefs.remove("$settingName.tensPeriod");
          prefs.remove("$settingName.vibrationAmplitude");
          prefs.remove("$settingName.vibrationFrequency");
          prefs.remove("$settingName.vibrationWaveform");
          prefs.remove("$settingName.vibrationWaveType");
          print("removed $settingName");
          // Remove string from dropdown button
          dropdownItems.remove(selectedItem);
          selectedItem = dropdownItems.first;
          // Select the first item in the list
          globalValues.setPresetValue(selectedItem);
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
        globalValues.setSliderValue("temperature", 0.0);
        globalValues.setSliderValue("tensAmplitude", 0.0);
        globalValues.setSliderValue('tensDuration', 0.1);
        globalValues.setSliderValue('tensPeriod', 0.5);
        globalValues.setSliderValue("vibrationAmplitude", 0.0);
        globalValues.setSliderValue("vibrationFrequency", 0.0);
        globalValues.setSliderValue("vibrationWaveform", 0.0);
        globalValues.setWaveType("Sine");
      });
    }
    else {
      final double? tempValue = prefs.getDouble('$selectedItem.temperature');
      final double? tensValue = prefs.getDouble('$selectedItem.tensAmplitude');
      final double? tensDuration = prefs.getDouble('$selectedItem.tensDuration');
      final double? tensPeriod = prefs.getDouble('$selectedItem.tensPeriod');
      final double? ampValue = prefs.getDouble('$selectedItem.vibrationAmplitude');
      final double? freqValue = prefs.getDouble('$selectedItem.vibrationFrequency');
      final double? waveValue = prefs.getDouble('$selectedItem.vibrationWaveform');
      final String? waveTypeValue = prefs.getString('$selectedItem.vibrationWaveType');
      // Sets all sliders and other values to the values associated with the preset name
      setState(() {
        globalValues.setSliderValue("temperature", tempValue!);
        globalValues.setSliderValue("tensAmplitude", tensValue!);
        globalValues.setSliderValue("tensDuration", tensDuration!);
        globalValues.setSliderValue("tensPeriod", tensPeriod!);
        globalValues.setSliderValue("vibrationAmplitude", ampValue!);
        globalValues.setSliderValue("vibrationFrequency", freqValue!);
        globalValues.setSliderValue("vibrationWaveform", waveValue!);
        globalValues.setWaveType(waveTypeValue!);
      });
    }
    // Sends a new command with the loaded preset values
    String stringCommandTens = "T ${globalValues.getSliderValue('tensAmplitude').toInt()} ${globalValues.getSliderValue('tensDuration')} ${globalValues.getSliderValue('tensPeriod')}";
    String stringCommandTemperature = "t ${globalValues.getSliderValue("temperature").round()}";
    String stringCommandVibration = "v ${globalValues.getWaveType()} ${globalValues.getSliderValue("vibrationAmplitude").round()} ${globalValues.getSliderValue("vibrationFrequency").round()} ${globalValues.getSliderValue("vibrationWaveform").round()}";
    print(stringCommandTemperature);
    print(stringCommandVibration);
    print(stringCommandTens);
    // writing tens command string
    List<int> hexValue = bluetoothController.stringToHexList(stringCommandTens);
    bluetoothController.writeToDevice("tens", hexValue);

    // writing temperature command string
    hexValue = bluetoothController.stringToHexList(stringCommandTemperature);
    bluetoothController.writeToDevice("temperature", hexValue);

    // writing vibration command string
    hexValue = bluetoothController.stringToHexList(stringCommandVibration);
    bluetoothController.writeToDevice("vibration", hexValue);



  }
}
