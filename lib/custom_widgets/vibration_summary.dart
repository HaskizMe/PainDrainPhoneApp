import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pain_drain_mobile_app/controllers/stimulus_controller.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../controllers/bluetooth_controller.dart';
import '../screens/vibration_popup_screen.dart';
import 'custom_draggable_sheet.dart';

class VibrationSummary extends StatefulWidget {
  final Function update;
  const VibrationSummary({Key? key, required this.update}) : super(key: key);

  @override
  State<VibrationSummary> createState() => _VibrationSummaryState();
}

class _VibrationSummaryState extends State<VibrationSummary> {
  StimulusController _stimController = Get.find();
  final BluetoothController _bleController = Get.find();

  //String amp = "vibeIntensity";
  String freq = "vibeFreq";
  String waveform = "vibeWaveform";

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.black.withOpacity(.1),
      borderRadius: BorderRadius.circular(13.0),
      onTap: () {
        showScrollableSheet(context, const VibrationScreen(), widget.update);
      },
      child: Obx(() {
        _bleController.isCharging.value;
          return Card(
            elevation: 10.0,
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10.0),
                  gradient: LinearGradient(colors: [Colors.blue, Colors.blue.shade700,Colors.blue.shade800]),

            ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircularPercentIndicator(
                    animation: true,
                    animateFromLastPercent: true,
                    animationDuration: 2000,
                    radius: 30.0,
                    circularStrokeCap: CircularStrokeCap.round,
                    percent: _stimController.getStimulus(_stimController.vibeIntensity) / 100,
                    arcType: ArcType.FULL,
                    linearGradient: LinearGradient(colors: [Colors.yellow, Colors.yellow.shade700, Colors.yellow.shade900]),
                    center: Text("${_stimController.getStimulus(_stimController.vibeIntensity).toInt()}%", style: const TextStyle(color: Colors.white),),
                    footer: const Text("Intensity", style: TextStyle(fontSize: 12.0, color: Colors.white),),
                  ),
                  CircularPercentIndicator(
                    animation: true,
                    animateFromLastPercent: true,
                    animationDuration: 2000,
                    radius: 30.0,
                    circularStrokeCap: CircularStrokeCap.round,
                    percent: _stimController.getStimulus(freq) / 100,
                    linearGradient: LinearGradient(colors: [Colors.yellow, Colors.yellow.shade700, Colors.yellow.shade900]),
                    arcType: ArcType.FULL,
                    center: Text("${_stimController.getStimulus(freq).toInt()}%", style: TextStyle(color: Colors.white)),
                    footer: const Text("Frequency", style: TextStyle(fontSize: 12.0, color: Colors.white),),
                  ),
                  // CircularPercentIndicator(
                  //   animation: true,
                  //   animateFromLastPercent: true,
                  //   animationDuration: 2000,
                  //   radius: 30.0,
                  //   circularStrokeCap: CircularStrokeCap.round,
                  //   backgroundColor: Colors.grey,
                  //   percent: _stimController.getStimulus(waveform) / 100,
                  //   linearGradient: LinearGradient(colors: [Colors.yellow, Colors.yellow.shade700, Colors.yellow.shade900]),
                  //   arcType: ArcType.FULL,
                  //   center: Text("${_stimController.getStimulus(waveform).toInt()}%", style: TextStyle(color: Colors.white)),
                  //   footer: const Text("Waveform", style: TextStyle(fontSize: 12.0, color: Colors.white),),
                  // ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
