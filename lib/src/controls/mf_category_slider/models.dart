import 'package:flutter/material.dart';

final class CategorySliderItem {
  const CategorySliderItem({required this.value, required this.text, required this.icon, this.key});

  final Key? key;
  final bool value;
  final String text;
  final Widget? icon;
}
