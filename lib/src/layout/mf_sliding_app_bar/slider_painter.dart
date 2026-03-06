import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SliderPainter extends CustomPainter {
  SliderPainter({
    required this.mainX,
    required this.trailX,
    required this.radius,
    required this.borderRadius,
    required Color color,
  }) : _paint = Paint()..color = color;

  final double mainX;
  final double trailX;
  final double radius;
  final Radius borderRadius;

  final Paint _paint;

  @override
  void paint(Canvas canvas, Size size) {
    final clampedRadius = clampDouble(radius, 0, size.height / 2);
    final cy = size.height / 2;

    final clampedMainX = clampDouble(mainX, clampedRadius, size.width - clampedRadius);
    final clampedTrailX = clampDouble(trailX, clampedRadius, size.width - clampedRadius);

    final mainPosition = Offset(clampedMainX, cy);
    final trailPosition = Offset(clampedTrailX, cy);

    drawShape(canvas, mainPosition, trailPosition, clampedRadius);
  }

  void drawShape(Canvas canvas, Offset mainPosition, Offset trailPosition, double clampedRadius) {
    drawHead(canvas, mainPosition, radius);
    drawHead(canvas, trailPosition, radius);
    drawBody(canvas, mainPosition, trailPosition, clampedRadius);
  }

  void drawBody(Canvas canvas, Offset mainPosition, Offset trailPosition, double clampedRadius) {
    final w = (mainPosition.dx - trailPosition.dx).abs();
    final x = math.min(mainPosition.dx, trailPosition.dx);

    final rect = Rect.fromLTWH(x, mainPosition.dy - clampedRadius, w, 2 * clampedRadius);
    canvas.drawRect(rect, _paint);
  }

  void drawHead(Canvas canvas, Offset center, double r) {
    final rect = Rect.fromCircle(center: center, radius: r);
    final rrect = RRect.fromRectAndRadius(rect, borderRadius);
    canvas.drawRRect(rrect, _paint);
  }

  @override
  bool shouldRepaint(SliderPainter old) => mainX != old.mainX || trailX != old.trailX || radius != old.radius;
}
