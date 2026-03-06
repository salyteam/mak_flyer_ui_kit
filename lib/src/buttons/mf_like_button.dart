import 'package:flutter/material.dart';
import 'package:mak_flyer_ui_kit/mak_flyer_ui_kit.dart';

class MFLikeButton extends StatefulWidget {
  const MFLikeButton({this.onTap, this.onChange, this.initValue = false, this.size = 52, super.key});

  final bool initValue;
  final void Function(bool)? onChange;
  final VoidCallback? onTap;
  final double size;

  @override
  State<MFLikeButton> createState() => _MFLikeButtonState();
}

class _MFLikeButtonState extends State<MFLikeButton> with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late bool _isSelect = widget.initValue;

  late Animation<double> _foregroundHeartSize;
  late Animation<double> _backgroundHeartSize;
  late Animation<double> _backgroundHeartColor;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 250), value: 1);

    _foregroundHeartSize = Tween<double>(
      begin: 1.2,
      end: 1,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.bounceOut));

    _backgroundHeartSize = Tween<double>(
      begin: 0.8,
      end: 1.6,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));

    _backgroundHeartColor = Tween<double>(
      begin: 1,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
  }

  void _onTap() {
    if (widget.onChange != null) {
      setState(() => _isSelect = !_isSelect);
      widget.onChange?.call(_isSelect);
      _animationController.forward(from: 0.0);
    }
    widget.onTap?.call();
  }

  @override
  void didUpdateWidget(covariant MFLikeButton oldWidget) {
    if (oldWidget.initValue != widget.initValue) {
      _isSelect = widget.initValue;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: widget.size,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _onTap,
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (_isSelect) ...[
              if (_animationController.status != AnimationStatus.completed)
                FadeTransition(
                  opacity: _backgroundHeartColor,
                  child: ScaleTransition(
                    scale: _backgroundHeartSize,
                    child: MFAssets.icons.heart.svg(
                      colorFilter: ColorFilter.mode(context.colors.statusErrorS1, BlendMode.srcIn),
                      height: widget.size / 2,
                      width: widget.size / 2,
                    ),
                  ),
                ),

              ScaleTransition(
                scale: _foregroundHeartSize,
                child: MFAssets.icons.heart.svg(
                  colorFilter: ColorFilter.mode(context.colors.statusErrorS1, BlendMode.srcIn),
                  height: widget.size / 2,
                  width: widget.size / 2,
                ),
              ),
            ] else ...[
              MFAssets.icons.heart.svg(
                colorFilter: ColorFilter.mode(context.colors.neutralSecondaryS3, BlendMode.srcIn),
                height: widget.size / 2,
                width: widget.size / 2,
              ),

              if (_animationController.status != AnimationStatus.completed)
                FadeTransition(
                  opacity: _backgroundHeartColor,
                  child: MFAssets.icons.heart.svg(
                    colorFilter: ColorFilter.mode(context.colors.statusErrorS1, BlendMode.srcIn),
                    height: widget.size / 2,
                    width: widget.size / 2,
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
