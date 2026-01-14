import 'package:flutter/material.dart';
import 'package:saly_ui_kit/src/buttons/button_type.dart';
import 'package:saly_ui_kit/src/layout/saly_loader.dart';
import 'package:saly_ui_kit/src/utils/extension.dart';

class SalyButton extends StatelessWidget {
  const SalyButton.primary({
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
  }) : _type = SalyButtonType.primary,
       backgroundColor = null,
       disableColor = null,
       assert(child != null || title != null);

  const SalyButton.secondary({
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
  }) : _type = SalyButtonType.secondary,
       backgroundColor = null,
       disableColor = null,
       isDestructive = false,
       assert(child != null || title != null);

  const SalyButton.ghost({
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
  }) : _type = SalyButtonType.ghost,
       backgroundColor = null,
       disableColor = null,
       assert(child != null || title != null);

  const SalyButton.custom({
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
  }) : _type = SalyButtonType.custom,
       isDestructive = false,
       assert(child != null || title != null);

  final VoidCallback? onTap;
  final double radius;
  final Widget? child;
  final String? title;
  final TextStyle? textStyle;
  final EdgeInsets padding;
  final SalyButtonType _type;
  final List<BoxShadow>? shadow;
  final Size? size;
  final Color? backgroundColor, disableColor;
  final bool isDestructive, isLoading;

  bool get isDisabled => onTap == null;

  Color _mainColor(BuildContext context) => isDestructive ? context.colors.invalid : context.colors.statusAccentS1;

  Color _backgroundColor(BuildContext context) => switch (_type) {
    SalyButtonType.primary => _mainColor(context),
    SalyButtonType.secondary => context.colors.neutralSecondaryS2,
    SalyButtonType.ghost => context.colors.neutralPrimaryS1,
    SalyButtonType.custom => backgroundColor ?? context.colors.statusAccentS1,
  };

  Color _backgroundDisabledColor(BuildContext context) => switch (_type) {
    SalyButtonType.primary => _mainColor(context).withValues(alpha: 0.7),
    SalyButtonType.secondary => context.colors.neutralSecondaryS2.withValues(alpha: 0.7),
    SalyButtonType.ghost => context.colors.neutralPrimaryS1,
    SalyButtonType.custom => disableColor ?? context.colors.statusAccentS1.withValues(alpha: 0.7),
  };

  Color _textColor(BuildContext context) {
    if (_type == SalyButtonType.ghost) {
      var color = isDestructive ? context.colors.invalid : context.colors.neutralSecondaryS2;
      if (isDisabled) color = color.withValues(alpha: 0.7);

      return color;
    }

    if (_type == SalyButtonType.ghost && isDestructive) {
      return context.colors.invalid.withValues(alpha: 0.7);
    }

    return switch (_type) {
      SalyButtonType.ghost => context.colors.neutralSecondaryS2,
      _ => context.colors.neutralPrimaryS1,
    };
  }

  BoxBorder? _border(BuildContext context) {
    if (_type == SalyButtonType.ghost) {
      var color = isDestructive ? context.colors.invalid : context.colors.neutralSecondaryS2;
      if (isDisabled) color = color.withValues(alpha: 0.4);

      return .all(color: color);
    }

    return null;
  }

  BorderRadius get _borderRadius => .circular(radius);

  Widget? _buildChild(BuildContext context) {
    if (isLoading) return SalyLoader(key: ValueKey("loader"), padding: EdgeInsets.zero);

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
