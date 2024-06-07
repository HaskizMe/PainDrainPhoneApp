import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

import '../controllers/bluetooth_controller.dart';
import '../controllers/stimulus_controller.dart';

class TempSlider extends StatefulWidget {
  double currentValue;

  TempSlider({Key? key, required this.currentValue}) : super(key: key);

  @override
  State<TempSlider> createState() => _TempSliderState();
}

class _TempSliderState extends State<TempSlider> {
  final StimulusController _stimController = Get.find();
  final BluetoothController _bleController = Get.find();

  final double _minValue = -100;
  final double _maxValue = 100;
  Color trackBarColor = Colors.grey;
  Color thumbSlider = Colors.grey;

  @override
  Widget build(BuildContext context) {
    if(widget.currentValue < 0){
      trackBarColor = Colors.blue;
      thumbSlider = Colors.blue;
    }
    else if(widget.currentValue > 0) {
      trackBarColor = Colors.red;
      thumbSlider = Colors.red;
    }
    else {
      trackBarColor = Colors.grey;
      thumbSlider = Colors.grey;
    }
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Obx(() => FlutterSlider(
        values: [widget.currentValue],
        max: _maxValue,
        min: _minValue,
        disabled: _bleController.isCharging.value,
        centeredOrigin: true,
        handlerWidth: 40.0,
        handlerHeight: 40.0,
        touchSize: 5,
        trackBar: FlutterSliderTrackBar(
            activeTrackBar: BoxDecoration(
                color: trackBarColor,
                borderRadius: BorderRadius.circular(5.0)
            ),
            activeTrackBarHeight: 10.0,
            inactiveTrackBarHeight: 8.0,
            inactiveTrackBar: BoxDecoration(
                color: Colors.grey.withOpacity(.4),
                borderRadius: BorderRadius.circular(5.0)
            ),
            inactiveDisabledTrackBarColor: Colors.grey
        ),
        handler: FlutterSliderHandler(
            child: Text("${widget.currentValue.toInt()}%", style: const TextStyle(color: Colors.white)),
            decoration: BoxDecoration(
                color: thumbSlider,
                borderRadius: BorderRadius.circular(50.0)
            ),
            disabled: false
        ),
        tooltip: FlutterSliderTooltip(
            disabled: true
        ),
        onDragging: (handlerIndex, lowerValue, upperValue) {
          if(lowerValue == 0) {
            thumbSlider = Colors.grey;
          }
          else if (lowerValue < 0) {
            trackBarColor = Colors.blueAccent;
            thumbSlider = Colors.blueAccent;
          }
          else {
            trackBarColor = Colors.red;
            thumbSlider = Colors.red;
          }
          _stimController.setStimulus("temp", lowerValue);
          setState(() {
            widget.currentValue = lowerValue;
          });
        },
        onDragCompleted: (handlerIndex, lowerValue, upperValue) {
          String command = _bleController.getCommand("temperature");
          _bleController.newWriteToDevice(command);
        },
      )
      ),
    );
  }
}
