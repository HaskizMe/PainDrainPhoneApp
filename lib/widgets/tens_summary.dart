import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pain_drain_mobile_app/controllers/stimulus_controller.dart';
import 'package:pain_drain_mobile_app/screens/TENS_settings.dart';
import 'package:pain_drain_mobile_app/screens/new_tens_screen.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'custom_draggable_sheet.dart';

class TensSummary extends StatefulWidget {
  final Function update;
  const TensSummary({Key? key, required this.update}) : super(key: key);

  @override
  State<TensSummary> createState() => _TensSummaryState();
}

class _TensSummaryState extends State<TensSummary> {
  final StimulusController _stimController = Get.find();
  String amp = "tensAmp";
  String period = "tensPeriod";
  String ch1 = "tensDurCh1";
  String ch2 = "tensDurCh2";

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.black.withOpacity(.1),
      borderRadius: BorderRadius.circular(13.0),
      onTap: () {
        showScrollableSheet(context, const NewTensSettings(), widget.update);
      },
      child: Card(
        elevation: 10.0,
        child: Container(
          height: 150,
          //width: 400,
          decoration: BoxDecoration(
            //color: Colors.blue,
            gradient: LinearGradient(colors: [Colors.blue, Colors.blue.shade700,Colors.blue.shade800]),
            borderRadius: BorderRadius.circular(10.0)
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircularPercentIndicator(
                radius: 30.0,
                animation: true,
                animationDuration: 2000,
                animateFromLastPercent: true,
                circularStrokeCap: CircularStrokeCap.round,
                percent: _stimController.getStimulus(amp) / 100,
                arcType: ArcType.FULL,
                linearGradient: LinearGradient(colors: [Colors.yellow, Colors.yellow.shade700, Colors.yellow.shade900]),
                center: Text("${_stimController.getStimulus(amp).toInt()}%", style: const TextStyle(color: Colors.white),),
                footer: const Text("Amplitude", style: TextStyle(fontSize: 12.0, color: Colors.white),),
              ),
              CircularPercentIndicator(
                radius: 30.0,
                animation: true,
                animationDuration: 2000,
                animateFromLastPercent: true,
                circularStrokeCap: CircularStrokeCap.round,
                percent: _stimController.getStimulus(period) / 100,
                linearGradient: LinearGradient(colors: [Colors.yellow, Colors.yellow.shade700, Colors.yellow.shade900]),
                arcType: ArcType.FULL,
                center: Text("${_stimController.getStimulus(period).toInt()}%", style: const TextStyle(color: Colors.white)),
                footer: const Text("Period", style: TextStyle(fontSize: 12.0, color: Colors.white),),

              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularPercentIndicator(
                    radius: 30.0,
                    animation: true,
                    animationDuration: 2000,
                    animateFromLastPercent: true,
                    circularStrokeCap: CircularStrokeCap.round,
                    percent: _stimController.getStimulus(ch1),
                    linearGradient: LinearGradient(colors: [Colors.yellow, Colors.yellow.shade700, Colors.yellow.shade900]),
                    arcType: ArcType.FULL,
                    center: Text("${_stimController.getStimulus(ch1)}s", style: const TextStyle(color: Colors.white)),
                    footer: const Text("Channel 1", style: TextStyle(fontSize: 12.0, color: Colors.white),),
                  ),
                  if(_stimController.getCurrentChannel() == 1)
                    Column(
                      children: [
                        SizedBox(height: 5.0,),
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.green
                          ),
                        )
                      ],
                    )
                  // //SizedBox(height: 10.0,),
                  // Container(
                  //   width: 10,
                  //   height: 10,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(10.0),
                  //     color: Colors.green
                  //   ),
                  // )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  CircularPercentIndicator(
                    radius: 30.0,
                    animation: true,
                    animationDuration: 2000,
                    animateFromLastPercent: true,
                    circularStrokeCap: CircularStrokeCap.round,
                    percent: _stimController.getStimulus(ch2),
                    linearGradient: LinearGradient(colors: [Colors.yellow, Colors.yellow.shade700, Colors.yellow.shade900]),
                    arcType: ArcType.FULL,
                    center: Text("${_stimController.getStimulus(ch2)}s", style: const TextStyle(color: Colors.white)),
                    footer: const Text("Channel 2", style: TextStyle(fontSize: 12.0, color: Colors.white),),
                  ),
                  if(_stimController.getCurrentChannel() == 2)
                    Column(
                      children: [
                        SizedBox(height: 5.0,),
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.green
                          ),
                        )
                      ],
                    )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
