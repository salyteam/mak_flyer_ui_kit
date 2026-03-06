import 'package:flutter/material.dart';
import 'package:mak_flyer_ui_kit/mak_flyer_ui_kit.dart';

class Shimmer extends StatelessWidget {
  const Shimmer({this.radius = 12, this.height = 200, this.width = double.infinity, this.color, super.key});

  final Color? color;
  final double height, width, radius;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: height,
    width: width,
    child: DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: color ?? context.colors.neutralSecondaryS3,
      ),
    ),
  );
}
