
/*
This class is responsible for maintaining the slider's values through the whole app
without resetting them after changing to different pages
*/
class SliderValuesSingleton {
  static final SliderValuesSingleton _instance = SliderValuesSingleton._internal();
  final Map<String, double> _sliderValues = {};

  factory SliderValuesSingleton() {
    return _instance;
  }

  SliderValuesSingleton._internal();

  double getSliderValue(String sliderName) {
    return _sliderValues[sliderName] ?? 0;
  }

  void setSliderValue(String sliderName, double newValue) {
    _sliderValues[sliderName] = newValue;
  }
}