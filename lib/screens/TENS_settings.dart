import 'package:flutter/material.dart';
import 'package:pain_drain_mobile_app/scheme_colors/app_colors.dart';

class TENSSettings extends StatefulWidget {
  const TENSSettings({Key? key}) : super(key: key);

  @override
  State<TENSSettings> createState() => _TENSSettingsState();
}

class _TENSSettingsState extends State<TENSSettings> {
  double _sliderValue = 0;
  final double min = 0;
  final double max = 10;

  @override
  Widget build(BuildContext context) {
    RangeLabels labels = RangeLabels(min.toString(), max.toString());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TENS',
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
                Slider(
                  value: _sliderValue,
                  min: 0,
                  max: 10,
                  onChanged: (newValue) {
                    setState(() {
                      _sliderValue = newValue;
                    });
                    print('Slider value: $newValue');
                  },
                  label: _sliderValue.round().toString(),
                  divisions: 10,
                ),
                const SizedBox(height: 10),
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

