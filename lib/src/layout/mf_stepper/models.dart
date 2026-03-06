part of 'stepper.dart';

class StepperStep {
  const StepperStep({required this.builder, this.key});

  final Key? key;
  final Widget Function(BuildContext context) builder;
}

class _AnimatedStep {
  const _AnimatedStep({required this.controller, required this.animation, required this.child});

  final AnimationController controller;
  final Animation<double> animation;
  final Widget child;
}
