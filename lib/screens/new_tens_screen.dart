import 'package:flutter/material.dart';
import 'package:pain_drain_mobile_app/widgets/new_custom_slider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class NewTensSettings extends StatefulWidget {
  const NewTensSettings({Key? key}) : super(key: key);

  @override
  State<NewTensSettings> createState() => _NewTensSettingsState();
}

class _NewTensSettingsState extends State<NewTensSettings> {
  double _value = 00.0;
  bool _isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 40.0),
      child: Container(
        //color: Colors.purple,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20,),

            Container(
              width: 150,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.4),
                borderRadius: BorderRadius.circular(5.0)
              ),
            ),
            SizedBox(height: 40,),
            Expanded(
              child: Container(
                //color: Colors.blue,
                child: Row(
                  children: [
                    CustomSlider(title: 'Amplitude\n',),
                    CustomSlider(title: 'Period\n',),
                    CustomSlider(title: ' Duration\nChannel 1',),
                    CustomSlider(title: ' Duration\nChannel 2',),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("0"),
                const SizedBox(width: 5.0,),
                Switch(
                  value: _isSwitched,
                  onChanged: (bool value) {
                    setState(() {
                      _isSwitched = value;
                    });
                  },
                ),
                const SizedBox(width: 5.0,),
                const Text("180")
              ],
            )
          ],
        ),
      ),
    );

  }
}
