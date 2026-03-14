import 'package:flutter/material.dart';

enum MFButtonType { primary, secondary, ghost, custom }

enum MFButtonSize {
  normal(52, .symmetric(vertical: 14, horizontal: 32)),
  small(42, .symmetric(vertical: 9, horizontal: 32));

  final double height;
  final EdgeInsets padding;
  const MFButtonSize(this.height, this.padding);
}

enum MFOptionButtonType { link, switcher }
