import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final double? width;
  final List<Widget> sliders;
  final double spacing;
  const CustomCard({Key? key,
    this.width,
    required this.sliders,
    this.spacing = 50.0
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20.0,
      color: Colors.grey[700],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          width: width,
          child: Wrap(
            spacing: spacing,
            runSpacing: 16.0,
            alignment: WrapAlignment.spaceEvenly,
            //crossAxisAlignment: WrapCrossAlignment.center,
            // Fill with however many widgets needed
            children: [
              ...sliders,
            ],
          ),
        )
      ),
    );
  }
}
