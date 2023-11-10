import 'package:flutter/material.dart';
typedef HandleSliderChange = void Function(double value, String stimulus);

class CustomCard extends StatefulWidget {
  final double height;
  final double width;
  final List<Widget> sliders;
  const CustomCard({Key? key,
    required this.height,
    required this.width,
    required this.sliders,
  }) : super(key: key);

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20.0,
      color: Colors.grey[700],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SizedBox(
          height: widget.height,
          width: widget.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            // Fill with however many widgets needed
            children: [
              ...widget.sliders,
            ],
          ),

          // Your custom widget content
        ),
      ),
    );
  }
}
