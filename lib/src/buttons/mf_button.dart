import 'package:flutter/material.dart';
import 'package:mak_flyer_ui_kit/mak_flyer_ui_kit.dart';
import 'package:mak_flyer_ui_kit/src/buttons/button_type.dart';

class MFButton extends StatelessWidget {
  const MFButton.primary({
    this.title,
    this.onTap,
    this.child,
    this.textStyle,
    this.borderRadius = 50,
    this.size,
    this.shadow,
    this.padding = const .symmetric(vertical: 14, horizontal: 65),
    this.isDestructive = false,
    this.isLoading = false,
    super.key,
  }) : _type = .primary,
       backgroundColor = null,
       disableColor = null,
       assert(child != null || title != null);

  const MFButton.secondary({
    this.title,
    this.onTap,
    this.child,
    this.textStyle,
    this.borderRadius = 50,
    this.size,
    this.shadow,
    this.padding = const .symmetric(vertical: 14, horizontal: 65),
    this.isDestructive = false,
    this.isLoading = false,
    super.key,
  }) : _type = .secondary,
       backgroundColor = null,
       disableColor = null,
       assert(child != null || title != null);

  const MFButton.ghost({
    this.title,
    this.onTap,
    this.child,
    this.textStyle,
    this.borderRadius = 50,
    this.size,
    this.shadow,
    this.padding = const .symmetric(vertical: 14, horizontal: 65),
    this.isDestructive = false,
    this.isLoading = false,
    super.key,
  }) : _type = .ghost,
       backgroundColor = null,
       disableColor = null,
       assert(child != null || title != null);

  const MFButton.custom({
    this.title,
    this.onTap,
    this.child,
    this.textStyle,
    this.borderRadius = 50,
    this.size,
    this.backgroundColor,
    this.disableColor,
    this.shadow,
    this.padding = const .symmetric(vertical: 14, horizontal: 65),
    this.isDestructive = false,
    this.isLoading = false,
    super.key,
  }) : _type = .custom,
       assert(child != null || title != null);

  final VoidCallback? onTap;
  final double borderRadius;
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

  Color _primaryFillColor(BuildContext context) =>
      isDestructive ? context.colors.invalid : context.colors.neutralSecondaryS1;

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

  Color _textColor(BuildContext context) {
    if (_type == .ghost) {
      var color = isDestructive ? context.colors.invalid : context.colors.neutralSecondaryS2;
      if (isDisabled) color = color.withValues(alpha: .7);
      return color;
    }
    return context.colors.neutralPrimaryS1;
  }

  BoxBorder? _border(BuildContext context) {
    if (_type == .ghost) {
      var color = isDestructive ? context.colors.invalid : context.colors.neutralSecondaryS3;
      if (isDisabled) color = color.withValues(alpha: .4);

      return .all(color: color);
    }

    return null;
  }

  BorderRadius get _borderRadius => .circular(borderRadius);

  Widget? _buildChild(BuildContext context) {
    if (isLoading) return MFLoader(key: ValueKey("loader"), color: _textColor(context), padding: .zero);

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
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      borderRadius: _borderRadius,
      boxShadow:
          shadow ??
          [
            BoxShadow(
              color: _backgroundColor(context).withValues(alpha: .1),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
    ),
    child: SizedBox.fromSize(
      size: size,
      child: Material(
        color: Colors.transparent,
        borderRadius: _borderRadius,
        child: InkWell(
          onTap: onTap,
          child: Ink(
            decoration: BoxDecoration(
              color: isDisabled ? _backgroundDisabledColor(context) : _backgroundColor(context),
              borderRadius: _borderRadius,
              border: _border(context),
            ),
            child: Padding(
              padding: size != null ? EdgeInsets.zero : padding,
              child: Center(child: _buildChild(context)),
            ),
          ),
        ),
      ),
    ),
  );
}
