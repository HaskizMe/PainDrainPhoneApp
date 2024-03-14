import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pain_drain_mobile_app/controllers/stimulus_controller.dart';
import 'package:pain_drain_mobile_app/screens/new_temperature_screen.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../screens/new_vibration_screen.dart';
import 'custom_draggable_sheet.dart';

class TemperatureSummary extends StatefulWidget {
  final Function update;
  const TemperatureSummary({Key? key, required this.update}) : super(key: key);

  @override
  State<TemperatureSummary> createState() => _TemperatureSummaryState();
}

class _TemperatureSummaryState extends State<TemperatureSummary> {
  final StimulusController _stimulusController = Get.find();
  String temp = "temp";
  IconData? icon;
  Color? iconColor;

  List<Color> colorGradient = [Colors.blue, Colors.blue.shade900];

  //IconData icon = const IconData(0xf672);
  //static const IconData thermometer_snowflake = IconData(0xf865, fontFamily: iconFont, fontPackage: iconFontPackage);
  @override
  Widget build(BuildContext context) {

    if(_stimulusController.getStimulus(temp) == 0){
      icon = null;
    }
    else if(_stimulusController.getStimulus(temp) > 0) {
      icon = const IconData(0xf672, fontFamily: CupertinoIcons.iconFont, fontPackage: CupertinoIcons.iconFontPackage);
      iconColor = Colors.red;
      colorGradient = [Colors.red, Colors.red.shade700, Colors.red.shade900];
    }
    else {
      icon = const IconData(0xf865, fontFamily: CupertinoIcons.iconFont, fontPackage: CupertinoIcons.iconFontPackage);
      iconColor = Colors.blue.shade100;
      colorGradient = [Colors.lightBlue.shade100, Colors.lightBlue.shade300, Colors.lightBlue];
    }

    return InkWell(
      hoverColor: Colors.black.withOpacity(.1),
      borderRadius: BorderRadius.circular(13.0),
      onTap: () {
        showScrollableSheet(context, const NewTemperatureScreen(), widget.update);
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
              CircularPercentIndicator(
                radius: 50.0,
                animation: true,
                animationDuration: 2000,
                animateFromLastPercent: true,
                circularStrokeCap: CircularStrokeCap.round,
                percent: _stimulusController.getStimulus(temp).abs() / 100,
                arcType: ArcType.FULL,
                linearGradient: LinearGradient(colors: colorGradient),
                center: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        icon,
                        color: iconColor,
                        // CupertinoIcons.thermometer_snowflake,
                        // color: Colors.blue,
                      ),
                      const SizedBox(height: 5.0,),

                      Text(
                          "${_stimulusController.getStimulus(temp).toInt()}%",
                        style: const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      // SizedBox(width: 3.0,),
                      // const Icon(
                      //   CupertinoIcons.thermometer_snowflake,
                      //   color: Colors.blue,
                      // ),
                    ]
                ),
                footer: Text("Temperature", style: TextStyle(fontSize: 12.0, color: Colors.white),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
