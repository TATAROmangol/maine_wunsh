import 'package:flutter/material.dart';

class DataTextController {
  DataTextController(String initialText)
      : _textNotifier = ValueNotifier(initialText);

  final ValueNotifier<String> _textNotifier;

  ValueNotifier<String> get textNotifier => _textNotifier;

  void setText(String newText) {
    _textNotifier.value = newText;
  }

  void dispose() {
    _textNotifier.dispose();
  }
}