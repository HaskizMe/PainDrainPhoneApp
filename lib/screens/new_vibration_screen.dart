import 'package:flutter/material.dart';
import 'package:pain_drain_mobile_app/widgets/drop_down_button.dart';

import 'package:pain_drain_mobile_app/widgets/new_custom_slider.dart';

class NewVibrationScreen extends StatefulWidget {
  const NewVibrationScreen({Key? key}) : super(key: key);

  @override
  State<NewVibrationScreen> createState() => _NewVibrationScreenState();
}

class _NewVibrationScreenState extends State<NewVibrationScreen> {
  List<String>? waveForms = ["Sine", "Square", "Sawtooth", "Triangle"];

  @override
  Widget build(BuildContext context) {
    String? selectedItem = waveForms?.first;
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
                    CustomSlider(title: 'Frequency\n',),
                    CustomSlider(title: ' Waveform\nChannel 1',),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20.0,),
            Align(
              alignment: Alignment(.9, 0),
              child: DropDownBox(selectedItem: selectedItem, items: waveForms, widthSize: 130,),
            )

          ],
        ),
      ),
    );
  }
}
