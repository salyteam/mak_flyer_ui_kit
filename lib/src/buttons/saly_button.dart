import 'package:flutter/material.dart';
import 'package:saly_ui_kit/src/buttons/button_type.dart';
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
    super.key,
  }) : _type = SalyButtonType.secondary,
       backgroundColor = null,
       disableColor = null,
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
    super.key,
  }) : _type = SalyButtonType.custom,
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

  bool get isDisabled => onTap == null;

  Color _backgroundColor(BuildContext context) => switch (_type) {
    SalyButtonType.primary => context.colors.statusAccentS1,
    SalyButtonType.secondary => context.colors.neutralSecondaryS1,
    SalyButtonType.ghost => context.colors.neutralPrimaryS2,
    SalyButtonType.custom => backgroundColor ?? context.colors.statusAccentS1,
  };

  Color _backgroundDisabledColor(BuildContext context) => switch (_type) {
    SalyButtonType.primary => context.colors.statusAccentS1.withValues(alpha: 0.7),
    SalyButtonType.secondary => context.colors.neutralSecondaryS2.withValues(alpha: 0.7),
    SalyButtonType.ghost => context.colors.neutralPrimaryS1,
    SalyButtonType.custom => disableColor ?? context.colors.statusAccentS1.withValues(alpha: 0.7),
  };

  Color _textColor(BuildContext context) {
    if (_type == SalyButtonType.ghost && isDisabled) {
      return context.colors.neutralSecondaryS2.withValues(alpha: 0.7);
    }

    return switch (_type) {
      SalyButtonType.ghost => context.colors.neutralSecondaryS2,
      _ => context.colors.neutralPrimaryS1,
    };
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: size,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: .all(color: _backgroundColor(context).withValues(alpha: .4)),
            borderRadius: .circular(radius),
          ),
          child: Padding(
            padding: const .all(4),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: isDisabled ? _backgroundDisabledColor(context) : _backgroundColor(context),
                borderRadius: .circular(radius),
                boxShadow:
                    shadow ?? [BoxShadow(color: _backgroundColor(context).withValues(alpha: 0.1), blurRadius: 16)],
              ),
              child: Padding(
                padding: size != null ? const EdgeInsets.all(0) : padding,
                child: Center(
                  child:
                      child ??
                      (title != null
                          ? Text(
                              title!,
                              style:
                                  textStyle ??
                                  context.fonts.subtitle.copyWith(
                                    color: _textColor(context),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                            )
                          : null),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
