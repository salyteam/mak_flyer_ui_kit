import 'package:flutter/material.dart';
import 'package:mak_flyer_ui_kit/src/layout/mf_sliding_app_bar/mf_sliding_app_bar.dart';
import 'package:mak_flyer_ui_kit/src/layout/mf_sliding_app_bar/sliding_appbar_core.dart';

class MFSlidingNavBar extends StatelessWidget {
  const MFSlidingNavBar({
    required this.items,
    this.height = 80,
    this.buttonsGap = 6,
    this.initialIndex = 0,
    this.padding = const EdgeInsets.all(6),
    this.duration = const Duration(milliseconds: 360),
    this.borderRadius = const BorderRadius.all(Radius.circular(50)),
    this.backgroundColor = const Color.fromARGB(255, 36, 36, 36),
    this.sliderColor = Colors.white,
    this.sliderBorderRadius = const Radius.circular(50),
    this.boxShadow = const [BoxShadow(color: Color.fromARGB(100, 0, 0, 0), offset: Offset(0, 6), blurRadius: 10)],
    this.iconColor = Colors.white,
    this.selectedIconColor = const Color.fromARGB(255, 36, 36, 36),
    this.buttonDecoration,
    this.navBarKey,
    this.border,
    this.onTap,
    super.key,
  }) : assert(items.length > 0, 'SlidingAppBar items must have at least 1 item');

  final GlobalKey? navBarKey;
  final double height, buttonsGap;
  final int initialIndex;
  final Duration duration;
  final EdgeInsets padding;

  final Color iconColor;
  final Color selectedIconColor;

  final BoxDecoration? buttonDecoration;

  final Radius sliderBorderRadius;
  final Color sliderColor;

  final Color backgroundColor;
  final BorderRadius borderRadius;
  final List<BoxShadow>? boxShadow;

  final List<MFNavBarItem> items;
  final BoxBorder? border;

  final Function(int index)? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Align(
        widthFactor: 1.0,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: borderRadius,
            boxShadow: boxShadow,
            border: border,
          ),
          child: Padding(
            padding: padding,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final n = items.length;
                final buttonSize = constraints.maxHeight;

                final w = buttonSize * n + buttonsGap * (n - 1);

                return SizedBox(
                  width: w,
                  child: SlidingNavBarCore(
                    key: navBarKey,
                    items: items,
                    onTap: onTap,
                    duration: duration,
                    iconColor: iconColor,
                    buttonsGap: buttonsGap,
                    buttonSize: buttonSize,
                    sliderColor: sliderColor,
                    initialIndex: initialIndex,
                    buttonDecoration: buttonDecoration,
                    selectedIconColor: selectedIconColor,
                    sliderBorderRadius: sliderBorderRadius,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
