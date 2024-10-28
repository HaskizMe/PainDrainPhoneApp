import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pain_drain_mobile_app/models/stimulus.dart';
import 'package:pain_drain_mobile_app/widgets/drop_down_button.dart';
import 'package:pain_drain_mobile_app/widgets/vertical_slider.dart';

import '../../../models/bluetooth.dart';
import '../../../widgets/horizontal_slider.dart';

class VibrationPopup extends StatefulWidget {
  const VibrationPopup({Key? key}) : super(key: key);

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
      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 40.0),
      child: Obx(() {
        _bleController.isCharging.value;
        return Column(
          children: [
            // Container and Title at the Top
            Column(
              children: [
                const SizedBox(height: 10),
                Container(
                  width: 150,
                  height: 5,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.4),
                      borderRadius: BorderRadius.circular(5.0)),
                ),
                const SizedBox(height: 20),
                const Text(
                  "VIBRATION",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            // Spacer to push slider to the middle
            const Spacer(),

            // Slider in the middle
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  CustomHorizontalSlider(title: "Frequency", currentValue: _stimController.getStimulus(freq), stimulusType: freq, stimulus: stimulus,
                  ),
                ],
              ),
            ),

            // Spacer below slider if needed
            const Spacer(),
          ],
        );
      }),
    );
  }
}
