import 'package:flutter/material.dart';
import 'package:saly_ui_kit/saly_ui_kit.dart';

class SalyCategoryChip extends StatelessWidget {
  const SalyCategoryChip({
    required this.title,
    this.opacity = 1,
    this.isActive = false,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.onTap,
    this.leading,
    this.padding,
    super.key,
  });

  final double opacity;
  final String title;
  final Widget? leading;
  final EdgeInsets? padding;
  final bool isActive;
  final VoidCallback? onTap;
  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final isDisable = onTap == null;

    return GestureDetector(
      onTap: isDisable ? null : onTap,
      behavior: HitTestBehavior.opaque,
      child: IntrinsicWidth(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: isDisable ? Colors.transparent : context.colors.neutralPrimaryS1,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isActive ? context.colors.statusAccentS1 : context.colors.neutralSecondaryS3,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),

            boxShadow: [BoxShadow(color: context.colors.neutralSecondaryS4.withValues(alpha: 0.1), blurRadius: 16)],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ).copyWith(left: padding?.left, right: padding?.right, top: padding?.top, bottom: padding?.bottom),
            child: Opacity(
              opacity: isDisable ? 0.4 : opacity,
              child: Row(
                mainAxisAlignment: mainAxisAlignment,
                children: [
                  if (leading != null) ...[FittedBox(child: leading), const SizedBox(width: 8)],
                  FittedBox(child: Text(title, style: context.fonts.body)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
