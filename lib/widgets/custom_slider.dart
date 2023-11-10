import 'package:flutter/material.dart';
class CustomSlider extends StatefulWidget {
  final double min;
  final double max;
  final int divisions;
  final Function handleSliderChange;
  final double trackHeight;
  final Color activeTrackColor;
  final Color inactiveTrackColor;
  final Color thumbColor;
  final double thumbRadius;
  final String sliderName;
  final String sliderLabel;
  final int? channel;
  final String valueLabel;
  double value;

  CustomSlider({Key? key,
    required this.min,
    required this.max,
    required this.divisions,
    required this.handleSliderChange,
    required this.value,
    required this.trackHeight,
    required this.activeTrackColor,
    required this.inactiveTrackColor,
    required this.thumbColor,
    required this.thumbRadius,
    required this.sliderName,
    required this.sliderLabel,
    required this.valueLabel,
    required this.channel
  }) : super(key: key);

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  @override
  Widget build(BuildContext context) {
    return SliderTheme(
        data: SliderThemeData(
          trackHeight: widget.trackHeight,
          activeTrackColor: widget.activeTrackColor,
          inactiveTrackColor: widget.inactiveTrackColor,
          thumbColor: widget.thumbColor,
          thumbShape: RoundSliderThumbShape(
            enabledThumbRadius: widget.thumbRadius, // Adjust the radius as needed
          ),// Make ticks invisible
        ),
        child: SizedBox(
          width: 100,
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    RotatedBox(
                      quarterTurns: -1,
                      child: Slider(
                          value: widget.value,
                          min: widget.min,
                          max: widget.max,
                          divisions: widget.divisions,
                        onChanged: (newValue) {
                          setState(() {
                            widget.value = double.parse(newValue.toStringAsFixed(1));
                            //globalValues.setSliderValue('amplitude', newValue);
                            newValue = widget.value;
                            //widget.value = newValue;
                            print("slider name: ${widget.sliderName}");
                            widget.handleSliderChange(newValue, widget.sliderName, widget.channel);
                          });
                        },
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: IgnorePointer(
                          ignoring: true,
                          child: Text(
                            widget.valueLabel,
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
              Text(
                widget.sliderLabel,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,

                ),
              ),
            ],
          ),
        )
    );
  }
}
