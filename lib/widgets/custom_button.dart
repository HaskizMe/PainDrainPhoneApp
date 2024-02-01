import 'package:flutter/material.dart';

import '../main.dart';

class CustomButton extends StatefulWidget {
  final String buttonTitle;
  final Function handleFunction;
  const CustomButton({Key? key, required this.buttonTitle, required this.handleFunction}) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: ElevatedButton(
        onPressed: () {
          print(globalValues.getPresetValue());
          widget.handleFunction;
        },
        child: Text(widget.buttonTitle),
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
        ),
      ),
    );
  }
}
