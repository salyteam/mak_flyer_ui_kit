import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';
import 'package:mak_flyer_ui_kit/src/layout/mf_sliding_app_bar/items.dart';
import 'package:mak_flyer_ui_kit/src/layout/mf_sliding_app_bar/mf_sliding_app_bar.dart';
import 'package:mak_flyer_ui_kit/src/layout/mf_sliding_app_bar/shrinking_parabolic_curve.dart';
import 'package:mak_flyer_ui_kit/src/layout/mf_sliding_app_bar/slider_painter.dart';

class SlidingNavBarCore extends StatefulWidget {
  const SlidingNavBarCore({
    required this.items,
    required this.duration,
    required this.iconColor,
    required this.buttonSize,
    required this.buttonsGap,
    required this.sliderColor,
    required this.initialIndex,
    required this.selectedIconColor,
    required this.sliderBorderRadius,
    this.buttonDecoration,
    this.onTap,
    super.key,
  });

  final int initialIndex;
  final Duration duration;
  final List<MFNavBarItem> items;

  final Color iconColor;
  final Color selectedIconColor;

  final double buttonSize;
  final double buttonsGap;
  final BoxDecoration? buttonDecoration;

  final Radius sliderBorderRadius;
  final Color sliderColor;

  final Function(int index)? onTap;

  @override
  State<SlidingNavBarCore> createState() => SlidingNavBarCoreState();
}

class SlidingNavBarCoreState extends State<SlidingNavBarCore> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  final _radiusCurve = const ShrinkingParabolicCurve(shrink: 2);
  final _mainCurve = const Cubic(.7, .3, 0, 1);
  final _trailCurve = const Cubic(1, 0, 0.2, 1);

  late double _halfButtonSize;

  late double _previousX = 0;
  late double _currentX = 0;
  late int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    _halfButtonSize = widget.buttonSize / 2;
    _selectedIndex = widget.initialIndex;

    _currentX = _getPositionOf(widget.initialIndex);
    _previousX = _currentX;
  }

  double _getPositionOf(int i) => i * (widget.buttonSize + widget.buttonsGap) + _halfButtonSize;

  void moveSlider(int index) {
    if (_selectedIndex == index || _controller.isAnimating) return;

    setState(() {
      _selectedIndex = index;
      _previousX = _currentX;
      _currentX = _getPositionOf(index);
    });

    _controller.reset();
    _controller.forward();

    widget.onTap?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        final t0 = _mainCurve.transformInternal(_controller.value);
        final t1 = _trailCurve.transformInternal(_controller.value);
        final tr = _radiusCurve.transformInternal(_controller.value);

        final x0 = lerpDouble(_previousX, _currentX, t0)!;
        final x1 = lerpDouble(_previousX, _currentX, t1)!;
        final r = lerpDouble(0, _halfButtonSize, tr)!;

        return CustomPaint(
          painter: SliderPainter(
            mainX: x0,
            radius: r,
            trailX: x1,
            color: widget.sliderColor,
            borderRadius: widget.sliderBorderRadius,
          ),
          child: child,
        );
      },
      child: MFNavBarItems(
        onTap: moveSlider,
        items: widget.items,
        iconSize: _halfButtonSize,
        iconColor: widget.iconColor,
        buttonSize: widget.buttonSize,
        selectedIndex: _selectedIndex,
        buttonsGap: widget.buttonsGap,
        switchDuration: widget.duration,
        selectedIconColor: widget.selectedIconColor,
        buttonDecoration: widget.buttonDecoration,
      ),
    );
  }
}
