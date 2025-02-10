import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pain_drain_mobile_app/providers/vibration_notifier.dart';
import 'package:pain_drain_mobile_app/widgets/drop_down_button.dart';
import 'package:pain_drain_mobile_app/widgets/vertical_slider.dart';
import '../../../providers/bluetooth_notifier.dart';
import '../../../widgets/horizontal_slider.dart';

class VibrationPopup extends ConsumerStatefulWidget {
  const VibrationPopup({Key? key}) : super(key: key);

  @override
  ConsumerState<VibrationPopup> createState() => _VibrationPopupState();
}

class _VibrationPopupState extends ConsumerState<VibrationPopup> {
  //final Stimulus _stimController = Get.find();
  //final Bluetooth _bleController = Get.find();
  String stimulus = "vibration";

  @override
  Widget build(BuildContext context) {
    // String amp = _stimController.vibeIntensity;
    // String freq = _stimController.vibeFreq;
    // String waveform = _stimController.vibeWaveform;
    final vibe = ref.watch(vibrationNotifierProvider);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 40.0),
      child: Column(
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
                  StimulusSlider(
                    title: "Vibration Intensity",
                    minValue: 0.0,
                    maxValue: 100.0,
                    isDecimal: false,
                    measurementType: "%",
                    initialValue: vibe.frequency.toDouble(), // initial value for vibration.
                    onValueChanged: (newValue) {
                      ref.read(vibrationNotifierProvider.notifier).updateVibration(freq: newValue.toInt());
                    },
                    onDragCompleted: () {
                      print("Vibration slider drag completed.");
                    },
                    getCommand: (value) {
                      return ref.read(bluetoothNotifierProvider.notifier).getCommand("vibration");
                    },
                  )

                ],
              ),
            ),

            // Spacer below slider if needed
            const Spacer(),
          ],
        )
    );
  }
}
