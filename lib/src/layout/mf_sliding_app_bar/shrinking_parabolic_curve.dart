import 'package:flutter/animation.dart';

class ShrinkingParabolicCurve extends Curve {
  final double shrink;

  const ShrinkingParabolicCurve({required this.shrink});

  @override
  double transformInternal(double t) => shrink * t * t - shrink * t + 1;
}
