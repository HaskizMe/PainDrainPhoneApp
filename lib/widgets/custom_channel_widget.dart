import 'package:flutter/material.dart';
import 'package:pain_drain_mobile_app/main.dart';
typedef HandleSliderChange = void Function(double value, String stimulus);

class ChannelWidget extends StatefulWidget {
  double sliderValuePeriod;
  double sliderValueDuration;
  double sliderValueAmplitude;
  Function handleSliderChange;
  double height;
  double width;
  //Color color;
  int channel;
  ChannelWidget({Key? key,
    required this.sliderValuePeriod,
    required this.sliderValueDuration,
    required this.sliderValueAmplitude,
    required this.handleSliderChange,
    required this.height,
    required this.width,
    //required this.color,
    required this.channel,
  }) : super(key: key);

  @override
  State<ChannelWidget> createState() => _ChannelWidgetState();
}

class _ChannelWidgetState extends State<ChannelWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20.0,
      color: Colors.grey[700],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        //color: widget.color,
        height: widget.height,
        width: widget.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              //color: Colors.black,
              height: MediaQuery.of(context).size.height * .29,
              width: 100,
              child: Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        RotatedBox(
                          quarterTurns: -1,
                          child: Slider(
                            value: widget.sliderValueAmplitude,
                            min: 0,
                            max: 100,
                            onChanged: (newValue) {
                              setState(() {
                                //globalValues.setSliderValue('amplitude', newValue);
                                widget.handleSliderChange(newValue, globalValues.tensAmplitude, widget.channel);
                              });
                            },
                            //label: sliderValueAmplitude.round().abs().toString(),
                            divisions: 20,

                          ),
                        ),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.center,
                            child: IgnorePointer(
                              ignoring: true,
                              child: Text(
                                '${widget.sliderValueAmplitude.round()}%',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Amplitude',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,

                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * .29,
              width: 100,
              child: Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        RotatedBox(
                          quarterTurns: -1,
                          child: Slider(
                            value: widget.sliderValueDuration,
                            min: 0.1,
                            max: 1.0,
                            onChanged: (newValue) {
                              setState(() {
                                widget.sliderValueDuration = double.parse(newValue.toStringAsFixed(1));
                                newValue = widget.sliderValueDuration;
                                widget.handleSliderChange(newValue, 'tensDuration', widget.channel);
                              });
                            },
                            divisions: 9,
                          ),
                        ),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.center,
                            child: IgnorePointer(
                              ignoring: true,
                              child: Text(
                                '${widget.sliderValueDuration}s',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Duration',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,

                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * .29,
              width: 100,
              child: Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        RotatedBox(
                          quarterTurns: -1,
                          child: Slider(
                            value: widget.sliderValuePeriod,
                            min: 0.5,
                            max: 10,
                            divisions: (10.0 - 0.5) ~/ 0.5,
                            onChanged: (newValue) {
                              setState(() {
                                //globalValues.setSliderValue('amplitude', newValue);
                                widget.handleSliderChange(newValue, 'tensPeriod', widget.channel);
                              });
                              // Makes a command string for the vibration
                              // String stringCommand = "v ${globalValues.getWaveType().toLowerCase()} ${newValue.round()} ${sliderValueFrequency.toInt()} ${sliderValueWaveform.toInt()}";
                              // List<int> hexValue = bluetoothController.stringToHexList(stringCommand);
                              // print(stringCommand);
                              // bluetoothController.writeToDevice("vibration", hexValue);
                            },

                          ),
                        ),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.center,
                            child: IgnorePointer(
                              ignoring: true,
                              child: Text(
                                '${widget.sliderValuePeriod}s',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Period',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,

                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        // Your custom widget content
      ),
    );
  }
}
