import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pain_drain_mobile_app/models/bluetooth.dart';
import 'package:pain_drain_mobile_app/providers/bluetooth_notifier.dart';
import '../models/stimulus.dart';

class CustomVerticalSlider extends ConsumerStatefulWidget {
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

  CustomVerticalSlider({
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
  ConsumerState<CustomVerticalSlider> createState() => _CustomVerticalSliderState();
}

class _CustomVerticalSliderState extends ConsumerState<CustomVerticalSlider> {
  Timer? _throttleTimer; // Timer to throttle the updates
  double? _lastSentValue; // To keep track of the last sent value
  final Stimulus _stimController = Get.find();
  //final Bluetooth _bleController = Get.find();


  @override
  Widget build(BuildContext context) {
    final deviceStatus = ref.watch(bluetoothNotifierProvider);

    return Column(
      children: [
        Expanded(
          child: Obx(() => FlutterSlider(
            step: FlutterSliderStep(
              step: widget.isDecimal ?? false ? 0.1 : 1,
            ),
            values: [widget.currentValue],
            max: widget.maxValue ?? 100.0,
            min: widget.minValue ?? 0.0,
            axis: Axis.vertical,
            disabled: deviceStatus.isCharging,
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
                inactiveDisabledTrackBarColor: Colors.grey
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
              // Throttle updates to avoid sending too many values
              if (_throttleTimer == null || !_throttleTimer!.isActive) {
                // Check if the value is the same as the last sent value to avoid redundancy
                if (_lastSentValue == null || _lastSentValue != lowerValue) {
                  _stimController.setStimulus(widget.stimulusType, lowerValue);
                  setState(() {
                    widget.currentValue = _stimController.getStimulus(widget.stimulusType);
                  });

                  // Set the last sent value
                  _lastSentValue = lowerValue;

                  // Optional: Send the command if needed in real time
                  String command = ref.read(bluetoothNotifierProvider.notifier).getCommand(widget.stimulus);
                  ref.read(bluetoothNotifierProvider.notifier).newWriteToDevice(command);
                }

                // Set the throttle timer to delay the next update
                _throttleTimer = Timer(const Duration(milliseconds: 100), () {
                  // This allows updates after the throttle duration has passed
                });
              }
            },
            onDragCompleted: (handlerIndex, lowerValue, upperValue) {
              // Send the final value once dragging is completed
              String command = ref.read(bluetoothNotifierProvider.notifier).getCommand(widget.stimulus);
              ref.read(bluetoothNotifierProvider.notifier).newWriteToDevice(command);
              _lastSentValue = null; // Reset the last sent value for the next drag event
            },
          ),
          ),
        ),
        Text(widget.title, style: const TextStyle(fontSize: 18),)
      ],
    );
  }
}