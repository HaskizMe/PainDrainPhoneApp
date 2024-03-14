import 'package:flutter/material.dart';

import '../scheme_colors/app_colors.dart';
class PulseIcon extends StatefulWidget {
  final bool isPulsing;
  const PulseIcon({super.key, required this.isPulsing});

  @override
  _PulseIconState createState() => _PulseIconState();
}

class _PulseIconState extends State<PulseIcon> with TickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant PulseIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Start or stop the animation based on the isPulsing state
    if (widget.isPulsing) {
      _pulseController.repeat(reverse: true);
    } else {
      _pulseController.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween<double>(begin: 0.8, end: 1.0).animate(
        CurvedAnimation(
          parent: _pulseController,
          curve: Curves.easeInOut,
        ),
      ),
      child: Container(
        width: 180.0,
        height: 180.0,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Icon(Icons.bluetooth_connected_rounded, size: 150.0,
            // color: AppColors.mintGreen
            color: Colors.blue.shade600

        ),
      ),
    );
  }
}