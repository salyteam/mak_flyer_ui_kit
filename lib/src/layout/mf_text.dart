import 'package:flutter/material.dart';
import 'package:mak_flyer_ui_kit/mak_flyer_ui_kit.dart';

enum TextType { h1, h2, h3, h4, h5, h6, subtitle, body, small }

class MFText extends StatelessWidget {
  const MFText.body(this.text, {this.color, this.overflow, this.lines, this.align, super.key}) : type = TextType.body;
  const MFText.small(this.text, {this.color, this.overflow, this.lines, this.align, super.key}) : type = TextType.small;
  const MFText.subtitle(this.text, {this.color, this.overflow, this.lines, this.align, super.key})
    : type = TextType.subtitle;
  const MFText.h6(this.text, {this.color, this.overflow, this.lines, this.align, super.key}) : type = TextType.h6;
  const MFText.h5(this.text, {this.color, this.overflow, this.lines, this.align, super.key}) : type = TextType.h5;
  const MFText.h4(this.text, {this.color, this.overflow, this.lines, this.align, super.key}) : type = TextType.h4;
  const MFText.h3(this.text, {this.color, this.overflow, this.lines, this.align, super.key}) : type = TextType.h3;
  const MFText.h2(this.text, {this.color, this.overflow, this.lines, this.align, super.key}) : type = TextType.h2;
  const MFText.h1(this.text, {this.color, this.overflow, this.lines, this.align, super.key}) : type = TextType.h1;

  final int? lines;
  final String text;
  final Color? color;
  final TextType type;
  final TextOverflow? overflow;
  final TextAlign? align;

  @override
  Widget build(BuildContext context) {
    var style = switch (type) {
      TextType.small => context.fonts.small,
      TextType.body => context.fonts.body,
      TextType.subtitle => context.fonts.subtitle,
      TextType.h6 => context.fonts.h6,
      TextType.h5 => context.fonts.h5,
      TextType.h4 => context.fonts.h4,
      TextType.h3 => context.fonts.h3,
      TextType.h2 => context.fonts.h2,
      TextType.h1 => context.fonts.h1,
    };

    if (color != null) {
      style = style.copyWith(color: color);
    }

    return Text(text, style: style, overflow: overflow, maxLines: lines, textAlign: align);
  }
}
