import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pain_drain_mobile_app/controllers/bluetooth_controller.dart';
import 'package:pain_drain_mobile_app/controllers/stimulus_controller.dart';
import 'package:pain_drain_mobile_app/custom_widgets/new_temp_slider.dart';

class NewTemperatureScreen extends StatefulWidget {
  const NewTemperatureScreen({Key? key}) : super(key: key);

  @override
  State<NewTemperatureScreen> createState() => _NewTemperatureScreenState();
}

class _NewTemperatureScreenState extends State<NewTemperatureScreen> {
  final StimulusController _stimController = Get.find();
  final BluetoothController _bleController = Get.find();

  @override
  Widget build(BuildContext context) {
    String temp = _stimController.temp;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 40.0),
      child: Container(
        //color: Colors.purple,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //const SizedBox(height: 5,),
            Container(
              width: 150,
              height: 10,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.4),
                  borderRadius: BorderRadius.circular(5.0)
              ),
            ),
            //const SizedBox(height: 20,),
            const Text("TEMPERATURE", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    CupertinoIcons.thermometer_snowflake,
                    color: Colors.blue,
                  ),
                  Expanded(
                    child: NewTempSlider(
                      currentValue: _stimController.getStimulus(temp),
                    ),
                  ),
                  const Icon(
                    CupertinoIcons.flame,
                    color: Colors.red,
                  ),
                ]
            ),
            // NewTempSlider(currentValue: stimController.getStimulus("temp"),),
            const SizedBox(height: 20.0,),

            ElevatedButton(
                onPressed: () {
                  _stimController.setStimulus("temp", 0.0);
                  String command = _bleController.getCommand("temperature");
                  _bleController.newWriteToDevice(command);
                  setState(() {});
                },
                child: const Text("OFF", style: TextStyle(color: Colors.black),)
            ),
          ],
        ),
      ),
    );
  }
}
