import 'package:flutter/material.dart';
import 'package:mak_flyer_ui_kit/mak_flyer_ui_kit.dart';

class MFLoader extends StatefulWidget {
  const MFLoader({this.padding, this.color, super.key});

  final EdgeInsets? padding;
  final Color? color;

  @override
  State<MFLoader> createState() => _MFLoaderState();
}

class _MFLoaderState extends State<MFLoader> with SingleTickerProviderStateMixin {
  final _duration = Durations.long2;
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(duration: _duration, vsync: this)..repeat(reverse: true);
    _animation = Tween<double>(
      begin: 0.8,
      end: 1.1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.all(16),
      child: ScaleTransition(
        scale: _animation,
        child: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(color: widget.color ?? context.colors.statusAccentS1, shape: BoxShape.circle),
        ),
      ),
    );
  }
}
