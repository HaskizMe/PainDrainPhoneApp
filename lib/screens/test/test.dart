import "package:flutter/material.dart";

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  final double bottomContainerHeight = 100;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomPaint(
                size: Size(MediaQuery.of(context).size.width, bottomContainerHeight),
                painter: DemoPainter(),
              )
            ],
          ),
          Align(
            alignment: const Alignment(0, 0.90), // Adjust this to whatever you need
            child: IconButton(
              icon: const Icon(Icons.play_circle, size: 70,),
              onPressed: () {  },
            ),
          ),
        ],
      ),
    );
  }
}

class DemoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double radius = 70; // radius of the dome
    double height = -38; // Height of the dome
    double leftXPoint = (size.width / 2) - (radius / 2); // The left point of the dome
    double centerXPoint = size.width / 2; // The center of the dome
    double rightXPoint = (size.width / 2) + (radius / 2); // The right point of the dome
    double centerYPoint = height;

    var paint = Paint()..color = Colors.black.withOpacity(.3); // Change to whatever opacity you need

    var path = Path()
      ..moveTo(0, 0) // Top left point of the container
      ..lineTo(leftXPoint, 0) // Makes a line just left of the dome
      ..quadraticBezierTo(centerXPoint, centerYPoint, rightXPoint, 0) // This makes the nice curve of the dome
      ..lineTo(size.width, 0) // Makes a line from the right of the dome to the rop right point
      ..lineTo(size.width, size.height) // Line to the bottom right
      ..lineTo(0, size.height); // Line to the bottom left

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}


