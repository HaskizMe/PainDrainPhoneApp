import 'package:flutter/material.dart';

import 'package:pain_drain_mobile_app/global_slider_values.dart';
import 'package:pain_drain_mobile_app/scheme_colors/app_colors.dart';


class VibrationSettings extends StatefulWidget {
  const VibrationSettings({Key? key}) : super(key: key);

  @override
  State<VibrationSettings> createState() => _VibrationSettingsState();
}

class _VibrationSettingsState extends State<VibrationSettings> {
  final sliderValuesSingleton = SliderValuesSingleton();

  String _selectedItem = 'Sine';


  @override
  Widget build(BuildContext context) {
    double sliderValueAmplitude = sliderValuesSingleton.getSliderValue('amplitude');
    double sliderValueFrequency = sliderValuesSingleton.getSliderValue('frequency');
    double sliderValueWaveform = sliderValuesSingleton.getSliderValue('waveform');
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Vibration',
          style: TextStyle(
            fontSize: 50,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.grey,
        centerTitle: true,
        toolbarHeight: 90,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.darkGrey, AppColors.offWhite],
          ),
        ),
        child: Center(
          child: SizedBox(
            width: MediaQuery
                .of(context)
                .size
                .width * 0.80,
            child: SliderTheme(
              data: const SliderThemeData(
                trackHeight: 15,
                activeTrackColor: AppColors.orangeRed, // Color of the active portion of the track
                inactiveTrackColor: Colors.grey, // Color of the inactive portion of the track
                thumbColor: AppColors.greyGreen, // Color of the thumb
                overlayColor: AppColors.lightGreen, // Color of the overlay when pressed
                valueIndicatorColor: AppColors.navyBlue, // Color of the value indicator
                tickMarkShape: RoundSliderTickMarkShape(
                    tickMarkRadius: 0
                ),
                thumbShape: RoundSliderThumbShape(
                  enabledThumbRadius: 15.0, // Adjust the radius as needed
                ),// Make ticks invisible
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Slider(
                    value: sliderValueAmplitude,
                    min: 0,
                    max: 10,
                    onChanged: (newValue) {
                      setState(() {
                        sliderValuesSingleton.setSliderValue('amplitude', newValue);
                      });
                      print(sliderValueAmplitude.round());
                    },
                    label: sliderValueAmplitude.round().abs().toString(),
                    divisions: 10,

                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Adjust amplitude',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,

                    ),
                  ),
                  const SizedBox(height: 40),
                  Slider(
                    value: sliderValueFrequency,
                    min: 0,
                    max: 10,
                    onChanged: (newValue) {
                      setState(() {
                        sliderValuesSingleton.setSliderValue('frequency', newValue);
                      });
                      print(sliderValueFrequency.round());
                    },
                    label: sliderValueFrequency.round().abs().toString(),
                    divisions: 10,

                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Adjust Frequency',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,

                    ),
                  ),
                  const SizedBox(height: 40),
                  Slider(
                    value: sliderValueWaveform,
                    min: 0,
                    max: 10,
                    onChanged: (newValue) {
                      setState(() {
                        sliderValuesSingleton.setSliderValue('waveform', newValue);
                      });
                      print(sliderValueWaveform.round());
                    },
                    label: sliderValueWaveform.round().abs().toString(),
                    divisions: 10,

                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Adjust Waveform',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,

                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      margin: const EdgeInsets.fromLTRB(0, 25, 20, 0),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [AppColors.orangeRed, AppColors.orange],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child:
                      DropdownButton(
                        value: _selectedItem,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedItem = newValue!;
                          });
                        },
                        items: <String>['Sine', 'Square', 'Triangle', 'Sawtooth']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        underline: Container(),
                      ),
                    ),
                  ),

                ],
              ),
            ),

          ),
        ),
      )
    );
  }
}