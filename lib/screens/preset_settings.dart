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
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        loadPreset();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 15.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)
                      ),
                    ),
                    child: const Text('LOAD'),
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
    double tensSliderValue = globalValues.getSliderValue('tens');
    double amplitudeSliderValue = globalValues.getSliderValue('amplitude');
    double frequencySliderValue = globalValues.getSliderValue('frequency');
    double waveformSliderValue = globalValues.getSliderValue('waveform');
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
        prefs.setString("$selectedItem.waveType", waveType);
        prefs.setDouble("$selectedItem.temperature", temperatureSliderValue);
        prefs.setDouble("$selectedItem.tens", tensSliderValue);
        prefs.setDouble("$selectedItem.amplitude", amplitudeSliderValue);
        prefs.setDouble("$selectedItem.frequency", frequencySliderValue);
        prefs.setDouble("$selectedItem.waveform", waveformSliderValue);
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
          prefs.remove("$settingName.tens");
          prefs.remove("$settingName.amplitude");
          prefs.remove("$settingName.frequency");
          prefs.remove("$settingName.waveform");
          prefs.remove("$settingName.waveType");
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
        globalValues.setSliderValue("tens", 0.0);
        globalValues.setSliderValue("amplitude", 0.0);
        globalValues.setSliderValue("frequency", 0.0);
        globalValues.setSliderValue("waveform", 0.0);
        globalValues.setWaveType("Sine");
      });
    }
    else {
      final double? tempValue = prefs.getDouble('$selectedItem.temperature');
      final double? tensValue = prefs.getDouble('$selectedItem.tens');
      final double? ampValue = prefs.getDouble('$selectedItem.amplitude');
      final double? freqValue = prefs.getDouble('$selectedItem.frequency');
      final double? waveValue = prefs.getDouble('$selectedItem.waveform');
      final String? waveTypeValue = prefs.getString('$selectedItem.waveType');
      // Sets all sliders and other values to the values associated with the preset name
      setState(() {
        globalValues.setSliderValue("temperature", tempValue!);
        globalValues.setSliderValue("tens", tensValue!);
        globalValues.setSliderValue("amplitude", ampValue!);
        globalValues.setSliderValue("frequency", freqValue!);
        globalValues.setSliderValue("waveform", waveValue!);
        globalValues.setWaveType(waveTypeValue!);
      });
    }
    // Sends a new command with the loaded preset values
    String stringCommandTens = "T ${globalValues.getSliderValue("tens").round()}";
    String stringCommandTemperature = "t ${globalValues.getSliderValue("temperature").round()}";
    String stringCommandVibration = "v ${globalValues.getWaveType()} ${globalValues.getSliderValue("amplitude").round()} ${globalValues.getSliderValue("frequency").round()} ${globalValues.getSliderValue("waveform").round()}";
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
