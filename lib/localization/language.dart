import 'package:flutter/material.dart';

abstract class Language {
  static Language of(BuildContext context) {
    return Localizations.of<Language>(context, Language);
  }

  // AppBar
  String get appTitle;
  String get language;
  String get english;
  String get norwegian;

  // Input hints and buttons
  String get letterHint;
  String get playButton;
  String get wordLengthHint;
  String get startButton;

  // Info text strings
  List<String> get infoText;

  // Game rules
  String get rulesTitle;
  String get gameRules;
}