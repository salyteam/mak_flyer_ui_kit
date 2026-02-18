import 'package:flutter/material.dart';

final class FontsExtension extends ThemeExtension<FontsExtension> {
  FontsExtension({
    required this.h1,
    required this.h2,
    required this.h3,
    required this.h4,
    required this.h5,
    required this.h6,
    required this.subtitle,
    required this.body,
    required this.small,
  });

  factory FontsExtension.base({Color? color}) => FontsExtension(
    h1: TextStyle(color: color, fontSize: 72, fontWeight: FontWeight.w700, height: 1.4, letterSpacing: -1.44),
    h2: TextStyle(color: color, fontSize: 56, fontWeight: FontWeight.w700, height: 1.5, letterSpacing: -1.01),
    h3: TextStyle(color: color, fontSize: 40, fontWeight: FontWeight.w700, height: 1.5, letterSpacing: -0.64),
    h4: TextStyle(color: color, fontSize: 32, fontWeight: FontWeight.w700, height: 1.5, letterSpacing: -0.45),
    h5: TextStyle(color: color, fontSize: 24, fontWeight: FontWeight.w700, height: 1.5, letterSpacing: -0.34),
    h6: TextStyle(color: color, fontSize: 20, fontWeight: FontWeight.w700, height: 1.6, letterSpacing: -0.12),
    subtitle: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.w700, height: 1.5, letterSpacing: 0.12),
    body: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.w400, height: 1.6, letterSpacing: 0.12),
    small: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w400, height: 1.6, letterSpacing: 0.12),
  );

  final TextStyle h1;
  final TextStyle h2;
  final TextStyle h3;
  final TextStyle h4;
  final TextStyle h5;
  final TextStyle h6;
  final TextStyle subtitle;
  final TextStyle body;
  final TextStyle small;

  @override
  ThemeExtension<FontsExtension> copyWith() => this;

  @override
  ThemeExtension<FontsExtension> lerp(covariant ThemeExtension<FontsExtension>? other, double t) => this;
}
