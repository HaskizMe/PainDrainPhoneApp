import 'package:flutter/material.dart';
import 'package:pain_drain_mobile_app/screens/new_temperature_screen.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../screens/new_vibration_screen.dart';
import 'custom_draggable_sheet.dart';

class TemperatureSummary extends StatefulWidget {
  const TemperatureSummary({Key? key}) : super(key: key);

  @override
  State<TemperatureSummary> createState() => _TemperatureSummaryState();
}

class _TemperatureSummaryState extends State<TemperatureSummary> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.black.withOpacity(.1),
      borderRadius: BorderRadius.circular(13.0),
      onTap: () {
        showScrollableSheet(context, const NewTemperatureScreen());
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
                radius: 50.0,
                percent: 1,
                arcType: ArcType.FULL,
                linearGradient: const LinearGradient(colors: [Colors.black, Colors.red]),
                center: Text("70%"),
                footer: Text("Amplitude", style: TextStyle(fontSize: 12.0),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
