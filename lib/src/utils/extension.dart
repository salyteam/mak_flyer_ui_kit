import 'package:flutter/material.dart';
import 'package:mak_flyer_ui_kit/mak_flyer_ui_kit.dart';

extension ThemeDataExt on BuildContext {
  ColorThemeExtension get colors {
    return Theme.of(this).extension<ColorThemeExtension>() ?? ColorThemeExtension.light();
  }

  FontsExtension get fonts {
    return Theme.of(this).extension<FontsExtension>() ?? FontsExtension.base();
  }
}
