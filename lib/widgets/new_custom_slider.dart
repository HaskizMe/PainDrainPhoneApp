import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class CustomSlider extends StatefulWidget {
  final String title;
  const CustomSlider({Key? key, required this.title}) : super(key: key);

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {

  double _value = 00.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.blue,
      child: Expanded(
        child: Column(
          children: [
            SfSliderTheme(
              data: SfSliderThemeData(
                  activeTrackColor: Colors.blue,
                  inactiveTrackColor: Colors.blue.withOpacity(.2),
                  thumbColor: Colors.blue,
                  activeTrackHeight: 20,
                  inactiveTrackHeight: 10,
                  thumbRadius: 17
              ),
              child: Expanded(
                child: SfSlider.vertical(
                  enableTooltip: false,
                  min: 0.0,
                  max: 100.0,
                  value: _value,
                  interval: 100,
                  thumbIcon: Center(child: Text("$_value", style: TextStyle(color: Colors.white),)),
                  showLabels: false,
                  onChanged: (dynamic value) {
                    setState(() {
                      _value = value.round();
                    });
                  },
                ),
              ),
            ),
            Text(widget.title)
          ],
        ),
      ),
    );
  }
}
