import 'package:flutter/material.dart';
import 'package:mak_flyer_ui_kit/mak_flyer_ui_kit.dart';

class MFRadioCheck extends StatelessWidget {
  const MFRadioCheck({required this.isActive, super.key});

  final bool isActive;

  static const double _size = 24;
  static const double _iconSize = 12;
  static const Duration _duration = Durations.short4;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: _size,
      child: AnimatedContainer(
        duration: _duration,
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          shape: .circle,
          color: isActive ? context.colors.statusOkS1 : Colors.transparent,
          border: .all(color: context.colors.neutralSecondaryS3, width: isActive ? 0 : 1.5),
        ),
        child: AnimatedSwitcher(
          duration: _duration,
          switchInCurve: Curves.easeInOut,
          switchOutCurve: Curves.easeInOut,
          child: isActive
              ? Center(
                  key: const ValueKey<bool>(true),
                  child: MFAssets.icons.check.svg(
                    width: _iconSize,
                    height: _iconSize,
                    colorFilter: .mode(context.colors.neutralPrimaryS1, .srcIn),
                  ),
                )
              : const SizedBox.shrink(key: ValueKey<bool>(false)),
        ),
      ),
    );
  }
}
