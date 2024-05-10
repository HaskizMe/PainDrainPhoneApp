import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pain_drain_mobile_app/controllers/bluetooth_controller.dart';
import '../controllers/stimulus_controller.dart';

class CustomSlider extends StatefulWidget {
  final String title;
  final double? minValue;
  final double? maxValue;
  final bool? isDecimal;
  final String? measurementType;
  double currentValue;
  final String stimulusType;
  final String stimulus;
  final int? channel;
  //final Function(void) update;

  CustomSlider({
    Key? key,
    required this.title,
    this.minValue,
    this.maxValue,
    this.isDecimal,
    this.measurementType,
    required this.currentValue,
    required this.stimulusType,
    required this.stimulus,
    this.channel,
  }) : super(key: key);

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  final StimulusController _stimController = Get.find();
  final BluetoothController _bleController = Get.find();


  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.red,
      child: Expanded(
        child: Column(
          children: [
            Expanded(
              child: FlutterSlider(
                step: FlutterSliderStep(
                  step: widget.isDecimal ?? false ? 0.1 : 1,
                ),
                values: [widget.currentValue],
                max: widget.maxValue ?? 100.0,
                min: widget.minValue ?? 0.0,
                axis: Axis.vertical,
                rtl: true,
                //centeredOrigin: true,
                handlerWidth: 40.0,
                handlerHeight: 40.0,
                touchSize: 5,
                trackBar: FlutterSliderTrackBar(
                    activeTrackBar: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(5.0)
                    ),
                    activeTrackBarHeight: 10.0,
                    inactiveTrackBarHeight: 8.0,

                    inactiveTrackBar: BoxDecoration(
                        color: Colors.grey.withOpacity(.4),
                        borderRadius: BorderRadius.circular(5.0)

                    ),
                    inactiveDisabledTrackBarColor: Colors.blue
                ),
                handler: FlutterSliderHandler(
                    child: Text(
                      (widget.currentValue % 1 == 0) // Check if the fractional part equals 0
                          ? "${widget.currentValue.toInt()}${widget.measurementType ?? "%"}" // Drop decimal part if it's ".0"
                          : "${widget.currentValue}${widget.measurementType ?? "%"}", // Otherwise, keep the decimal part
                      style: const TextStyle(color: Colors.white),
                    ),

                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(50.0)
                    )
                ),
                tooltip: FlutterSliderTooltip(
                    disabled: true
                ),
                onDragging: (handlerIndex, lowerValue, upperValue) {
                  _stimController.setStimulus(widget.stimulusType, lowerValue);
                  // _bleController.newWriteToDevice(widget.stimulus);
                  setState(() {
                    widget.currentValue = lowerValue;
                  });
                },
                onDragCompleted: (handlerIndex, lowerValue, upperValue) {
                  if(widget.channel != null){
                    _stimController.setCurrentChannel(widget.channel!);
                    //_bleController.newWriteToDevice(widget.stimulus);
                    String command = _bleController.getCommand(widget.stimulus);
                    _bleController.newWriteToDevice(command);
                  } else{
                    String command = _bleController.getCommand(widget.stimulus);
                    _bleController.newWriteToDevice(command);
                    //_bleController.newWriteToDevice(widget.stimulus);
                  }
                },
              ),
            ),


            // SfSliderTheme(
            //   data: SfSliderThemeData(
            //       activeTrackColor: Colors.blue,
            //       inactiveTrackColor: Colors.blue.withOpacity(.2),
            //       thumbColor: Colors.blue,
            //       activeTrackHeight: 20,
            //       inactiveTrackHeight: 10,
            //       thumbRadius: 20
            //   ),
            //   child: Expanded(
            //     child: SfSlider.vertical(
            //       enableTooltip: false,
            //       min: widget.minValue ?? 0.0,
            //       max: widget.maxValue ?? 100.0,
            //       value: widget.currentValue,
            //       //interval: 100,
            //       thumbIcon: Center(
            //           child: Text(
            //             "${widget.currentValue}${widget.measurementType ?? '%'}",
            //             style: const TextStyle(color: Colors.white),
            //           )
            //       ),
            //       showLabels: false,
            //       onChanged: (dynamic value) {
            //         setState(() {
            //           // place update function
            //           if(widget.isDecimal == null || widget.isDecimal == false){
            //             widget.currentValue = value.round();
            //           }
            //           else {
            //             widget.currentValue = (value * 10).roundToDouble() / 10;
            //           }
            //           stimController.setStimulus(widget.stimulus, widget.currentValue);
            //         });
            //       },
            //     ),
            //   ),
            // ),
            Text(widget.title)
          ],
        ),
      ),
    );
  }
}
