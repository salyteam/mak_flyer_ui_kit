import 'package:flutter/material.dart';

abstract class MFPage extends Page {
  const MFPage({this.fullScreenDialog = false, super.arguments, super.key, super.name});

  final bool fullScreenDialog;

  Widget build(BuildContext context);
  @override
  Route<dynamic> createRoute(BuildContext context) => MaterialPageRoute(settings: this, builder: build);
}
