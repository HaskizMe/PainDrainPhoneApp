import 'package:flutter/material.dart';
import 'package:pain_drain_mobile_app/global_slider_values.dart';
import 'package:pain_drain_mobile_app/scheme_colors/app_colors.dart';




class TENSSettings extends StatefulWidget {
  const TENSSettings({Key? key}) : super(key: key);

  @override
  State<TENSSettings> createState() => _TENSSettingsState();
}

class _TENSSettingsState extends State<TENSSettings> {
  final sliderValuesSingleton = SliderValuesSingleton();
  @override
  Widget build(BuildContext context) {
    double sliderValue = sliderValuesSingleton.getSliderValue('tens');
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: const Text(
          'TENS',
          style: TextStyle(
            color: Colors.white,
            fontSize: 50,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[900],
        centerTitle: true,
        toolbarHeight: 90,
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery
              .of(context)
              .size
              .width * 0.70,
          child: SliderTheme(
            data: SliderThemeData(
              trackHeight: 15,
              activeTrackColor: AppColors.blue, // Color of the active portion of the track
              inactiveTrackColor: Colors.white, // Color of the inactive portion of the track
              thumbColor: Colors.blue[600], // Color of the thumb
              overlayColor: AppColors.lightGreen, // Color of the overlay when pressed
              valueIndicatorColor: AppColors.navyBlue, // Color of the value indicator
              tickMarkShape: const RoundSliderTickMarkShape(
                  tickMarkRadius: 0
              ),
              thumbShape: const RoundSliderThumbShape(
                enabledThumbRadius: 15.0, // Adjust the radius as needed
              ),// Make ticks invisible
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Slider(
                  value: sliderValue,
                  min: 0,
                  max: 10,
                  onChanged: (newValue) {
                    setState(() {
                      sliderValuesSingleton.setSliderValue('tens', newValue);
                    });
                    print('Slider value: $newValue');
                  },
                  label: sliderValue.round().toString(),
                  divisions: 10,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Adjust TENS setting',
                  style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,

                  ),
                ),

              ],
            ),
          ),

        ),
      )
    );
  }
}

