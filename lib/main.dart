import 'package:app_dev_project/localization/language_data.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'localization/language.dart';
import 'localization/locale_constant.dart';
import 'localization/localization_delegate.dart';

enum PictureMarker {
  hangman, zero, one,
  two, three, four,
  five, gameover, victory
}
void main() => runApp(const App());

// The main application, a stateful Widget
class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: _locale,
      title: 'Hangman',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      supportedLocales: const [
        Locale('en', ''),
        Locale('no', ''),
      ],
      localizationsDelegates: [
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
      home: const HomePage(title: 'Hangman'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_HomePageState>();
    print(state.toString());
    state.setLocale(newLocale);
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

// The state of the main app, used to save and display changes
class _HomePageState extends State<HomePage> {
  Locale _locale;
  int _wrongCounter = 0;
  List<String> _word = [];
  List<bool> _correct = [];
  bool _playing = false;
  var rng = Random();
  var wordList = nouns;

  TextEditingController startController = TextEditingController();
  TextEditingController playController = TextEditingController();
  PictureMarker selectedPicture = PictureMarker.hangman;

  void setLocale(Locale locale) {
    print(locale.toString());
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

  void _startButton() {
    setState(() {
      _wrongCounter = 0;
      _word = _getWord(int.parse(startController.value.text)).toUpperCase().split('');
      _correct = List.filled(_word.length, false);
      print(_word.toString() +" | "+ _correct.toString());
      _playing = true;
      selectedPicture = PictureMarker.zero;
      startController.text = "";
      playController.text = "";
    });
  }

  void _playButton() {
    setState(() {
      _checkMove(playController.text.toUpperCase());
      print(_word.toString() +" | "+ _correct.toString());
      startController.text = "";
      playController.text = "";
    });
  }

  void _checkMove(String letter) {
    int wordLength = _word.length;
    bool correct = false;
    for(int i = 0; i < wordLength; i++) {
      if(letter == _word[i]) {
        if(!_correct[i]) {
          _correct[i] = true;
          correct = true;
        }
      }
    }
    if(correct) {
      _checkWin();
      print("'" + letter + "' is correct!");
    } else {
      _wrongCounter++;
      _checkGameOver();
      print("'" + letter + "' is not correct!");
    }
  }

  void _checkWin() {
    bool win = true;
    for(var e in _correct) {
      if(!e) {
        win = false;
      }
    }
    if(win) {
      print("Correct, you won!");
      _playing = false;
      selectedPicture = PictureMarker.victory;
    }
  }

  void _checkGameOver() {
    if(_wrongCounter > 5) {
      print("Wrong, you lost the game!");
      _playing = false;
      selectedPicture = PictureMarker.gameover;
    } else {
      setPicture();
    }
  }

  String _getWord(int wordLength) {
    int listLength = wordList.length;
    while(true) {
      int randomIndex = rng.nextInt(listLength);
      String word = wordList[randomIndex];
      if(word.length == wordLength) {
        print(word);
        return word;
      }
    }
  }

  // Method used to update single character in input and keep the cursor at the end
  // setState used to update buttons on input
  void _changeTextField(String value, TextEditingController controller) {
    setState(() {
      if (value.length > 1) {
        controller.text = value.substring(value.length - 1);
        controller.selection =
            TextSelection.fromPosition(const TextPosition(offset: 1));
      }
    });
  }
  
  Widget getPicture() {
    switch(selectedPicture) {
      case PictureMarker.hangman:
        return Image.asset('images/hangman.jpg');
      case PictureMarker.zero:
        return Image.asset('images/zero.jpg');
      case PictureMarker.one:
        return Image.asset('images/one.jpg');
      case PictureMarker.two:
        return Image.asset('images/two.jpg');
      case PictureMarker.three:
        return Image.asset('images/three.jpg');
      case PictureMarker.four:
        return Image.asset('images/four.jpg');
      case PictureMarker.five:
        return Image.asset('images/five.jpg');
      case PictureMarker.gameover:
        return Image.asset('images/gameover.jpg');
      case PictureMarker.victory:
        return Image.asset('images/victory.jpg');
    }
  }

  TextStyle spookyTextBig = const TextStyle(
    fontFamily: 'MonsterPumpkin',
    fontFamilyFallback: <String>[
      'Noto Sans CJK SC',
      'Noto Color Emoji',
    ],
    fontSize: 26,
  );

  TextStyle spookyTextSmall = const TextStyle(
    fontFamily: 'MonsterPumpkin',
    fontFamilyFallback: <String>[
      'Noto Sans CJK SC',
      'Noto Color Emoji',
    ],
    fontSize: 18,
  );

  void setPicture() {
    switch(_wrongCounter) {
      case 0:
        selectedPicture = PictureMarker.zero;
        break;
      case 1:
        selectedPicture = PictureMarker.one;
        break;
      case 2:
        selectedPicture = PictureMarker.two;
        break;
      case 3:
        selectedPicture = PictureMarker.three;
        break;
      case 4:
        selectedPicture = PictureMarker.four;
        break;
      case 5:
        selectedPicture = PictureMarker.five;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Widget for showing the correctly guessed letters of the word
    // as items in a ListView. Not yet guessed letters are hidden.
    Widget _listBuilder(BuildContext context, int index) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(_correct[index] ? _word[index] + ' ' : '  ', style: spookyTextSmall),
          Text(String.fromCharCode(773) + ' ', style: spookyTextSmall),
        ],
      );
    }
    // Row Widget containing the play input for selecting
    // a letter and the button for submitting said letter
    Widget inputSection = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          child: TextField(
            controller: playController,
            keyboardType: TextInputType.text,
            onChanged: (value) {
              _changeTextField(value, playController);
            },
            decoration: InputDecoration(
              hintText: Language.of(context)!.letterHint,
            ),
            inputFormatters: [
              FilteringTextInputFormatter(
                  RegExp(r'[a-z]', caseSensitive: false),
                  allow: true
              ),
            ],
          ),
          width: 60,
        ),
        ElevatedButton(
          onPressed: _playing && playController.text.isNotEmpty  ? _playButton : null,
          child: Text(Language.of(context)!.playButton, style: spookyTextSmall),
        ),
      ],
    );
    // Row widget containing the input of the game
    // as well as the guessed letters of the word
    Widget playSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 60,
          width: 180,
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child:ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _word.length,
              itemBuilder: _listBuilder,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(0, 0, 20, 20),
          child: inputSection,
        )
      ],
    );
    // Row Widget containing the input field for selecting the length
    // of the word for the game and the button for starting the game
    Widget startSection = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          child: TextField(
            controller: startController,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              _changeTextField(value, startController);
            },
            decoration: InputDecoration(
              hintText: Language.of(context)!.wordLengthHint,
            ),
            inputFormatters: [
              FilteringTextInputFormatter(RegExp(r'[3-9]'), allow: true),
            ],
          ),
          width: 100,
        ),
        ElevatedButton(
          onPressed: startController.text.isNotEmpty ? _startButton : null,
          child: Text(Language.of(context)!.startButton, style: spookyTextSmall),
        ),
      ],
    );
    // The main section of the app, containing every
    // UI element except the AppBar and the info panel
    Widget mainSection = Column(
        children: [
          getPicture(),
          playSection,
          Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Text(Language.of(context)!.pickLength),
          ),
          startSection,
        ],
    );

    // build method returns a Scaffold containing the AppBar and the homepage
    return Scaffold(
      appBar: AppBar(
        title: Text(Language.of(context)!.appTitle, style: spookyTextBig),
        actions: <Widget>[
          PopupMenuButton<LanguageData>(
            icon: const Icon(Icons.language),
            onSelected: (LanguageData language) {
              changeLanguage(context, language.languageCode);
            },
            itemBuilder: (context) {
              return LanguageData.languageList().map((e) {
                return PopupMenuItem(
                  value: e,
                  child: Text(e.name),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: mainSection,
    );
  }
}
