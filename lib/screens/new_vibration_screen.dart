import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pain_drain_mobile_app/controllers/stimulus_controller.dart';
import 'package:pain_drain_mobile_app/widgets/drop_down_button.dart';

import 'package:pain_drain_mobile_app/widgets/new_custom_slider.dart';

class NewVibrationScreen extends StatefulWidget {
  const NewVibrationScreen({Key? key}) : super(key: key);

  @override
  State<NewVibrationScreen> createState() => _NewVibrationScreenState();
}

class _NewVibrationScreenState extends State<NewVibrationScreen> {
  StimulusController stimController = Get.find();
  String amp = "vibeAmp";
  String freq = "vibeFreq";
  String waveform = "vibeWaveform";

  List<String>? waveForms = ["Sine", "Square", "Sawtooth", "Triangle"];

  @override
  Widget build(BuildContext context) {
    String? selectedItem = waveForms?.first;
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 40.0),
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
            Text("VIBRATION", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),

            Expanded(
              child: Container(
                //color: Colors.blue,
                child: Row(
                  children: [
                    CustomSlider(title: 'Amplitude', currentValue: stimController.getStimulus(amp), stimulus: amp,),
                    CustomSlider(title: 'Frequency', currentValue: stimController.getStimulus(freq), stimulus: freq,),
                    CustomSlider(title: 'Waveform', currentValue: stimController.getStimulus(waveform), stimulus: waveform,),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20.0,),
            Align(
              alignment: Alignment(.9, 0),
              child: DropDownBox(selectedItem: stimController.getCurrentWaveType(), items: stimController.getAllWaveTypes(), widthSize: 130, dropDownCategory: 'waveTypes',),
            )

          ],
        ),
      ),
    );
  }
}
