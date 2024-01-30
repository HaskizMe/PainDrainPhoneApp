import 'package:flutter/material.dart';

import '../scheme_colors/app_colors.dart';
class PromptMessage extends StatelessWidget {
  const PromptMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text("Press 'CONNECT' to connect", style: TextStyle(color: AppColors.offWhite, fontSize: 20),),
        SizedBox(height: 3,),
        Text("to Pain Drain device", style: TextStyle(color: AppColors.offWhite, fontSize: 20),),
      ],
    );
  }
}

class ErrorPromptMessage extends StatelessWidget {
  const ErrorPromptMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        // Text("Connection Failed:", style: TextStyle(color: Colors.red, fontSize: 20),),
        Text("Make sure device is on", style: TextStyle(color: Colors.red, fontSize: 20),),
        Text("and awake and try again.", style: TextStyle(color: Colors.red, fontSize: 20),),
      ],
    );
  }
}
