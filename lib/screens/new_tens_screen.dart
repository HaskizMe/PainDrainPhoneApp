import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pain_drain_mobile_app/widgets/new_custom_slider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import '../controllers/stimulus_controller.dart';

class NewTensSettings extends StatefulWidget {
  const NewTensSettings({Key? key}) : super(key: key);

  @override
  State<NewTensSettings> createState() => _NewTensSettingsState();
}

class _NewTensSettingsState extends State<NewTensSettings> {
  StimulusController stimController = Get.find();

  double _value = 00.0;
  bool _isSwitched = false;
  String amp = "tensAmp";
  String period = "tensPeriod";
  String ch1 = "tensDurCh1";
  String ch2 = "tensDurCh2";


  @override
  Widget build(BuildContext context) {
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
            SizedBox(height: 20,),
            Text("TENS", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Expanded(
              child: Container(
                //color: Colors.blue,
                child: Row(
                  children: [
                    CustomSlider(title: 'Amplitude\n', currentValue: stimController.getStimulus(amp), stimulus: amp,),
                    CustomSlider(title: 'Period\n', currentValue: stimController.getStimulus(period), stimulus: period,),
                    CustomSlider(title: ' Duration\nChannel 1', minValue: 0.0, maxValue: 1.0, isDecimal: true, measurementType: "s", currentValue: stimController.getStimulus(ch1), stimulus: ch1,),
                    CustomSlider(title: ' Duration\nChannel 2', minValue: 0.0, maxValue: 1.0, isDecimal: true, measurementType: "s", currentValue: stimController.getStimulus(ch2), stimulus: ch2,),
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
                  value: _isSwitched,
                  onChanged: (bool value) {
                    setState(() {
                      _isSwitched = value;
                    });
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
