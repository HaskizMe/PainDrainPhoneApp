import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pain_drain_mobile_app/controllers/stimulus_controller.dart';
import 'package:pain_drain_mobile_app/custom_widgets/drop_down_button.dart';
import 'package:pain_drain_mobile_app/custom_widgets/new_custom_slider.dart';

class NewVibrationScreen extends StatefulWidget {
  //final Function(void) update;

  const NewVibrationScreen({Key? key,}) : super(key: key);

  @override
  State<NewVibrationScreen> createState() => _NewVibrationScreenState();
}

class _NewVibrationScreenState extends State<NewVibrationScreen> {
  final StimulusController _stimController = Get.find();
  String stimulus = "vibration";

  @override
  Widget build(BuildContext context) {
    String amp = _stimController.vibeAmp;
    String freq = _stimController.vibeFreq;
    String waveform = _stimController.vibeWaveform;
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 40.0),
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: [
                  CustomSlider(title: 'Amplitude', currentValue: _stimController.getStimulus(amp), stimulusType: amp, stimulus: stimulus,),
                  CustomSlider(title: 'Frequency', currentValue: _stimController.getStimulus(freq), stimulusType: freq, stimulus: stimulus,),
                  CustomSlider(title: 'Waveform', currentValue: _stimController.getStimulus(waveform), stimulusType: waveform, stimulus: stimulus,),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20.0,),
          Align(
            alignment: Alignment(.9, 0),
            child: DropDownBox(selectedItem: _stimController.getCurrentWaveType(), items: _stimController.getAllWaveTypes(), widthSize: 130, dropDownCategory: 'waveTypes',),
          )

        ],
      ),
    );
  }
}
