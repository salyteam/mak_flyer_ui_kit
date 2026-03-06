import 'package:flutter/material.dart';
import 'package:mak_flyer_ui_kit/mak_flyer_ui_kit.dart';

class MFFormRow extends StatelessWidget {
  const MFFormRow({required this.title, required this.onTap, super.key});

  final VoidCallback onTap;
  final String title;

  @override
  Widget build(BuildContext context) => Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Ink(
        decoration: BoxDecoration(
          color: context.colors.neutralPrimaryS1,
          border: Border.all(color: context.colors.neutralSecondaryS3),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11.5),
          child: Row(
            children: [
              Expanded(child: Text(title, style: context.fonts.body)),
              MFAssets.icons.arrowRight.svg(
                colorFilter: ColorFilter.mode(context.colors.neutralSecondaryS2, BlendMode.srcIn),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
