import 'dart:ui';

import 'package:flutter/material.dart';

class AnimatedXMark extends StatefulWidget {
  final Animation<double> progress;
  final double size;
  final Color? color;
  final double? strokeWidth;

  const AnimatedXMark({
    Key? key,
    required this.progress,
    required this.size,
    this.color,
    this.strokeWidth,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => AnimatedXMarkState();
}

class AnimatedXMarkState extends State<AnimatedXMark> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return CustomPaint(
      foregroundPainter: AnimatedPathPainterXMark(widget.progress, widget.color ?? theme.primaryColor, widget.strokeWidth),
      child: SizedBox(
        width: widget.size,
        height: widget.size,
      ),
    );
  }
}

class AnimatedPathPainterXMark extends CustomPainter {
  final Animation<double> _animation;
  final Color _color;
  final double? strokeWidth;

  AnimatedPathPainterXMark(this._animation, this._color, this.strokeWidth) : super(repaint: _animation);

  Path _createXPath(Size size) {
    return Path()
      ..moveTo(0.25 * size.width, 0.25 * size.height)
      ..lineTo(0.75 * size.width, 0.75 * size.height)
      ..moveTo(0.75 * size.width, 0.25 * size.height)
      ..lineTo(0.25 * size.width, 0.75 * size.height);
  }

  Path createAnimatedPath(Path originalPath, double animationPercent) {
    final totalLength = originalPath.computeMetrics().fold(0.0, (double prev, PathMetric metric) => prev + metric.length);
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
    final path = createAnimatedPath(_createXPath(size), animationPercent);

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

class UnsuccessfulConnection extends StatefulWidget {
  final Animation<double> animation;
  const UnsuccessfulConnection({Key? key, required this.animation}) : super(key: key);

  @override
  State<UnsuccessfulConnection> createState() => _UnsuccessfulConnectionState();
}

class _UnsuccessfulConnectionState extends State<UnsuccessfulConnection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 180,
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1), // Adjust alpha value for transparency
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
                    color: Colors.red, // Outline color
                    width: 2.0, // Outline width
                  ),
                ),
              ),
            ),
            Align(
                alignment: Alignment.center,
                child: AnimatedXMark(progress: widget.animation, size: 100, color: Colors.red,)
            ),
            const Align(
                alignment: Alignment.bottomCenter,
                child: Text("Connection Failed!", style: TextStyle(color: Colors.red, fontSize: 18),),

            ),
          ],
        ),
      ),
    );
  }
}
