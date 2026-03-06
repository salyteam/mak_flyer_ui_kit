import 'package:flutter/material.dart';
import 'package:mak_flyer_ui_kit/mak_flyer_ui_kit.dart';
import 'package:mak_flyer_ui_kit/src/buttons/button_type.dart';

class MFButton extends StatelessWidget {
  const MFButton.primary({
    this.title,
    this.onTap,
    this.child,
    this.textStyle,
    this.radius = 50,
    this.size,
    this.shadow,
    this.padding = const EdgeInsets.symmetric(vertical: 14, horizontal: 65),
    this.isDestructive = false,
    this.isLoading = false,
    super.key,
  }) : _type = MFButtonType.primary,
       backgroundColor = null,
       disableColor = null,
       assert(child != null || title != null);

  const MFButton.secondary({
    this.title,
    this.onTap,
    this.child,
    this.textStyle,
    this.radius = 50,
    this.size,
    this.shadow,
    this.padding = const EdgeInsets.symmetric(vertical: 14, horizontal: 65),
    this.isLoading = false,
    super.key,
  }) : _type = MFButtonType.secondary,
       backgroundColor = null,
       disableColor = null,
       isDestructive = false,
       assert(child != null || title != null);

  const MFButton.ghost({
    this.title,
    this.onTap,
    this.child,
    this.textStyle,
    this.radius = 50,
    this.size,
    this.shadow,
    this.padding = const EdgeInsets.symmetric(vertical: 14, horizontal: 65),
    this.isDestructive = false,
    this.isLoading = false,
    super.key,
  }) : _type = MFButtonType.ghost,
       backgroundColor = null,
       disableColor = null,
       assert(child != null || title != null);

  const MFButton.custom({
    this.title,
    this.onTap,
    this.child,
    this.textStyle,
    this.radius = 50,
    this.size,
    this.backgroundColor,
    this.disableColor,
    this.shadow,
    this.padding = const EdgeInsets.symmetric(vertical: 14, horizontal: 65),
    this.isLoading = false,
    super.key,
  }) : _type = MFButtonType.custom,
       isDestructive = false,
       assert(child != null || title != null);

  final VoidCallback? onTap;
  final double radius;
  final Widget? child;
  final String? title;
  final TextStyle? textStyle;
  final EdgeInsets padding;
  final MFButtonType _type;
  final List<BoxShadow>? shadow;
  final Size? size;
  final Color? backgroundColor, disableColor;
  final bool isDestructive, isLoading;

  bool get isDisabled => onTap == null;

  Color _mainColor(BuildContext context) => isDestructive ? context.colors.invalid : context.colors.statusAccentS1;

  Color _backgroundColor(BuildContext context) => switch (_type) {
    MFButtonType.primary => _mainColor(context),
    MFButtonType.secondary => context.colors.neutralSecondaryS2,
    MFButtonType.ghost => context.colors.neutralPrimaryS1,
    MFButtonType.custom => backgroundColor ?? context.colors.statusAccentS1,
  };

  Color _backgroundDisabledColor(BuildContext context) => switch (_type) {
    MFButtonType.primary => _mainColor(context).withValues(alpha: 0.7),
    MFButtonType.secondary => context.colors.neutralSecondaryS2.withValues(alpha: 0.7),
    MFButtonType.ghost => context.colors.neutralPrimaryS1,
    MFButtonType.custom => disableColor ?? context.colors.statusAccentS1.withValues(alpha: 0.7),
  };

  Color _textColor(BuildContext context) {
    if (_type == MFButtonType.ghost) {
      var color = isDestructive ? context.colors.invalid : context.colors.neutralSecondaryS2;
      if (isDisabled) color = color.withValues(alpha: 0.7);

      return color;
    }

    if (_type == MFButtonType.ghost && isDestructive) {
      return context.colors.invalid.withValues(alpha: 0.7);
    }

    return switch (_type) {
      MFButtonType.ghost => context.colors.neutralSecondaryS2,
      _ => context.colors.neutralPrimaryS1,
    };
  }

  BoxBorder? _border(BuildContext context) {
    if (_type == MFButtonType.ghost) {
      var color = isDestructive ? context.colors.invalid : context.colors.neutralSecondaryS2;
      if (isDisabled) color = color.withValues(alpha: 0.4);

      return .all(color: color);
    }

    return null;
  }

  BorderRadius get _borderRadius => .circular(radius);

  Widget? _buildChild(BuildContext context) {
    if (isLoading) return MFLoader(key: ValueKey("loader"), padding: EdgeInsets.zero);

    if (child != null) return child!;

    if (title != null) {
      return Text(
        title!,
        key: ValueKey("text"),
        style:
            textStyle ??
            context.fonts.subtitle.copyWith(color: _textColor(context), fontWeight: FontWeight.w700, fontSize: 16),
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: size,
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
              boxShadow: shadow ?? [BoxShadow(color: _backgroundColor(context).withValues(alpha: 0.1), blurRadius: 16)],
              border: _border(context),
            ),
            child: Padding(
              padding: size != null ? EdgeInsets.zero : padding,
              child: Center(child: _buildChild(context)),
            ),
          ),
        ),
      ),
    );
  }
}
