import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mak_flyer_ui_kit/mak_flyer_ui_kit.dart';

class MFImage extends StatelessWidget {
  const MFImage.circle(this.url, {double size = 32, this.radius = 50, super.key}) : aspectRatio = 1, width = size;

  const MFImage.aspectRatio(this.url, {this.width, this.radius = 16, this.aspectRatio = 3 / 4, super.key});

  final String? url;
  final double radius;
  final double? width;
  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    final imagePlaceholder = DecoratedBox(decoration: BoxDecoration(color: context.colors.neutralSecondaryS3));
    final widget = AspectRatio(
      aspectRatio: aspectRatio,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: url ?? '',
          placeholder: (_, _) => imagePlaceholder,
          errorWidget: (context, _, err) => imagePlaceholder,
        ),
      ),
    );

    return width != null ? SizedBox(width: width, child: widget) : widget;
  }
}
