import 'package:flutter/material.dart';
import 'package:pain_drain_mobile_app/widgets/x_mark_animation.dart';

import '../widgets/check_mark_animation.dart';
class AnimatedIconTest extends StatefulWidget {
  AnimatedIconTest({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _AnimatedIconTestState createState() => _AnimatedIconTestState();
}

class _AnimatedIconTestState extends State<AnimatedIconTest> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));

    _animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
            parent: _animationController, curve: Curves.easeInOutCirc
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Animated Check Example"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  child: AnimatedCheckMark(
                    progress: _animation,
                    size: 200,
                  )),
              TextButton(
                  child: Text("Check"),
                  onPressed: _animationController.forward),
              TextButton(
                  child: Text("Reset"), onPressed: _animationController.reset),

              SizedBox(height: 25,),
              Container(
                  child: AnimatedXMark(
                    progress: _animation,
                    size: 200,
                  )),
              TextButton(
                  child: Text("Check"),
                  onPressed: _animationController.forward),
              TextButton(
                  child: Text("Reset"), onPressed: _animationController.reset)
            ],
          ),
        ));
  }
}
