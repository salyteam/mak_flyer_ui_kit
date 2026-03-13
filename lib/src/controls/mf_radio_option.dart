import 'package:flutter/material.dart';
import 'package:mak_flyer_ui_kit/mak_flyer_ui_kit.dart';

class MFRadioOption extends StatelessWidget {
  const MFRadioOption({required this.title, required this.onTap, required this.isActive, this.emoji, super.key});

  final String title;
  final VoidCallback onTap;
  final bool isActive;
  final String? emoji;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      boxShadow: [
        if (isActive)
          BoxShadow(color: context.colors.shadowColor.withValues(alpha: .1), blurRadius: 16, offset: const .new(0, 4)),
      ],
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: .circular(12),
        child: Ink(
          padding: .fromLTRB(emoji != null ? 16 : 24, 14, 16, 14),
          decoration: BoxDecoration(
            color: context.colors.neutralPrimaryS1,
            border: .all(color: isActive ? context.colors.neutralSecondaryS3 : Colors.transparent),
            borderRadius: .circular(12),
          ),
          child: Row(
            children: [
              if (emoji != null) ...[Text(emoji!, style: context.fonts.body), const SizedBox(width: 12)],
              Expanded(child: Text(title, style: context.fonts.body)),
              const SizedBox(width: 14),
              MFRadioCheck(isActive: isActive),
            ],
          ),
        ),
      ),
    ),
  );
}
