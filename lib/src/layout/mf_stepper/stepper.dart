import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mak_flyer_ui_kit/src/layout/mf_stepper/controller.dart';

part 'models.dart';

class SalyStepper extends StatefulWidget {
  const SalyStepper({
    required StepperController controller,
    required Iterable<StepperStep> steps,
    ScrollController? scrollController,
    Curve animationCurve = Curves.easeInOut,
    Duration animationDuration = Durations.medium4,
    Curve scrollCurve = Curves.easeInOut,
    Duration scrollDuration = Durations.long2,
    ValueChanged<StepperStep>? onStepChanged,
    super.key,
  }) : _controller = controller,
       _steps = steps,
       _scrollController = scrollController,
       _animationCurve = animationCurve,
       _animationDuration = animationDuration,
       _scrollCurve = scrollCurve,
       _scrollDuration = scrollDuration,
       _onStepChanged = onStepChanged;

  final StepperController _controller;
  final Iterable<StepperStep> _steps;
  final ScrollController? _scrollController;

  final Curve _animationCurve;
  final Duration _animationDuration;
  final Curve _scrollCurve;
  final Duration _scrollDuration;

  final ValueChanged<StepperStep>? _onStepChanged;

  @override
  State<SalyStepper> createState() => _SalyStepperState();
}

class _SalyStepperState extends State<SalyStepper> with TickerProviderStateMixin {
  late final StepperController _stepController;
  late final ScrollController _scrollController;

  final List<_AnimatedStep> _visibleSteps = [];

  @override
  void initState() {
    super.initState();

    _initControllers();

    _stepController.addListener(_stepListener);
    // _addStep(_currentStep);
    _initStep();
  }

  StepperStep get _currentStep => widget._steps.elementAt(_stepController.index);

  @override
  void dispose() {
    if (widget._scrollController == null) {
      _scrollController.dispose();
    }
    super.dispose();
  }

  void _initControllers() {
    _scrollController = widget._scrollController ?? ScrollController();
    _stepController = widget._controller..init(widget._steps);
  }

  void _stepListener() {
    _onStepChanged();
  }

  void _initStep() {
    final step = _stepController.step;
    final controller = AnimationController(vsync: this, duration: widget._animationDuration);
    final animation = CurvedAnimation(parent: controller, curve: widget._animationCurve);

    final animatedStep = _AnimatedStep(controller: controller, animation: animation, child: step.builder(context));

    _visibleSteps.add(animatedStep);
    controller.forward();
  }

  Future<void> _addStep(StepperStep nextStep) async {
    final controller = AnimationController(vsync: this, duration: widget._animationDuration);
    final animation = CurvedAnimation(parent: controller, curve: widget._animationCurve);

    final animatedStep = _AnimatedStep(controller: controller, animation: animation, child: nextStep.builder(context));

    setState(() => _visibleSteps.add(animatedStep));
    controller.forward();
  }

  Future<void> _onStepChanged() async {
    _addStep(_stepController.step);
    await Future.delayed(Duration.zero).then((_) {
      _scrollView();
      widget._onStepChanged?.call(_currentStep);
    });
  }

  void _scrollView() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final scrollPosition = _scrollController.position;

      if (scrollPosition.hasContentDimensions) {
        final max = scrollPosition.maxScrollExtent;
        _scrollController.animateTo(max, duration: widget._scrollDuration, curve: widget._scrollCurve);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 32,
      children: [for (final step in _visibleSteps) FadeTransition(opacity: step.animation, child: step.child)],
    );
  }
}
