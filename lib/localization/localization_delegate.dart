import 'package:flutter/material.dart';

import 'language.dart';
import 'language_en.dart';
import 'language_no.dart';

// Specialized implementation of LocalizationDelegate, used
class AppLocalizationDelegate extends LocalizationsDelegate<Language> {
  const AppLocalizationDelegate();

  // Method that tells whether a given Locale is supported by the app
  @override
  bool isSupported(Locale locale) =>
      ['en', 'no'].contains(locale.languageCode);

  // Method that returns the correct Language class based on the given locale
  @override
  Future<Language> load(Locale locale) => _load(locale);

  // Helper method for the load method, returns supported Language class
  static Future<Language> _load(Locale locale) async {
    switch (locale.languageCode) {
      case 'en':
        return LanguageEn();
      case 'no':
        return LanguageNo();
      default:
        return LanguageEn();
    }
  }

  // Method that tells whether the resources for this delegate
  // should be loaded again when calling the load method
  @override
  bool shouldReload(LocalizationsDelegate<Language> old) => false;
}