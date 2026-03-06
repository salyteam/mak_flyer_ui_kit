import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class MFBottomSheetRoute<T> extends ModalBottomSheetRoute<T> {
  MFBottomSheetRoute({
    required super.builder,
    super.capturedThemes,
    super.barrierLabel,
    super.barrierOnTapHint,
    super.elevation,
    super.shape,
    super.clipBehavior,
    super.constraints,
    super.isDismissible,
    super.enableDrag,
    super.showDragHandle,
    super.isScrollControlled = true,
    super.scrollControlDisabledMaxHeightRatio,
    super.settings,
    super.requestFocus,
    super.transitionAnimationController,
    super.anchorPoint,
    super.useSafeArea = false,
    super.sheetAnimationStyle,
  }) : super(modalBarrierColor: Colors.black.withValues(alpha: .2), backgroundColor: Colors.transparent);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    if (Platform.isIOS) {
      return BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: super.buildPage(context, animation, secondaryAnimation),
      );
    }

    return super.buildPage(context, animation, secondaryAnimation);
  }
}
