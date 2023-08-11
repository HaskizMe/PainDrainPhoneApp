import 'package:flutter/material.dart';
import 'package:pain_drain_mobile_app/scheme_colors/app_colors.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class TempSettings extends StatefulWidget {
  const TempSettings({Key? key}) : super(key: key);

  @override
  State<TempSettings> createState() => _TempSettingsState();
}

class _TempSettingsState extends State<TempSettings> {

  double _sliderValue = 0;
  final double min = 0;
  final double max = 10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Temperature',
          style: TextStyle(
            fontSize: 50,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.orangeRed,
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
                // Slider(
                //   value: _sliderValue,
                //   min: 0,
                //   max: 10,
                //   onChanged: (newValue) {
                //     setState(() {
                //       _sliderValue = newValue;
                //     });
                //     print('Slider value: $newValue');
                //   },
                //   label: _sliderValue.round().toString(),
                //   divisions: 10,
                // ),
                const SizedBox(height: 10),
                slider,
                const Text(
                  'Adjust TENS setting',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,

                  ),
                ),

              ],
            ),
          ),

        ),
      ),
      backgroundColor: AppColors.yellow,
    );
  }
}

final slider = SleekCircularSlider(
    appearance: CircularSliderAppearance(
      customWidths: CustomSliderWidths(
        progressBarWidth: 20.0,
      ),
      customColors: CustomSliderColors(
        progressBarColor: AppColors.green
      )
    ),
    onChange: (double value) {
      print(value);
    });