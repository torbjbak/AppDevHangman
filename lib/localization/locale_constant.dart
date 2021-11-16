import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

// Utility file for locale functionality and SharedPreferences

const String prefSelectedLanguageCode = "SelectedLanguageCode";

// Set locale in SharedPreferences, return Locale object
Future<Locale> setLocale(String languageCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(prefSelectedLanguageCode, languageCode);
  return _locale(languageCode);
}

// Get current locale from SharedPreferences, return Locale object
Future<Locale> getLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString(prefSelectedLanguageCode) ?? "en";
  return _locale(languageCode);
}

// Get Locale object based on language code
Locale _locale(String languageCode) {
  return languageCode != null && languageCode.isNotEmpty
      ? Locale(languageCode, '')
      : const Locale('en', '');
}

// Changed language of current build context, first update SharedPreferences,
// then use then setLocale function in the main app class to update locale.
void changeLanguage(BuildContext context, String selectedLanguageCode) async {
  var _locale = await setLocale(selectedLanguageCode);
  HangmanApp.setLocale(context, _locale);
}