import 'package:flutter/material.dart';

import 'language.dart';
import 'language_en.dart';
import 'language_no.dart';

class AppLocalizationDelegate extends LocalizationsDelegate<Language> {
  const AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'no'].contains(locale.languageCode);

  @override
  Future<Language> load(Locale locale) => _load(locale);

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

  @override
  bool shouldReload(LocalizationsDelegate<Language> old) => false;
}