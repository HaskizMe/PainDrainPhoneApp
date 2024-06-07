import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pain_drain_mobile_app/controllers/stimulus_controller.dart';
import 'package:pain_drain_mobile_app/custom_widgets/drop_down_button.dart';
import 'package:pain_drain_mobile_app/custom_widgets/custom_slider.dart';

import '../controllers/bluetooth_controller.dart';

class VibrationScreen extends StatefulWidget {
  //final Function(void) update;

  const VibrationScreen({Key? key,}) : super(key: key);

  @override
  State<VibrationScreen> createState() => _VibrationScreenState();
}

class _VibrationScreenState extends State<VibrationScreen> {
  final StimulusController _stimController = Get.find();
  final BluetoothController _bleController = Get.find();
  String stimulus = "vibration";

  @override
  Widget build(BuildContext context) {
    String amp = _stimController.vibeIntensity;
    String freq = _stimController.vibeFreq;
    String waveform = _stimController.vibeWaveform;
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 40.0),
      child: Obx(() {
        _bleController.isCharging.value;
          return Column(
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
              const Text("VIBRATION", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),

              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: [
                    CustomSlider(title: 'Intensity', currentValue: _stimController.getStimulus(amp), stimulusType: amp, stimulus: stimulus,),
                    CustomSlider(title: 'Frequency', currentValue: _stimController.getStimulus(freq), stimulusType: freq, stimulus: stimulus,),
                    //CustomSlider(title: 'Waveform', currentValue: _stimController.getStimulus(waveform), stimulusType: waveform, stimulus: stimulus,),
                  ],
                ),
              ),
              // const SizedBox(height: 20.0,),
              // Align(
              //   alignment: Alignment(.9, 0),
              //   child: DropDownBox(selectedItem: _stimController.getCurrentWaveType(), items: _stimController.getAllWaveTypes(), widthSize: 130, dropDownCategory: 'waveTypes',),
              // )

            ],
          );
        }
      ),
    );
  }
}
