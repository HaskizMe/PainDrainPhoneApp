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

  void loaderAnimation(AnimationController controller) async {
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
        child: Card(
          elevation: 20.0,
          color: Colors.grey[700],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * .3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Container(
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
        ),
      ),
    );
  }
  void addNewItem() async {
    // Adds a new setting
    double temperatureSliderValue = globalValues.getSliderValue('temperature');
    double tensAmplitudeSliderValueCh1 = globalValues.getSliderValue('tensAmplitudeCh1');
    double tensDurationSliderValueCh1 = globalValues.getSliderValue('tensDurationCh1');
    double tensPeriodSliderValueCh1 = globalValues.getSliderValue('tensPeriodCh1');
    double tensAmplitudeSliderValueCh2 = globalValues.getSliderValue('tensAmplitudeCh2');
    double tensDurationSliderValueCh2 = globalValues.getSliderValue('tensDurationCh2');
    double tensPeriodSliderValueCh2 = globalValues.getSliderValue('tensPeriodCh2');
    double tensPhase = globalValues.getSliderValue('tensPhase');
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
        prefs.setDouble("$selectedItem.tensAmplitudeCh1", tensAmplitudeSliderValueCh1);
        prefs.setDouble("$selectedItem.tensDurationCh1", tensDurationSliderValueCh1);
        prefs.setDouble("$selectedItem.tensPeriodCh1", tensPeriodSliderValueCh1);
        prefs.setDouble("$selectedItem.tensAmplitudeCh2", tensAmplitudeSliderValueCh2);
        prefs.setDouble("$selectedItem.tensDurationCh2", tensDurationSliderValueCh2);
        prefs.setDouble("$selectedItem.tensPeriodCh2", tensPeriodSliderValueCh2);
        prefs.setDouble("$selectedItem.tensPhase", tensPhase);
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
          prefs.remove("$settingName.tensAmplitudeCh1");
          prefs.remove("$settingName.tensDurationCh1");
          prefs.remove("$settingName.tensPeriodCh1");
          prefs.remove("$settingName.tensAmplitudeCh2");
          prefs.remove("$settingName.tensDurationCh2");
          prefs.remove("$settingName.tensPeriodCh2");
          prefs.remove("$settingName.tensPhase");
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
        globalValues.setSliderValue("tensAmplitudeCh1", 0.0);
        globalValues.setSliderValue('tensDurationCh1', 0.1);
        globalValues.setSliderValue('tensPeriodCh1', 0.5);
        globalValues.setSliderValue("tensAmplitudeCh2", 0.0);
        globalValues.setSliderValue('tensDurationCh2', 0.1);
        globalValues.setSliderValue('tensPeriodCh2', 0.5);
        globalValues.setSliderValue('tensPhase', 0.0);
        globalValues.setSliderValue("vibrationAmplitude", 0.0);
        globalValues.setSliderValue("vibrationFrequency", 0.0);
        globalValues.setSliderValue("vibrationWaveform", 0.0);
        globalValues.setWaveType("Sine");
      });
    }
    else {
      final double? tempValue = prefs.getDouble('$selectedItem.temperature');
      final double? tensAmplitudeCh1 = prefs.getDouble('$selectedItem.tensAmplitudeCh1');
      final double? tensDurationCh1 = prefs.getDouble('$selectedItem.tensDurationCh1');
      final double? tensPeriodCh1 = prefs.getDouble('$selectedItem.tensPeriodCh1');
      final double? tensAmplitudeCh2 = prefs.getDouble('$selectedItem.tensAmplitudeCh2');
      final double? tensDurationCh2 = prefs.getDouble('$selectedItem.tensDurationCh2');
      final double? tensPeriodCh2 = prefs.getDouble('$selectedItem.tensPeriodCh2');
      final double? tensPhase = prefs.getDouble('$selectedItem.tensPhase');
      final double? ampValue = prefs.getDouble('$selectedItem.vibrationAmplitude');
      final double? freqValue = prefs.getDouble('$selectedItem.vibrationFrequency');
      final double? waveValue = prefs.getDouble('$selectedItem.vibrationWaveform');
      final String? waveTypeValue = prefs.getString('$selectedItem.vibrationWaveType');
      // Sets all sliders and other values to the values associated with the preset name
      setState(() {
        globalValues.setSliderValue("temperature", tempValue!);
        globalValues.setSliderValue("tensAmplitude", tensAmplitudeCh1!);
        globalValues.setSliderValue("tensDurationCh1", tensDurationCh1!);
        globalValues.setSliderValue("tensPeriodCh1", tensPeriodCh1!);
        globalValues.setSliderValue("tensAmplitudeCh2", tensAmplitudeCh2!);
        globalValues.setSliderValue("tensDurationCh2", tensDurationCh2!);
        globalValues.setSliderValue("tensPeriodCh2", tensPeriodCh2!);
        globalValues.setSliderValue("tensPhase", tensPhase!);
        globalValues.setSliderValue("vibrationAmplitude", ampValue!);
        globalValues.setSliderValue("vibrationFrequency", freqValue!);
        globalValues.setSliderValue("vibrationWaveform", waveValue!);
        globalValues.setWaveType(waveTypeValue!);
      });
    }
    // Sends a new command with the loaded preset values
    int channel1 = 1;
    int channel2 = 2;
    String stringCommandTensCh1 = "T ${globalValues.getSliderValue('tensAmplitudeCh1').toInt()} ${globalValues.getSliderValue('tensDurationCh1')} ${globalValues.getSliderValue('tensPeriodCh1')} $channel1";
    String stringCommandTensCh2 = "T ${globalValues.getSliderValue('tensAmplitudeCh2').toInt()} ${globalValues.getSliderValue('tensDurationCh2')} ${globalValues.getSliderValue('tensPeriodCh2')} $channel2";
    String stringCommandTensPhase = "T p ${globalValues.getSliderValue('tensPhase')}";

    String stringCommandTemperature = "t ${globalValues.getSliderValue("temperature").round()}";
    String stringCommandVibration = "v ${globalValues.getWaveType()} ${globalValues.getSliderValue("vibrationAmplitude").round()} ${globalValues.getSliderValue("vibrationFrequency").round()} ${globalValues.getSliderValue("vibrationWaveform").round()}";
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
