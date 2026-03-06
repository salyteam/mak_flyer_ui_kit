import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mak_flyer_ui_kit/mak_flyer_ui_kit.dart';
import 'package:reactive_forms/reactive_forms.dart';

class MFTextInput<T> extends StatefulWidget {
  const MFTextInput({
    this.suffixIconAsset,
    this.minLines,
    this.maxLines,
    this.maxLength,
    this.hintText,
    this.suffixIcon,
    this.contentPadding,
    this.validationMessages,
    this.control,
    this.inputFormatters,
    this.keyboardType,
    this.focusNode,
    this.readOnly = false,
    this.autofocus = false,
    this.obscureText = false,
    this.hasError = false,
    this.isDisabled = false,
    this.showErrors,
    this.onTap,
    this.onTapOutside,
    this.onSubmitted,
    this.onChanged,
    this.style,
    this.isValid,
    this.suffix,
    this.suffixStyle,
    this.suffixText,
    this.suffixIconConstraints,
    super.key,
  });

  final int? maxLines, minLines, maxLength;
  final String? hintText, suffixText;
  final SvgGenImage? suffixIconAsset;
  final Widget? suffixIcon;
  final Widget? suffix;
  final EdgeInsets? contentPadding;
  final FormControl<dynamic>? control;
  final TextInputType? keyboardType;
  final Map<String, String Function(Object)>? validationMessages;
  final bool Function(FormControl<T>)? showErrors;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(FormControl<T>)? onTap;
  final void Function(PointerDownEvent)? onTapOutside;
  final void Function(FormControl<T>)? onSubmitted;
  final void Function(FormControl<T>)? onChanged;
  final FocusNode? focusNode;
  final TextStyle? style, suffixStyle;
  final bool readOnly, autofocus, obscureText, hasError, isDisabled;
  final bool? isValid;
  final BoxConstraints? suffixIconConstraints;

  @override
  State<MFTextInput> createState() => _MFTextInputState();
}

class _MFTextInputState extends State<MFTextInput> {
  late final FocusNode _focusNode;

  bool get _controlHasError => widget.control?.hasErrors == true && widget.control?.touched == true;

  bool get _hasFocus => _focusNode.hasFocus;

  Color get _borderColor {
    if (_hasFocus) return context.colors.statusInfoS1;
    if (widget.isDisabled) return context.colors.neutralSecondaryS3;
    if (_controlHasError) return context.colors.statusErrorS1;
    if (widget.isValid == true) return context.colors.statusOkS1;
    return context.colors.neutralSecondaryS3;
  }

  Color get _textColor {
    if (widget.isDisabled) return context.colors.neutralSecondaryS6;
    if (_controlHasError) return context.colors.statusErrorS1;
    if (widget.isValid == true) return context.colors.statusOkS1;
    return context.colors.neutralSecondaryS1;
  }

  Color get _cursorColor {
    if (_controlHasError) return context.colors.statusErrorS1;
    return context.colors.neutralSecondaryS4;
  }

  Color get _hintTextColor {
    if (widget.isDisabled) return context.colors.neutralSecondaryS4;
    if (_controlHasError) return context.colors.statusErrorS1;
    return context.colors.neutralSecondaryS4;
  }

  Color get _suffixIconColor {
    if (_controlHasError) return context.colors.statusErrorS1;
    if (widget.isValid == true) return context.colors.statusOkS1;
    return context.colors.neutralSecondaryS4;
  }

  Color get _backgroundColor {
    if (widget.isDisabled) return context.colors.neutralPrimaryS1;
    if (_controlHasError) return context.colors.statusErrorS2;
    if (widget.isValid == true) return context.colors.statusOkS2;
    if (_hasFocus) return context.colors.statusInfoS2;
    return context.colors.neutralPrimaryS1;
  }

  Widget? get _suffixIcon {
    if (widget.suffixIcon != null) {
      return widget.suffixIcon;
    }

    if (widget.suffixIconAsset != null) {
      return Padding(
        padding: const EdgeInsets.only(right: 16),
        child: widget.suffixIconAsset!.svg(colorFilter: ColorFilter.mode(_suffixIconColor, BlendMode.srcIn)),
      );
    }

    return null;
  }

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TapRegion(
      onTapOutside: (detail) {
        widget.onTapOutside?.call(detail);
        _focusNode.unfocus();
        setState(() {});
      },
      child: SizedBox(
        child: Opacity(
          opacity: widget.isDisabled ? 0.6 : 1.0,
          child: DecoratedBox(
            decoration: BoxDecoration(
              boxShadow: [
                if (!_hasFocus) BoxShadow(blurRadius: 16, color: context.colors.shadowColor.withValues(alpha: 0.1)),
              ],
            ),
            child: ReactiveTextField(
              onTap: (details) {
                widget.onTap?.call(details);
                setState(() {});
              },
              focusNode: widget.readOnly ? null : _focusNode,
              showErrors: widget.showErrors ?? (_) => false,
              readOnly: widget.readOnly,
              keyboardType: widget.keyboardType,
              inputFormatters: widget.inputFormatters,
              formControl: widget.control ?? FormControl(),
              onSubmitted: widget.onSubmitted,
              validationMessages: widget.validationMessages,
              style: widget.style ?? context.fonts.body.copyWith(color: _textColor),
              maxLines: widget.maxLines,
              minLines: widget.minLines,
              maxLength: widget.maxLength,
              cursorColor: _cursorColor,
              cursorErrorColor: context.colors.statusErrorS1,
              cursorHeight: 16,
              onChanged: (control) {
                widget.onChanged?.call(control);
                setState(() {});
              },
              decoration: InputDecoration(
                isDense: true,
                hintText: widget.hintText,
                hintStyle: context.fonts.body.copyWith(color: _hintTextColor),
                suffix: widget.suffix,
                filled: true,
                fillColor: _backgroundColor,
                contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16)
                  ..copyWith(
                    top: widget.contentPadding?.top,
                    bottom: widget.contentPadding?.bottom,
                    left: widget.contentPadding?.left,
                    right: widget.contentPadding?.right,
                  ),
                suffixIcon: _suffixIcon,
                suffixText: widget.suffixText,
                suffixStyle: widget.suffixStyle,
                suffixIconColor: _suffixIconColor,
                suffixIconConstraints:
                    widget.suffixIconConstraints ?? const BoxConstraints(maxHeight: 24, maxWidth: 40),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: _borderColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: _borderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: _borderColor),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: _borderColor),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: _borderColor),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
