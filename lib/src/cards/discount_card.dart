import 'package:cached_network_image/cached_network_image.dart' show CachedNetworkImage;
import 'package:flutter/material.dart';
import 'package:saly_ui_kit/src/buttons/buttons.dart';
import 'package:saly_ui_kit/src/gen/assets.gen.dart';
import 'package:saly_ui_kit/src/layout/layout.dart';
import 'package:saly_ui_kit/src/utils/extension.dart';

class DiscountCard extends StatelessWidget {
  static const Widget shimmer = Shimmer(height: 430);

  const DiscountCard({
    required this.description,
    required this.name,
    this.sale,
    this.onTap,
    this.onFavoriteTap,
    this.onFavoriteChange,
    this.category,
    this.imgBackground,
    this.companyImg,
    this.isLiked = false,
    this.isShowLike = true,
    this.onMoreTap,
    super.key,
  });

  final String name;
  final String? category, description, imgBackground, companyImg;
  final int? sale;
  final bool isLiked, isShowLike;
  final void Function(bool value)? onFavoriteChange;
  final VoidCallback? onTap, onFavoriteTap, onMoreTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: context.colors.neutralPrimaryS1,
          boxShadow: [BoxShadow(blurRadius: 16, color: context.colors.shadowColor.withValues(alpha: 0.1))],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 3 / 4,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: CachedNetworkImage(
                        imageUrl: imgBackground ?? '',
                        fit: BoxFit.cover,
                        placeholder: (_, __) => SizedBox(
                          height: double.infinity,
                          width: double.infinity,
                          child: DecoratedBox(decoration: BoxDecoration(color: context.colors.neutralSecondaryS3)),
                        ),
                        errorWidget: (context, _, __) => SizedBox(
                          height: double.infinity,
                          width: double.infinity,
                          child: DecoratedBox(decoration: BoxDecoration(color: context.colors.neutralSecondaryS3)),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    right: 16,
                    left: 16,
                    child: _LogoBanner(
                      name: name,
                      imagePath: companyImg,
                      isLiked: isLiked,
                      isShowLike: isShowLike,
                      onFavoriteTap: onFavoriteTap,
                      onFavoriteChange: onFavoriteChange,
                    ),
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Row(
                      spacing: 8,
                      children: [
                        if (category != null) _IndoChip(title: category!),
                        if (sale != null) _IndoChip(title: '-$sale%'),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: _MoreButton(() {
                      onMoreTap?.call();
                    }),
                  ),
                ],
              ),
              if (description != null) ...[
                const SizedBox(height: 8),
                GestureDetector(
                  behavior: .opaque,
                  onTap: onMoreTap,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                    child: Text(description!, maxLines: 2, overflow: TextOverflow.ellipsis, style: context.fonts.body),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _LogoBanner extends StatelessWidget {
  const _LogoBanner({
    required this.isLiked,
    required this.name,
    required this.isShowLike,
    this.onFavoriteChange,
    this.onFavoriteTap,
    this.imagePath,
  });

  final String name;
  final String? imagePath;
  final bool isLiked, isShowLike;
  final void Function(bool value)? onFavoriteChange;
  final VoidCallback? onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: context.colors.neutralPrimaryS1),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: CachedNetworkImage(
                imageUrl: imagePath ?? '',
                height: 59,
                width: 59,
                fit: BoxFit.cover,
                errorWidget: (context, _, __) => SalyAssets.images.restourant.image(fit: BoxFit.cover),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (name.isNotEmpty)
                    Text(name, style: context.fonts.h6, maxLines: 2, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            if (isShowLike)
              SalyLikeButton(initValue: isLiked, onChange: onFavoriteChange, onTap: onFavoriteTap, size: 59),
          ],
        ),
      ),
    );
  }
}

class _IndoChip extends StatelessWidget {
  const _IndoChip({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(color: context.colors.statusAccentS2, borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Text(title, style: context.fonts.subtitle.copyWith(color: context.colors.neutralPrimaryS1)),
    ),
  );
}

class _MoreButton extends StatelessWidget {
  const _MoreButton(this.onTap);

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: SalyAssets.icons.more.svg(
          colorFilter: ColorFilter.mode(context.colors.neutralPrimaryS1, BlendMode.srcIn),
        ),
      ),
    );
  }
}
