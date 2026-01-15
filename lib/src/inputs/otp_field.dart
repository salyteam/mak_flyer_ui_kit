import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:saly_ui_kit/saly_ui_kit.dart';

class OtpField extends StatelessWidget {
  const OtpField({
    this.controller,
    this.onCompleted,
    this.onChange,
    this.length = 4,
    this.hasError = false,
    this.autofocus = true,
    super.key,
  });

  final int length;
  final bool hasError, autofocus;
  final void Function(String value)? onChange;
  final void Function(String value)? onCompleted;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) => Pinput(
    autofocus: autofocus,
    controller: controller,
    length: length,
    onChanged: onChange,
    onCompleted: onCompleted,
    forceErrorState: hasError,
    errorPinTheme: PinTheme(
      height: MediaQuery.sizeOf(context).width * 0.13,
      width: MediaQuery.sizeOf(context).width * 0.1,
      textStyle: context.fonts.subtitle.copyWith(color: context.colors.statusErrorS1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.colors.statusErrorS1),
        color: context.colors.statusErrorS3,
      ),
    ).copyDecorationWith(),
    defaultPinTheme: PinTheme(
      height: MediaQuery.sizeOf(context).width * 0.13,
      width: MediaQuery.sizeOf(context).width * 0.1,
      textStyle: context.fonts.subtitle,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.colors.neutralSecondaryS3),
        color: context.colors.neutralPrimaryS1,
      ),
    ),
  );
}
