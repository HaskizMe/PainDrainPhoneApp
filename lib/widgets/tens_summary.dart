import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pain_drain_mobile_app/screens/TENS_settings.dart';
import 'package:pain_drain_mobile_app/screens/new_tens_screen.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'custom_draggable_sheet.dart';

class TensSummary extends StatefulWidget {
  const TensSummary({Key? key}) : super(key: key);

  @override
  State<TensSummary> createState() => _TensSummaryState();
}

class _TensSummaryState extends State<TensSummary> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showScrollableSheet(context, NewTensSettings());
      },
      child: Card(
        elevation: 10.0,
        child: Container(
          height: 150,
          //width: 400,
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
                footer: Text("Period", style: TextStyle(fontSize: 12.0),),

              ),
              CircularPercentIndicator(
                radius: 30.0,
                percent: .5,
                progressColor: Colors.red,
                arcType: ArcType.FULL,
                center: Text("70%"),
                footer: Text("Channel 1", style: TextStyle(fontSize: 12.0),),

              ),
              CircularPercentIndicator(
                radius: 30.0,
                percent: .5,
                progressColor: Colors.red,
                arcType: ArcType.FULL,
                center: Text("70%"),
                footer: Text("Channel 2", style: TextStyle(fontSize: 12.0),),

              ),
            ],
          ),
        ),
      ),
    );
  }
}
