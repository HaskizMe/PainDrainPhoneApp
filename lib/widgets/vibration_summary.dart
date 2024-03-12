import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../screens/new_tens_screen.dart';
import '../screens/new_vibration_screen.dart';
import 'custom_draggable_sheet.dart';

class VibrationSummary extends StatefulWidget {
  const VibrationSummary({Key? key}) : super(key: key);

  @override
  State<VibrationSummary> createState() => _VibrationSummaryState();
}

class _VibrationSummaryState extends State<VibrationSummary> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showScrollableSheet(context, NewVibrationScreen());
      },
      child: Card(
        elevation: 10.0,
        child: Container(
          height: 150,
          decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10.0)
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircularPercentIndicator(
                radius: 30.0,
                percent: .9,
                arcType: ArcType.FULL,
                linearGradient: LinearGradient(colors: [Colors.yellow, Colors.red]),
                center: Text("70%"),
                footer: Text("Amplitude", style: TextStyle(fontSize: 12.0),),
              ),
              CircularPercentIndicator(
                radius: 30.0,
                percent: .5,
                progressColor: Colors.red,
                arcType: ArcType.FULL,
                center: Text("70%"),
                footer: Text("Frequency", style: TextStyle(fontSize: 12.0),),
              ),
              CircularPercentIndicator(
                radius: 30.0,
                percent: .5,
                progressColor: Colors.red,
                arcType: ArcType.FULL,
                center: Text("70%"),
                footer: Text("Waveform", style: TextStyle(fontSize: 12.0),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
