import 'package:flutter/material.dart';
import 'package:pain_drain_mobile_app/screens/TENS_settings.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../main.dart';
import '../widgets/custom_card.dart';
import '../widgets/custom_slider.dart';
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = double.infinity;
    double tensBoxHeight = 300.0;
    double temperatureBoxHeight = 130.0;
    double vibrationBoxHeight = 130.0;
    double periodMinValue = .5;
    double periodMaxValue = 10.0;
    double durationMinValue = .1;
    double durationMaxValue = 1.0;
    double temperatureMaxValue = 100;
    double temperatureMinValue = 0;
    double minValue = 0;
    double maxValue = 100;

    double tensPeriodSliderValue = globalValues.getSliderValue(globalValues.tensPeriod);
    double tenDurationSliderValueChannel1 = globalValues.getSliderValue(globalValues.tensDurationCh1);
    double tensAmplitudeSliderValue = globalValues.getSliderValue(globalValues.tensAmplitude);
    double tenDurationSliderValueChannel2 = globalValues.getSliderValue(globalValues.tensDurationCh2);
    //double tensPhaseSliderValue = globalValues.getSliderValue(globalValues.tensPhase);
    double vibrationAmplitudeSliderValue = globalValues.getSliderValue(globalValues.vibeAmplitude);
    double vibrationFrequencySliderValue = globalValues.getSliderValue(globalValues.vibeFreq);
    double vibrationWaveformSliderValue = globalValues.getSliderValue(globalValues.vibeWaveform);
    double temperatureSliderValue = globalValues.getSliderValue(globalValues.temperature);
    double tensPeriodPercentage =  (tensPeriodSliderValue - periodMinValue) / (periodMaxValue - periodMinValue);
    double tensDurationCh1Percentage = (tenDurationSliderValueChannel1 - durationMinValue) / (durationMaxValue - durationMinValue);
    double tensDurationCh2Percentage = (tenDurationSliderValueChannel2 - durationMinValue) / (durationMaxValue - durationMinValue);
    double tensAmplitudePercentage = (tensAmplitudeSliderValue - minValue) / (maxValue - minValue);
    double temperaturePercentage = (temperatureSliderValue - temperatureMinValue) / (temperatureMaxValue - temperatureMinValue);
    double vibrationAmplitudePercentage = (vibrationAmplitudeSliderValue - minValue) / (maxValue - minValue);
    double vibrationFrequencyPercentage = (vibrationFrequencySliderValue - minValue) / (maxValue - minValue);
    double vibrationWaveformPercentage = (vibrationWaveformSliderValue - minValue) / (maxValue - minValue);
    print("temp value $temperatureSliderValue");
    print("My percentage $temperaturePercentage");


    List<Widget> tensWidgets = [
      CustomCircularBar(value: tensAmplitudePercentage, radius: 80, name: 'Amplitude', centerValue: "${tensAmplitudeSliderValue.round()}%",),
      CustomCircularBar(value: tensPeriodPercentage, radius: 80, name: 'Period', centerValue: "${tensPeriodSliderValue}s",),
      CustomCircularBar(value: tensDurationCh1Percentage, radius: 80, name: 'Duration\nChannel 1', centerValue: "${tenDurationSliderValueChannel1}s"),
      CustomCircularBar(value: tensDurationCh2Percentage, radius: 80, name: 'Duration\nChannel 2', centerValue: "${tenDurationSliderValueChannel2}s"),
    ];
    List<Widget> vibrationWidgets = [
      CustomCircularBar(value: vibrationAmplitudePercentage, radius: 80, name: 'Amplitude', centerValue: "${vibrationAmplitudeSliderValue.round()}%"),
      CustomCircularBar(value: vibrationFrequencyPercentage, radius: 80, name: 'Frequency', centerValue: "${vibrationFrequencySliderValue.round()}%"),
      CustomCircularBar(value: vibrationWaveformPercentage, radius: 80, name: 'Waveform', centerValue: "${vibrationWaveformSliderValue.round()}%"),
    ];
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Colors.grey[800],
        toolbarHeight: 10,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                  "Tens",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Center(
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PageNavigation(activePage: 1, pageController: PageController(initialPage: 1),)),
                  //MaterialPageRoute(builder: (context) => PageNavigation())
                ),
                child: CustomCard(
                  width: width,
                  sliders: tensWidgets,
                  spacing: 60.0,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Temperature",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            Center(
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PageNavigation(activePage: 2, pageController: PageController(initialPage: 2),)),
                  //MaterialPageRoute(builder: (context) => PageNavigation())
                ),
                child: CustomCard(
                  width: width,
                  spacing: 0.0,
                  sliders: <Widget> [CustomCircularBar(selectedColor: Colors.red, value: temperaturePercentage, radius: 80, name: 'Temperature', centerValue: "${temperatureSliderValue.round()}%",)],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Vibration",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            Center(
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PageNavigation(activePage: 3, pageController: PageController(initialPage: 3),)),
                  //MaterialPageRoute(builder: (context) => PageNavigation())
                ),
                child: CustomCard(
                  spacing: 10.0,
                  width: width,
                  sliders: vibrationWidgets,
                ),
              ),
            ),
            const SizedBox(height: 80.0),
          ],
        ),
      ),
    );
  }
}
class CustomCircularBar extends StatelessWidget {
  final double value;
  final double radius;
  final String name;
  final String centerValue;
  final Color selectedColor;
  const CustomCircularBar({super.key,
    required this.value,
    required this.radius,
    required this.name,
    this.centerValue = " ",
    this.selectedColor = Colors.blue
  });

  @override
  Widget build(BuildContext context) {
    Color color;
    if (value > 0) {
      color = selectedColor;
    } else if (value < 0) {
      color = Colors.blue;
    } else {
      color = Colors.grey; // Neutral color when the value is 0
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: radius,
                height: radius,
                //color: Colors.green,
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(value < 0 ? 3.141592653589793 : 0),
                  child: CircularProgressIndicator(
                    value: value.abs(), // Use the absolute value for the progress
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                    backgroundColor: Colors.grey[300], // Neutral background color
                    strokeWidth: 10.0,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Center(
                child: Text(
                  centerValue,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(
                name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            )
        )
      ],
    );
  }
}
