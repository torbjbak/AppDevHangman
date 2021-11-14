import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'home.dart';
import 'localization/locale_constant.dart';
import 'localization/localization_delegate.dart';

void main() => runApp(const HangmanApp());


class HangmanApp extends StatefulWidget {
  const HangmanApp({Key key}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_HangmanAppState>();
    state.setLocale(newLocale);
  }

  @override
  State<StatefulWidget> createState() => _HangmanAppState();
}

// The state of the main app, used to save and display changes
class _HangmanAppState extends State<HangmanApp> {
  Locale _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() async {
    getLocale().then((locale) {
      setState(() {
        _locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // build method returns a Scaffold containing the AppBar and the homepage
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: _locale,
      title: 'Hangman',
      theme: ThemeData(
        primarySwatch: const MaterialColor(
          0xFF000000,
          <int, Color>{
            50: Color(0xFF000000),
            100: Color(0xFF000000),
            200: Color(0xFF000000),
            300: Color(0xFF000000),
            400: Color(0xFF000000),
            500: Color(0xFF000000),
            600: Color(0xFF000000),
            700: Color(0xFF000000),
            800: Color(0xFF000000),
            900: Color(0xFF000000),
          },
        ),
      ),
      supportedLocales: const [
        Locale('en', ''),
        Locale('no', ''),
      ],
      localizationsDelegates: const [
        AppLocalizationDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode &&
              supportedLocale.countryCode == locale?.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      home: const Home(),
    );
  }
}
