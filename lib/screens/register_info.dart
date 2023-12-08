import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../ble/bluetooth_controller.dart';
import '../main.dart';
import '../scheme_colors/app_colors.dart';

class RegisterState extends StatefulWidget {
  const RegisterState({Key? key}) : super(key: key);

  @override
  State<RegisterState> createState() => _RegisterStateState();
}

class _RegisterStateState extends State<RegisterState> {
  final BluetoothController bluetoothController = Get.find<BluetoothController>();
  List<int> readValueList = [];
  int? readValue;
  bool isBusy = false;

  handleButtonPress() async {
    isBusy = true;
    List<int> keysList = globalValues.registers.keys.toList();
    for(int i = 0; i < globalValues.registers.length; i++){
      String stringCommand =  'r ${keysList[i]}';
      List<int> hexValue = bluetoothController.stringToHexList(stringCommand);
      print('Value: $stringCommand');
      print('list hex values $hexValue');
      await bluetoothController.writeToDevice('register', hexValue);
      //await Future.delayed(const Duration(milliseconds: 500)); // You can adjust the delay time
      readValueList = await bluetoothController.readFromDevice();
      print('readValue list: $readValueList');
      readValue = int.parse(bluetoothController.hexToString(readValueList));
      globalValues.registers[keysList[i]] = readValue.toString();
      // This triggers a rebuild to show updated changes
      setState(() {});
    }
    isBusy = false;


    print('read value: $readValue');

  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkGrey,
      appBar: AppBar(
        title: const Text(
          'Register Map',
          style: TextStyle(
              fontSize: 50,
              color: AppColors.offWhite
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[900],
        centerTitle: true,
        //toolbarHeight: 90,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Expanded(child: Text('Register', style: TextStyle(color: AppColors.offWhite, fontSize: 20),)),
                      Expanded(child: Text('Value', style: TextStyle(color: AppColors.offWhite, fontSize: 20), ))
                    ],
                  ),
                  Table(
                    border: TableBorder.all(color: AppColors.offWhite),
                    children: List.generate(
                      globalValues.registers.length,
                          (index) => TableRow(
                        children: [
                          TableCell(
                            child: Center(
                              child: Text(
                                '0x${globalValues.registers.keys.toList()[index].toRadixString(16).padLeft(2, '0')}',
                                style: const TextStyle(color: AppColors.offWhite),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Center(
                              child: Text(
                                globalValues.registers.values.toList()[index],
                                style: const TextStyle(color: AppColors.offWhite),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 120,)
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 77, // Adjust the bottom value as needed
            left: 0,
            right: 0,
            child: ElevatedButton(
              onPressed: () {
                print('isBusy is: $isBusy');
                if(!isBusy){
                  handleButtonPress();
                }
              },
              child: Text('Read'),
            ),
          ),
        ],
      ),
    );
  }
}
