import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController textController;
  final void Function(String)? onTextFieldChange;
  final void Function() hideTextField;


  const CustomTextField({
    Key? key,
    required this.textController,
    required this.onTextFieldChange,
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
      child:
      TextField(
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
          widget.hideTextField();
        },
        autofocus: true,
        controller: widget.textController,
        //focusNode: textFocusNode,
        cursorColor: Colors.grey,
        decoration: const InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,  // Change the focused border color here
            ),
          ),
          labelText: 'Enter a new preset',
          labelStyle: TextStyle(
            color: Colors.black
          ),
          border: OutlineInputBorder(),
        ),
        onSubmitted: (value) {
          if (value != null && value.isNotEmpty) {
            widget.onTextFieldChange!(value);
          }
        },
      ),
    );
  }
}
