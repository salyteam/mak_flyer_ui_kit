import 'package:flutter/material.dart';
import 'package:mak_flyer_ui_kit/src/layout/mf_stepper/mf_stepper.dart';

class StepperController extends ChangeNotifier {
  StepperController({int initialIndex = 0}) : _currentIndex = initialIndex;

  final List<StepperStep> _steps = [];
  int _currentIndex = 0;

  int get index => _currentIndex;
  List<StepperStep> get steps => _steps;
  StepperStep get step => _steps[_currentIndex];
  bool get isLastStep => _currentIndex == _steps.length;

  void init(Iterable<StepperStep> steps) {
    _steps.addAll(steps);
  }

  void next() {
    if (_currentIndex < _steps.length - 1) {
      _currentIndex++;
      notifyListeners();
    }
  }
}
