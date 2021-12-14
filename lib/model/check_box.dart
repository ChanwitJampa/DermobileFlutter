import 'package:flutter/widgets.dart';

class CheckBoxModal {
  String title;
  bool value;

  CheckBoxModal({required this.title, this.value = false});
}

class WidgetCheckBoxModel {
  String title;
  String trial;
  bool value;

  WidgetCheckBoxModel(
      {required this.title, required this.trial, this.value = false});
}
