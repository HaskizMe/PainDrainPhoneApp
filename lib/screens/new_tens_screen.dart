import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pain_drain_mobile_app/controllers/bluetooth_controller.dart';
import 'package:pain_drain_mobile_app/widgets/new_custom_slider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import '../controllers/stimulus_controller.dart';

class NewTensSettings extends StatefulWidget {
  //final Function update;
  const NewTensSettings({Key? key}) : super(key: key);

  @override
  State<NewTensSettings> createState() => _NewTensSettingsState();
}

class _NewTensSettingsState extends State<NewTensSettings> {
  final StimulusController _stimController = Get.find();
  final BluetoothController _bleController = Get.find();

  bool _isOn = false;
  String stimulus = "tens";

  @override
  Widget build(BuildContext context) {
    String amp = _stimController.tensAmp;
    String period = _stimController.tensPeriod;
    String ch1 = _stimController.tensDurCh1;
    String ch2 = _stimController.tensDurCh2;
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 40.0),
      child: Container(
        //color: Colors.purple,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20,),

            Container(
              width: 150,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.4),
                borderRadius: BorderRadius.circular(5.0)
              ),
            ),
            const SizedBox(height: 20,),
            const Text("TENS", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
            const SizedBox(height: 10,),
            Expanded(
              child: Container(
                //color: Colors.blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomSlider(
                      title: 'Amplitude\n',
                      currentValue: _stimController.getStimulus(amp),
                      stimulusType: amp,
                      stimulus: stimulus,
                    ),
                    CustomSlider(
                      title: 'Period\n',
                      currentValue: _stimController.getStimulus(period),
                      stimulusType: period,
                      stimulus: stimulus,
                    ),
                    CustomSlider(
                      title: ' Duration\nChannel 1',
                      minValue: 0.0,
                      maxValue: 1.0,
                      isDecimal: true,
                      measurementType: "s",
                      currentValue: _stimController.getStimulus(ch1),
                      stimulusType: ch1,
                      stimulus: stimulus,
                      channel: 1,
                    ),
                    CustomSlider(
                      title: ' Duration\nChannel 2',
                      minValue: 0.0,
                      maxValue: 1.0,
                      isDecimal: true,
                      measurementType: "s",
                      currentValue: _stimController.getStimulus(ch2),
                      stimulusType: ch2,
                      stimulus: stimulus,
                      channel: 2,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("0"),
                const SizedBox(width: 5.0,),
                Switch(
                  activeColor: Colors.blue,
                  value: _isOn,
                  onChanged: (bool value) {
                    setState(() {
                      _isOn = value;
                    });

                    if(_isOn){
                      _stimController.setStimulus(_stimController.tensPhase, 180.0);
                    } else {
                      _stimController.setStimulus(_stimController.tensPhase, 0.0);
                    }
                    _bleController.newWriteToDevice("phase");
                  },
                ),
                const SizedBox(width: 5.0,),
                const Text("180")
              ],
            )
          ],
        ),
      ),
    );

  }
}
