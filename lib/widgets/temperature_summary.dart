import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class TemperatureSummary extends StatefulWidget {
  const TemperatureSummary({Key? key}) : super(key: key);

  @override
  State<TemperatureSummary> createState() => _TemperatureSummaryState();
}

class _TemperatureSummaryState extends State<TemperatureSummary> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10.0)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircularPercentIndicator(
            radius: 50.0,
            arcType: ArcType.FULL,
            percent: 1,
            animation: true,
            animationDuration: 1000,
            linearGradient: LinearGradient(
                colors: [
                  Colors.black,
                  Colors.red
                ]

            ),
            center: Text(
                "70%"
            ),
            footer: Text(
              "Amplitude",
              style:
              TextStyle(fontSize: 12.0),
            ),
          ),
        ],
      ),
    );
  }
}
