import 'dart:ui';

import 'package:flutter/material.dart';

class AnimatedCheckMark extends StatefulWidget {
  final Animation<double> progress;

  // The size of the checkmark
  final double size;

  // The primary color of the checkmark
  final Color? color;

  // The width of the checkmark stroke
  final double? strokeWidth;

  const AnimatedCheckMark({
    super.key,
    required this.progress,
    required this.size,
    this.color,
    this.strokeWidth
  });

  @override
  State<StatefulWidget> createState() => AnimatedCheckMarkState();
}

class AnimatedCheckMarkState extends State<AnimatedCheckMark> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return CustomPaint(
        foregroundPainter: AnimatedPathPainterCheckMark(widget.progress, widget.color ?? theme.primaryColor, widget.strokeWidth),
        child: SizedBox(
          width: widget.size,
          height: widget.size,
        )
    );
  }
}

class AnimatedPathPainterCheckMark extends CustomPainter {
  final Animation<double> _animation;

  final Color _color;

  final double? strokeWidth;

  AnimatedPathPainterCheckMark(this._animation, this._color, this.strokeWidth) : super(repaint: _animation);

  Path _createAnyPath(Size size) {
    return Path()
      ..moveTo(0.27083 * size.width, 0.54167 * size.height)
      ..lineTo(0.41667 * size.width, 0.68750 * size.height)
      ..lineTo(0.75000 * size.width, 0.35417 * size.height);
  }

  Path createAnimatedPath(Path originalPath, double animationPercent) {
    final totalLength = originalPath
        .computeMetrics()
        .fold(0.0, (double prev, PathMetric metric) => prev + metric.length);

    final currentLength = totalLength * animationPercent;

    return extractPathUntilLength(originalPath, currentLength);
  }

  Path extractPathUntilLength(Path originalPath, double length) {
    var currentLength = 0.0;

    final path = Path();

    var metricsIterator = originalPath.computeMetrics().iterator;

    while (metricsIterator.moveNext()) {
      var metric = metricsIterator.current;

      var nextLength = currentLength + metric.length;

      final isLastSegment = nextLength > length;
      if (isLastSegment) {
        final remainingLength = length - currentLength;
        final pathSegment = metric.extractPath(0.0, remainingLength);

        path.addPath(pathSegment, Offset.zero);
        break;
      } else {

        final pathSegment = metric.extractPath(0.0, metric.length);
        path.addPath(pathSegment, Offset.zero);
      }

      currentLength = nextLength;
    }

    return path;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final animationPercent = _animation.value;

    final path = createAnimatedPath(_createAnyPath(size), animationPercent);

    final Paint paint = Paint();
    paint.color = _color;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = strokeWidth ?? size.width * 0.06;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class SuccessfulConnection extends StatefulWidget {
  final Animation<double> animation;
  const SuccessfulConnection({Key? key, required this.animation}) : super(key: key);

  @override
  State<SuccessfulConnection> createState() => _SuccessfulConnectionState();
}

class _SuccessfulConnectionState extends State<SuccessfulConnection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 180,
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.1), // Adjust alpha value for transparency
        borderRadius: BorderRadius.circular(10), // Set border radius for rounded corners
      ),
      child: Center(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.green, // Outline color
                    width: 2.0, // Outline width
                  ),
                ),
              ),
            ),
            Align(
                alignment: Alignment.center,
                child: AnimatedCheckMark(progress: widget.animation, size: 100, color: Colors.green,)
            ),
            const Align(
                alignment: Alignment.bottomCenter,
                child: Text("Device Connected!", style: TextStyle(color: Colors.green, fontSize: 18),)
            ),
          ],
        ),
      ),
    );
  }
}
