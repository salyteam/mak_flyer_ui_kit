import 'package:flutter/material.dart';
import 'package:mak_flyer_ui_kit/mak_flyer_ui_kit.dart';

class MFCategorySlider extends StatefulWidget {
  const MFCategorySlider({required this.items, required this.onChange, this.controller, super.key});

  final List<CategorySliderItem> items;
  final ScrollController? controller;
  final ValueChanged<List<CategorySliderItem>> onChange;

  @override
  State<MFCategorySlider> createState() => _MFCategorySliderState();
}

class _MFCategorySliderState extends State<MFCategorySlider> {
  final _allItems = <CategorySliderItem>[];
  final _currentItems = <CategorySliderItem>[];

  @override
  void initState() {
    super.initState();
    _allItems.addAll(widget.items);
    _currentItems.addAll(_allItems.where((e) => e.value));
  }

  void _onChange(CategorySliderItem item, bool isRemoved) {
    if (isRemoved) {
      setState(() => _currentItems.add(item));
    } else {
      setState(() => _currentItems.remove(item));
    }
    widget.onChange(_currentItems);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: widget.controller,
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 12,
        children: _allItems
            .map((i) => MFCategoryChip(key: i.key, title: i.value.toString(), onTap: () => _onChange(i, i.value)))
            .toList(),
      ),
    );
  }
}
