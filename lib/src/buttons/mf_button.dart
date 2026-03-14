import 'package:flutter/material.dart';
import 'package:mak_flyer_ui_kit/mak_flyer_ui_kit.dart';

class MFButton extends StatelessWidget {
  const MFButton.primary({
    this.title,
    this.onTap,
    this.child,
    this.textStyle,
    this.borderRadius = const .all(.circular(50)),
    this.size = MFButtonSize.normal,
    this.shadow,
    this.padding,
    this.isDestructive = false,
    this.isLoading = false,
    super.key,
  }) : _type = .primary,
       backgroundColor = null,
       disableColor = null,
       textColor = null,
       assert(child != null || title != null);

  const MFButton.secondary({
    this.title,
    this.onTap,
    this.child,
    this.textStyle,
    this.borderRadius = const .all(.circular(50)),
    this.size = MFButtonSize.normal,
    this.shadow,
    this.padding,
    this.isDestructive = false,
    this.isLoading = false,
    super.key,
  }) : _type = .secondary,
       backgroundColor = null,
       disableColor = null,
       textColor = null,
       assert(child != null || title != null);

  const MFButton.ghost({
    this.title,
    this.onTap,
    this.child,
    this.textStyle,
    this.borderRadius = const .all(.circular(50)),
    this.size = MFButtonSize.normal,
    this.shadow,
    this.padding,
    this.isDestructive = false,
    this.isLoading = false,
    super.key,
  }) : _type = .ghost,
       backgroundColor = null,
       disableColor = null,
       textColor = null,
       assert(child != null || title != null);

  const MFButton.custom({
    this.title,
    this.onTap,
    this.child,
    this.textStyle,
    this.borderRadius = const .all(.circular(50)),
    this.size = MFButtonSize.normal,
    this.backgroundColor,
    this.disableColor,
    this.textColor,
    this.shadow,
    this.padding,
    this.isDestructive = false,
    this.isLoading = false,
    super.key,
  }) : _type = .custom,
       assert(child != null || title != null);

  final VoidCallback? onTap;
  final BorderRadius borderRadius;
  final Widget? child;
  final String? title;
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  final MFButtonType _type;
  final List<BoxShadow>? shadow;
  final MFButtonSize size;
  final Color? backgroundColor, disableColor, textColor;
  final bool isDestructive, isLoading;

  EdgeInsets get _effectivePadding => padding ?? (_type == .custom ? const .all(32) : size.padding);

  bool get isDisabled => onTap == null;

  Color _mainColor(BuildContext context) => isDestructive ? context.colors.invalid : context.colors.statusAccentS1;

  Color _primaryFillColor(BuildContext context) =>
      isDestructive ? context.colors.invalid : context.colors.neutralSecondaryS1;

  Color _backgroundColor(BuildContext context) => switch (_type) {
    .primary => _primaryFillColor(context),
    .secondary => _mainColor(context),
    .ghost => Colors.transparent,
    .custom => backgroundColor ?? _mainColor(context),
  };

  Color _textColor(BuildContext context) {
    if (_type == .custom && textColor != null) return textColor!;
    if (_type == .ghost) {
      return isDestructive ? context.colors.invalid : context.colors.neutralSecondaryS2;
    }
    return context.colors.neutralPrimaryS1;
  }

  BoxBorder? _border(BuildContext context) {
    if (_type == .primary || _type == .ghost || isDisabled) {
      return .all(color: context.colors.neutralSecondaryS3);
    }

    if (_type == .secondary) {
      return .all(color: context.colors.statusAccentS1.withValues(alpha: .2));
    }

    return null;
  }

  Widget? _buildChild(BuildContext context) {
    if (isLoading) return MFLoader(key: ValueKey("loader"), color: _textColor(context), padding: .zero);

    if (child != null) return child!;

    if (title != null) {
      final baseStyle = _type == .ghost
          ? context.fonts.body.copyWith(color: _textColor(context))
          : context.fonts.subtitle.copyWith(color: _textColor(context));
      return Text(title!, key: ValueKey("text"), style: textStyle ?? baseStyle);
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final content = DecoratedBox(
      decoration: BoxDecoration(borderRadius: borderRadius, border: _border(context)),
      child: Padding(
        padding: const .all(4),
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Material(
            color: Colors.transparent,
            borderRadius: borderRadius,
            child: InkWell(
              onTap: onTap,
              borderRadius: borderRadius,
              child: Ink(
                decoration: BoxDecoration(color: _backgroundColor(context), borderRadius: borderRadius),
                child: Padding(
                  padding: _effectivePadding,
                  child: Center(child: _buildChild(context)),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    return isDisabled ? Opacity(opacity: .4, child: content) : content;
  }
}
