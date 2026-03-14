import 'package:flutter/material.dart';

enum MFButtonType { primary, secondary, ghost, custom }

abstract class MFButtonSize {
  const MFButtonSize();
  double get height;
  double? get width;
  EdgeInsets get padding;

  static const MFButtonSize normal = _NormalButtonSize();
  static const MFButtonSize small = _SmallButtonSize();
  factory MFButtonSize.custom([double? width, double? height]) => _CustomButtonSize(width, height);
}

class _NormalButtonSize extends MFButtonSize {
  const _NormalButtonSize() : super();
  @override
  double get height => 52;
  @override
  double? get width => null;
  @override
  EdgeInsets get padding => const .symmetric(horizontal: 32);
}

class _SmallButtonSize extends MFButtonSize {
  const _SmallButtonSize() : super();
  @override
  double get height => 42;
  @override
  double? get width => null;
  @override
  EdgeInsets get padding => const .symmetric(horizontal: 32);
}

class _CustomButtonSize extends MFButtonSize {
  _CustomButtonSize([this._width, this._height]);
  final double? _width;
  final double? _height;

  @override
  double get height {
    final h = _height;
    return (h != null && h.isFinite) ? h : 52;
  }

  @override
  double? get width {
    final w = _width;
    return (w != null && w.isFinite) ? w : null;
  }

  @override
  EdgeInsets get padding => const .symmetric(horizontal: 32);
}

enum MFOptionButtonType { link, switcher }
