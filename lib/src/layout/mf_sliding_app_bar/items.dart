import 'package:flutter/material.dart';
import 'package:mak_flyer_ui_kit/src/layout/mf_sliding_app_bar/mf_sliding_app_bar.dart';

class MFNavBarItems extends StatelessWidget {
  const MFNavBarItems({
    required this.onTap,
    required this.items,
    required this.iconSize,
    required this.buttonSize,
    required this.buttonsGap,
    required this.selectedIndex,
    required this.switchDuration,
    required this.iconColor,
    required this.selectedIconColor,
    this.buttonDecoration,
    super.key,
  });

  final double iconSize;
  final double buttonSize;
  final double buttonsGap;
  final BoxDecoration? buttonDecoration;

  final Color iconColor;
  final Color selectedIconColor;

  final int selectedIndex;
  final List<MFNavBarItem> items;

  final Duration switchDuration;

  final Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    final cells = <Widget>[];

    for (int i = 0; i < items.length; i++) {
      final item = items[i];

      Widget iconWidget = AnimatedSwitcher(
        duration: switchDuration,
        switchInCurve: Curves.easeInToLinear,
        switchOutCurve: Curves.easeInToLinear,
        child: i == selectedIndex
            ? item.icon.svg(
                key: const ValueKey(1),
                height: iconSize,
                width: iconSize,
                colorFilter: ColorFilter.mode(selectedIconColor, BlendMode.srcIn),
              )
            : item.icon.svg(
                key: const ValueKey(2),
                height: iconSize,
                width: iconSize,
                colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
              ),
      );

      if (buttonDecoration != null) {
        iconWidget = DecoratedBox(decoration: buttonDecoration!, child: iconWidget);
      }

      cells.add(
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => onTap(i),
          child: SizedBox.square(dimension: buttonSize, child: iconWidget),
        ),
      );

      if (i != items.length - 1) {
        cells.add(SizedBox(width: buttonsGap));
      }
    }

    return Row(mainAxisAlignment: MainAxisAlignment.center, children: cells);
  }
}
