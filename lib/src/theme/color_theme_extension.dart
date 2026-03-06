import 'package:flutter/material.dart';
import 'package:mak_flyer_ui_kit/mak_flyer_ui_kit.dart';

final class ColorThemeExtension extends ThemeExtension<ColorThemeExtension> {
  ColorThemeExtension._({
    required this.neutralSecondaryS1,
    required this.neutralSecondaryS2,
    required this.neutralSecondaryS3,
    required this.neutralSecondaryS4,
    required this.neutralSecondaryS5,
    required this.neutralSecondaryS6,
    required this.neutralPrimaryS1,
    required this.neutralPrimaryS2,
    required this.statusInfoS1,
    required this.statusInfoS2,
    required this.statusOkS1,
    required this.statusOkS2,
    required this.statusErrorS1,
    required this.statusErrorS2,
    required this.statusErrorS3,
    required this.statusAccentS1,
    required this.statusAccentS2,
    required this.shadowColor,
    required this.invalid,
  });

  factory ColorThemeExtension.light() => ColorThemeExtension._(
    invalid: ColorName.invalid,
    shadowColor: ColorName.shadowColor,
    neutralSecondaryS1: ColorName.neutralSecondaryS1,
    neutralSecondaryS2: ColorName.neutralSecondaryS2,
    neutralSecondaryS3: ColorName.neutralSecondaryS3,
    neutralSecondaryS4: ColorName.neutralSecondaryS4,
    neutralSecondaryS5: ColorName.neutralSecondaryS5,
    neutralSecondaryS6: ColorName.neutralSecondaryS6,
    neutralPrimaryS1: ColorName.neutralPrimaryS1,
    neutralPrimaryS2: ColorName.neutralPrimaryS2,
    statusInfoS1: ColorName.statusInfoS1,
    statusInfoS2: ColorName.statusInfoS2,
    statusOkS1: ColorName.statusOkS1,
    statusOkS2: ColorName.statusOkS2,
    statusErrorS1: ColorName.statusErrorS1,
    statusErrorS2: ColorName.statusErrorS2,
    statusErrorS3: ColorName.statusErrorS3,
    statusAccentS1: ColorName.statusAccentS1,
    statusAccentS2: ColorName.statusAccentS2,
  );

  factory ColorThemeExtension.dark() => ColorThemeExtension._(
    invalid: ColorName.invalid,
    shadowColor: ColorName.shadowColorDark,
    neutralSecondaryS1: ColorName.neutralSecondaryS1Dark,
    neutralSecondaryS2: ColorName.neutralSecondaryS2Dark,
    neutralSecondaryS3: ColorName.neutralSecondaryS3Dark,
    neutralSecondaryS4: ColorName.neutralSecondaryS4Dark,
    neutralSecondaryS5: ColorName.neutralSecondaryS5Dark,
    neutralSecondaryS6: ColorName.neutralSecondaryS6Dark,
    neutralPrimaryS1: ColorName.neutralPrimaryS1Dark,
    neutralPrimaryS2: ColorName.neutralPrimaryS2Dark,
    statusInfoS1: ColorName.statusInfoS1Dark,
    statusInfoS2: ColorName.statusInfoS2Dark,
    statusOkS1: ColorName.statusOkS1Dark,
    statusOkS2: ColorName.statusOkS2Dark,
    statusErrorS1: ColorName.statusErrorS1Dark,
    statusErrorS2: ColorName.statusErrorS2Dark,
    statusErrorS3: ColorName.statusErrorS3Dark,
    statusAccentS1: ColorName.statusAccentS1Dark,
    statusAccentS2: ColorName.statusAccentS2Dark,
  );

  final Color invalid;
  final Color shadowColor;
  final Color neutralSecondaryS1;
  final Color neutralSecondaryS2;
  final Color neutralSecondaryS3;
  final Color neutralSecondaryS4;
  final Color neutralSecondaryS5;
  final Color neutralSecondaryS6;
  final Color neutralPrimaryS1;
  final Color neutralPrimaryS2;
  final Color statusInfoS1;
  final Color statusInfoS2;
  final Color statusOkS1;
  final Color statusOkS2;
  final Color statusErrorS1;
  final Color statusErrorS2;
  final Color statusErrorS3;
  final Color statusAccentS1;
  final Color statusAccentS2;

  @override
  ThemeExtension<ColorThemeExtension> copyWith() => this;

  @override
  ThemeExtension<ColorThemeExtension> lerp(covariant ThemeExtension<ColorThemeExtension>? other, double t) => this;
}
