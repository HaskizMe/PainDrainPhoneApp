import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pain_drain_mobile_app/providers/vibration_notifier.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../screens/home/local_widgets/vibration_popup.dart';
import 'custom_draggable_sheet.dart';

class VibrationSummary extends ConsumerStatefulWidget {
  final Function update;
  const VibrationSummary({Key? key, required this.update}) : super(key: key);

  @override
  ConsumerState<VibrationSummary> createState() => _VibrationSummaryState();
}

class _VibrationSummaryState extends ConsumerState<VibrationSummary> {

  @override
  Widget build(BuildContext context) {
    final vibe = ref.watch(vibrationNotifierProvider);

    return InkWell(
      hoverColor: Colors.black.withOpacity(.1),
      borderRadius: BorderRadius.circular(13.0),
      onTap: () {
        showScrollableSheet(context, const VibrationPopup(), widget.update);
      },
      child: Card(
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
              // CircularPercentIndicator(
              //   animation: true,
              //   animateFromLastPercent: true,
              //   animationDuration: 2000,
              //   radius: 30.0,
              //   circularStrokeCap: CircularStrokeCap.round,
              //   percent: _stimController.getStimulus(_stimController.vibeIntensity) / 100,
              //   arcType: ArcType.FULL,
              //   linearGradient: LinearGradient(colors: [Colors.yellow, Colors.yellow.shade700, Colors.yellow.shade900]),
              //   center: Text("${_stimController.getStimulus(_stimController.vibeIntensity).toInt()}%", style: const TextStyle(color: Colors.white),),
              //   footer: const Text("Intensity", style: TextStyle(fontSize: 12.0, color: Colors.white),),
              // ),
              CircularPercentIndicator(
                animation: true,
                animateFromLastPercent: true,
                animationDuration: 2000,
                radius: 30.0,
                circularStrokeCap: CircularStrokeCap.round,
                percent: vibe.frequency / 100,
                linearGradient: LinearGradient(colors: [Colors.yellow, Colors.yellow.shade700, Colors.yellow.shade900]),
                arcType: ArcType.FULL,
                center: Text("${vibe.frequency.toInt()}%", style: const TextStyle(color: Colors.white)),
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
      ),

    );
  }
}
