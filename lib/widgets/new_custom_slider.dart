import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../controllers/stimulus_controller.dart';

class CustomSlider extends StatefulWidget {
  final String title;
  final double? minValue;
  final double? maxValue;
  final bool? isDecimal;
  final String? measurementType;
  double currentValue;
  final String stimulus;

  CustomSlider({
    Key? key,
    required this.title,
    this.minValue,
    this.maxValue,
    this.isDecimal,
    this.measurementType,
    required this.currentValue,
    required this.stimulus
  }) : super(key: key);

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  StimulusController stimController = Get.find();

  //double _value = 00.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.blue,
      child: Expanded(
        child: Column(
          children: [
            SfSliderTheme(
              data: SfSliderThemeData(
                  activeTrackColor: Colors.blue,
                  inactiveTrackColor: Colors.blue.withOpacity(.2),
                  thumbColor: Colors.blue,
                  activeTrackHeight: 20,
                  inactiveTrackHeight: 10,
                  thumbRadius: 20
              ),
              child: Expanded(
                child: SfSlider.vertical(
                  enableTooltip: false,
                  min: widget.minValue ?? 0.0,
                  max: widget.maxValue ?? 100.0,
                  value: widget.currentValue,
                  //interval: 100,
                  thumbIcon: Center(
                      child: Text(
                        "${widget.currentValue}${widget.measurementType ?? '%'}",
                        style: const TextStyle(color: Colors.white),
                      )
                  ),
                  showLabels: false,
                  onChanged: (dynamic value) {
                    setState(() {
                      if(widget.isDecimal == null || widget.isDecimal == false){
                        widget.currentValue = value.round();
                      }
                      else {
                        widget.currentValue = (value * 10).roundToDouble() / 10;
                      }
                      stimController.setStimulus(widget.stimulus, widget.currentValue);
                      setState(() {});
                    });
                  },
                ),
              ),
            ),
            Text(widget.title)
          ],
        ),
      ),
    );
  }
}
