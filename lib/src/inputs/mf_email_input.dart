import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mak_flyer_ui_kit/mak_flyer_ui_kit.dart';
import 'package:reactive_forms/reactive_forms.dart';

class MFEmailInput extends StatefulWidget {
  const MFEmailInput({this.control, this.onSubmitted, this.onValidityChanged, this.onChanged, super.key});

  final FormControl<String>? control;
  final void Function(FormControl<String> control)? onSubmitted;
  final void Function(FormControl<String> control)? onChanged;
  final void Function(bool isValid)? onValidityChanged;

  @override
  State<MFEmailInput> createState() => _MFEmailInputState();
}

class _MFEmailInputState extends State<MFEmailInput> {
  late final FormControl<String> _control;
  late final StreamSubscription<bool> _focusSubscription;

  BorderRadius get _borderRadius => BorderRadius.circular(12);

  bool get _isValid => (_control.validators.first.validate(_control) ?? {}).isEmpty;

  Color get _borderColor {
    if (_isValid && _control.isNotNullOrEmpty) return context.colors.statusOkS1;
    if (!_isValid && !_control.hasFocus) return context.colors.statusErrorS1;
    return context.colors.neutralSecondaryS3;
  }

  Color get _suffixIconColor {
    if (_control.hasFocus) return context.colors.statusInfoS1;
    if (!_isValid && !_control.hasFocus) return context.colors.statusErrorS1;
    if (_isValid && _control.isNotNullOrEmpty) return context.colors.statusOkS1;
    return context.colors.neutralSecondaryS4;
  }

  Color get _fillColor {
    if (_control.hasFocus) return context.colors.neutralPrimaryS1;
    if (_isValid && _control.isNotNullOrEmpty) return context.colors.statusOkS2;
    if (!_isValid && !_control.hasFocus) return context.colors.statusErrorS3;
    return context.colors.neutralPrimaryS1;
  }

  @override
  void initState() {
    super.initState();
    _control = widget.control ?? FormControl<String>();
    _focusSubscription = _control.focusChanges.listen(_focusListener);
  }

  @override
  void dispose() {
    _focusSubscription.cancel();
    if (widget.control == null) {
      _control.dispose();
    }
    super.dispose();
  }

  void _focusListener(bool isFocused) {
    setState(() {});

    if (isFocused) {
      _control.removeError("format");
      return;
    }

    if (!_isValid) {
      _control.setErrors({"format": false});
    }

    widget.onValidityChanged?.call(_isValid && _control.isNotNullOrEmpty);
  }

  Widget _buildSuffixIcon() {
    return Padding(
      padding: const EdgeInsetsGeometry.only(right: 16),
      child: AnimatedSwitcher(
        duration: Durations.short4,
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,
        child: MFAssets.icons.email.svg(
          key: ValueKey(_control.hasFocus),
          colorFilter: ColorFilter.mode(_suffixIconColor, BlendMode.srcIn),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField<String>(
      formControl: _control,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      showErrors: (_) => false,
      cursorHeight: 16,
      cursorColor: context.colors.statusInfoS1,
      style: context.fonts.body,
      decoration: InputDecoration(
        fillColor: _fillColor,
        filled: true,
        hintText: "Введите свою почту...",
        hintStyle: context.fonts.body.copyWith(color: context.colors.neutralSecondaryS4),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        suffixIconConstraints: const BoxConstraints(maxHeight: 20),
        suffixIcon: _buildSuffixIcon(),
        border: OutlineInputBorder(
          borderRadius: _borderRadius,
          borderSide: BorderSide(color: context.colors.neutralSecondaryS3),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: _borderRadius,
          borderSide: BorderSide(color: _borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: _borderRadius,
          borderSide: BorderSide(color: context.colors.statusInfoS1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: _borderRadius,
          borderSide: BorderSide(color: context.colors.statusErrorS1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: _borderRadius,
          borderSide: BorderSide(color: context.colors.statusErrorS1),
        ),
      ),
    );
  }
}
