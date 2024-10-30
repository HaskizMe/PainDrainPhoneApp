import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pain_drain_mobile_app/models/bluetooth.dart';
import 'package:pain_drain_mobile_app/models/stimulus.dart';
import 'package:pain_drain_mobile_app/widgets/temp_slider.dart';

class TemperaturePopup extends StatefulWidget {
  const TemperaturePopup({Key? key}) : super(key: key);

  @override
  State<TemperaturePopup> createState() => _TemperaturePopupState();
}

class _TemperaturePopupState extends State<TemperaturePopup> {
  final Stimulus _stimController = Get.find();
  final Bluetooth _bleController = Get.find();


  @override
  Widget build(BuildContext context) {
    String temp = _stimController.temp;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 40.0),
      child: Container(
        //color: Colors.purple,
        child: Obx(() {
          _bleController.isCharging.value;
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 10,),
                    Container(
                      width: 150,
                      height: 5,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(.4),
                          borderRadius: BorderRadius.circular(5.0)
                      ),
                    ),
                    const SizedBox(height: 20,),
                    const Text("TEMPERATURE", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                  ],
                ),
                //const SizedBox(height: 5,),

                Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            CupertinoIcons.thermometer_snowflake,
                            color: Colors.blue,
                          ),
                          Expanded(
                            child: TempSlider(
                              currentValue: _stimController.getStimulus(temp),
                            ),
                          ),
                          const Icon(
                            CupertinoIcons.flame,
                            color: Colors.red,
                          ),
                        ]
                    ),
                  ],
                ),

                Column(
                  children: [
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

              ],
            );
          }
        ),
      ),
    );
  }
}
