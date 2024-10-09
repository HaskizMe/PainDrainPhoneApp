import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pain_drain_mobile_app/models/stimulus.dart';
import 'package:pain_drain_mobile_app/widgets/drop_down_button.dart';
import 'package:pain_drain_mobile_app/widgets/vertical_slider.dart';

import '../../../models/bluetooth.dart';

class VibrationPopup extends StatefulWidget {
  //final Function(void) update;

  const VibrationPopup({Key? key,}) : super(key: key);

  @override
  State<VibrationPopup> createState() => _VibrationPopupState();
}

class _VibrationPopupState extends State<VibrationPopup> {
  final Stimulus _stimController = Get.find();
  final Bluetooth _bleController = Get.find();
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
            const Text("VIBRATION", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
            const SizedBox(height: 20,),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: [
                  CustomVerticalSlider(title: 'Intensity', currentValue: _stimController.getStimulus(amp), stimulusType: amp, stimulus: stimulus,),
                  CustomVerticalSlider(title: 'Frequency', currentValue: _stimController.getStimulus(freq), stimulusType: freq, stimulus: stimulus,),
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