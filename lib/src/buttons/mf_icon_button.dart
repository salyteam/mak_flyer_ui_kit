import 'package:flutter/material.dart';
import 'package:mak_flyer_ui_kit/mak_flyer_ui_kit.dart';

enum MFIconButtonSize {
  normal(52, 24),
  small(42, 20),
  superSmall(32, 16);

  final double button;
  final double icon;
  const MFIconButtonSize(this.button, this.icon);
}

class MFIconButton extends StatelessWidget {
  const MFIconButton.primary({required this.icon, this.onTap, this.size = .normal, super.key})
    : _type = .primary,
      backgroundColor = null,
      disableColor = null;

  const MFIconButton.secondary({required this.icon, this.onTap, this.size = .normal, super.key})
    : _type = .secondary,
      backgroundColor = null,
      disableColor = null;

  const MFIconButton.ghost({required this.icon, this.onTap, this.size = .normal, super.key})
    : _type = .ghost,
      backgroundColor = null,
      disableColor = null;

  const MFIconButton.custom({
    required this.icon,
    this.onTap,
    this.size = .normal,
    this.backgroundColor,
    this.disableColor,
    super.key,
  }) : _type = .custom;

  final Widget icon;
  final VoidCallback? onTap;
  final MFIconButtonSize size;
  final MFButtonType _type;
  final Color? backgroundColor;
  final Color? disableColor;

  bool get isDisabled => onTap == null;

  double get _buttonSize => size.button;
  double get _iconSize => size.icon;
  BorderRadius get _borderRadius => BorderRadius.circular(_buttonSize / 2);

  Color _mainColor(BuildContext context) => context.colors.statusAccentS1;

  Color _primaryFillColor(BuildContext context) => context.colors.neutralSecondaryS1;

  Color _backgroundColor(BuildContext context) => switch (_type) {
    .primary => _primaryFillColor(context),
    .secondary => _mainColor(context),
    .ghost => context.colors.neutralPrimaryS1,
    .custom => backgroundColor ?? _mainColor(context),
  };

  Color _backgroundDisabledColor(BuildContext context) => switch (_type) {
    .primary => _primaryFillColor(context).withValues(alpha: .7),
    .secondary => _mainColor(context).withValues(alpha: .5),
    .ghost => context.colors.neutralPrimaryS1,
    .custom => disableColor ?? _mainColor(context).withValues(alpha: .7),
  };

  Color _iconColor(BuildContext context) {
    if (_type == .ghost) {
      var color = context.colors.neutralSecondaryS2;
      if (isDisabled) color = color.withValues(alpha: .7);
      return color;
    }
    return context.colors.neutralPrimaryS1;
  }

  BoxBorder? _border(BuildContext context) {
    if (_type == .ghost) {
      var color = context.colors.neutralSecondaryS3;
      if (isDisabled) color = color.withValues(alpha: .4);
      return Border.all(color: color);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) => SizedBox.square(
    dimension: _buttonSize,
    child: Material(
      color: Colors.transparent,
      borderRadius: _borderRadius,
      child: InkWell(
        onTap: onTap,
        borderRadius: _borderRadius,
        child: Ink(
          decoration: BoxDecoration(
            color: isDisabled ? _backgroundDisabledColor(context) : _backgroundColor(context),
            borderRadius: _borderRadius,
            border: _border(context),
          ),
          child: Center(
            child: SizedBox.square(
              dimension: _iconSize,
              child: IconTheme.merge(
                data: IconThemeData(size: _iconSize, color: _iconColor(context)),
                child: icon,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
