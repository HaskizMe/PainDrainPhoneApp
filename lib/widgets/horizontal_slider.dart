// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_xlider/flutter_xlider.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
// import 'package:pain_drain_mobile_app/providers/bluetooth_notifier.dart';
//
// import '../models/bluetooth.dart';
// import '../models/stimulus.dart';
//
// class CustomHorizontalSlider extends ConsumerStatefulWidget {
//   final String title;
//   final double? minValue;
//   final double? maxValue;
//   final bool? isDecimal;
//   final String? measurementType;
//   double currentValue;
//   final String stimulusType;
//   final String stimulus;
//   final int? channel;
//
//   CustomHorizontalSlider({
//     Key? key,
//     required this.title,
//     this.minValue,
//     this.maxValue,
//     this.isDecimal,
//     this.measurementType,
//     required this.currentValue,
//     required this.stimulusType,
//     required this.stimulus,
//     this.channel}) : super(key: key);
//
//   @override
//   ConsumerState<CustomHorizontalSlider> createState() => _CustomHorizontalSliderState();
// }
//
// class _CustomHorizontalSliderState extends ConsumerState<CustomHorizontalSlider> {
//   Timer? _throttleTimer; // Timer to throttle the updates
//   double? _lastSentValue; // To keep track of the last sent value
//   final Stimulus _stimController = Get.find();
//   //final Bluetooth _bleController = Get.find();
//
//   @override
//   Widget build(BuildContext context) {
//     final deviceStatus = ref.watch(bluetoothNotifierProvider);
//
//     return Column(
//       children: [
//         FlutterSlider(
//           step: FlutterSliderStep(
//             step: widget.isDecimal ?? false ? 0.1 : 1,
//           ),
//           values: [widget.currentValue],
//           max: widget.maxValue ?? 100.0,
//           min: widget.minValue ?? 0.0,
//           axis:  Axis.horizontal,
//           disabled: deviceStatus.isCharging,
//           rtl: false,
//           //centeredOrigin: true,
//           handlerWidth: 40.0,
//           handlerHeight: 40.0,
//           touchSize: 5,
//           trackBar: FlutterSliderTrackBar(
//               activeTrackBar: BoxDecoration(
//                   color: Colors.blue,
//                   borderRadius: BorderRadius.circular(5.0)
//               ),
//               activeTrackBarHeight: 10.0,
//               inactiveTrackBarHeight: 8.0,
//
//               inactiveTrackBar: BoxDecoration(
//                   color: Colors.grey.withOpacity(.4),
//                   borderRadius: BorderRadius.circular(5.0)
//
//               ),
//               inactiveDisabledTrackBarColor: Colors.grey
//           ),
//           handler: FlutterSliderHandler(
//               child: Text(
//                 (widget.currentValue % 1 == 0) // Check if the fractional part equals 0
//                     ? "${widget.currentValue.toInt()}${widget.measurementType ?? "%"}" // Drop decimal part if it's ".0"
//                     : "${widget.currentValue}${widget.measurementType ?? "%"}", // Otherwise, keep the decimal part
//                 style: const TextStyle(color: Colors.white),
//               ),
//
//               decoration: BoxDecoration(
//                   color: Colors.blue,
//                   borderRadius: BorderRadius.circular(50.0)
//               )
//           ),
//           tooltip: FlutterSliderTooltip(
//               disabled: true
//           ),
//           onDragging: (handlerIndex, lowerValue, upperValue) {
//             print(lowerValue);
//             // Throttle updates to avoid sending too many values
//             if (_throttleTimer == null || !_throttleTimer!.isActive) {
//               // Check if the value is the same as the last sent value to avoid redundancy
//               if (_lastSentValue == null || _lastSentValue != lowerValue) {
//                 _stimController.setStimulus(widget.stimulusType, lowerValue);
//                 setState(() {
//                   widget.currentValue = _stimController.getStimulus(widget.stimulusType);
//                 });
//
//                 // Set the last sent value
//                 _lastSentValue = lowerValue;
//
//                 // Optional: Send the command if needed in real time
//                 String command = ref.read(bluetoothNotifierProvider.notifier).getCommand(widget.stimulus);
//                 ref.read(bluetoothNotifierProvider.notifier).newWriteToDevice(command);
//               }
//
//               // Set the throttle timer to delay the next update
//               _throttleTimer = Timer(const Duration(milliseconds: 100), () {
//                 // This allows updates after the throttle duration has passed
//               });
//             }
//           },
//           onDragCompleted: (handlerIndex, lowerValue, upperValue) async {
//             // Setting the new stim values
//             _stimController.setStimulus(widget.stimulusType, lowerValue);
//
//             // Show new stim percentage on UI
//             setState(() {
//               widget.currentValue = _stimController.getStimulus(widget.stimulusType);
//             });
//
//             // Send the final value once dragging is completed
//             String command = ref.read(bluetoothNotifierProvider.notifier).getCommand(widget.stimulus);
//             ref.read(bluetoothNotifierProvider.notifier).newWriteToDevice(command);
//             _lastSentValue = null; // Reset the last sent value for the next drag event
//           },
//         ),
//         Text(widget.title, style: const TextStyle(fontSize: 20),)
//       ],
//     );
//   }
// }


import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:pain_drain_mobile_app/providers/bluetooth_notifier.dart';

/// A generic slider widget that can update any stimulus.
/// It receives callbacks to update the value, get the current value, and generate commands.
class StimulusSlider extends ConsumerStatefulWidget {
  final String title;
  final double minValue;
  final double maxValue;
  final bool isDecimal;
  final String measurementType;
  final double initialValue;
  /// Called when the slider value changes (during dragging and at drag completion).
  final ValueChanged<double> onValueChanged;
  /// Called when dragging is completed (if additional work is needed).
  final VoidCallback onDragCompleted;
  /// Generates a command string based on the current value.
  final String Function(double value) getCommand;

  const StimulusSlider({
    Key? key,
    required this.title,
    required this.minValue,
    required this.maxValue,
    required this.isDecimal,
    required this.measurementType,
    required this.initialValue,
    required this.onValueChanged,
    required this.onDragCompleted,
    required this.getCommand,
  }) : super(key: key);

  @override
  ConsumerState<StimulusSlider> createState() => _StimulusSliderState();
}

class _StimulusSliderState extends ConsumerState<StimulusSlider> {
  late double _currentValue;
  Timer? _throttleTimer;
  double? _lastSentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    // For example, disable the slider if Bluetooth device is charging.
    final deviceStatus = ref.watch(bluetoothNotifierProvider);

    return Column(
      children: [
        FlutterSlider(
          step: FlutterSliderStep(step: widget.isDecimal ? 0.1 : 1),
          values: [_currentValue],
          min: widget.minValue,
          max: widget.maxValue,
          axis: Axis.horizontal,
          disabled: deviceStatus.isCharging,
          handlerWidth: 40.0,
          handlerHeight: 40.0,
          trackBar: FlutterSliderTrackBar(
            activeTrackBar: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(5.0),
            ),
            activeTrackBarHeight: 10.0,
            inactiveTrackBarHeight: 8.0,
            inactiveTrackBar: BoxDecoration(
              color: Colors.grey.withOpacity(0.4),
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          handler: FlutterSliderHandler(
            child: Text(
              (_currentValue % 1 == 0)
                  ? "${_currentValue.toInt()}${widget.measurementType}"
                  : "${_currentValue}${widget.measurementType}",
              style: const TextStyle(color: Colors.white),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(50.0),
            ),
          ),
          tooltip: FlutterSliderTooltip(disabled: true),
          onDragging: (handlerIndex, lowerValue, upperValue) {
            // Throttle updates to avoid too many rapid calls.
            if (_throttleTimer == null || !_throttleTimer!.isActive) {
              if (_lastSentValue == null || _lastSentValue != lowerValue) {
                // Call the update callback provided by the parent.
                widget.onValueChanged(lowerValue);
                setState(() {
                  _currentValue = lowerValue;
                });
                _lastSentValue = lowerValue;
                // Optionally, send the command to the Bluetooth notifier.
                final command = widget.getCommand(lowerValue);
                ref.read(bluetoothNotifierProvider.notifier).newWriteToDevice(command);
              }
              _throttleTimer = Timer(const Duration(milliseconds: 100), () {});
            }
          },
          onDragCompleted: (handlerIndex, lowerValue, upperValue) {
            // Final update when dragging is completed.
            widget.onValueChanged(lowerValue);
            setState(() {
              _currentValue = lowerValue;
            });
            final command = widget.getCommand(lowerValue);
            ref.read(bluetoothNotifierProvider.notifier).newWriteToDevice(command);
            _lastSentValue = null; // Reset for the next drag.
            widget.onDragCompleted();
          },
        ),
        Text(widget.title, style: const TextStyle(fontSize: 20)),
      ],
    );
  }
}
