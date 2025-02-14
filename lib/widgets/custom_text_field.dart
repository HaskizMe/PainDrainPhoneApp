import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController textController;
  final void Function(String)? onSubmit;
  final void Function() hideTextField;


  const CustomTextField({
    Key? key,
    required this.textController,
    this.onSubmit,
    required this.hideTextField
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final FocusNode textFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: TextField(
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
          widget.hideTextField();
        },
        autofocus: true,
        controller: widget.textController,
        cursorColor: Colors.grey,
        maxLength: 15,
        decoration: const InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,  // Change the focused border color here
            ),
          ),
          labelText: 'Preset Name',
          labelStyle: TextStyle(
            color: Colors.black
          ),
          border: OutlineInputBorder(),
        ),
        onSubmitted: (value) {
          if (value.isNotEmpty && widget.onSubmit != null) {
            widget.onSubmit!(value);
          }
        },
      ),
    );
  }
}
