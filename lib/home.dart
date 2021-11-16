import 'dart:math';

import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'localization/language.dart';
import 'localization/language_data.dart';
import 'localization/locale_constant.dart';

// Enum identifying each game state image
enum PictureMarker {
  hangman, zero, one,
  two, three, four,
  five, gameover, victory
}

//
class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
  int _wrongCounter = 0;
  List<String> _word = [];
  List<bool> _correct = [];
  bool _playing = false;
  var rng = Random();
  var wordList = nouns;
  int _infoTextIndex = 0;

  TextEditingController startController = TextEditingController();
  TextEditingController playController = TextEditingController();
  PictureMarker selectedPicture = PictureMarker.hangman;

  void _startButton() {
    setState(() {
      _infoTextIndex = 1;
      _wrongCounter = 0;
      _word = _getWord(int.parse(startController.value.text)).toUpperCase().split('');
      _correct = List.filled(_word.length, false);
      print(_word.toString() +" | "+ _correct.toString());
      _playing = true;
      selectedPicture = PictureMarker.zero;
      startController.clear();
      playController.clear();
    });
  }

  void _playButton() {
    setState(() {
      _checkMove(playController.text.toUpperCase());
      print(_word.toString() +" | "+ _correct.toString());
      startController.clear();
      playController.clear();
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
      _checkWin(letter);
      print("'" + letter + "' is correct!");
    } else {
      _wrongCounter++;
      _checkGameOver(letter);
      print("'" + letter + "' is not correct!");
    }
  }

  void _checkWin(String letter) {
    bool win = true;
    for(var e in _correct) {
      if(!e) {
        win = false;
      }
    }
    if(win) {
      print("Correct, you won!");
      _playing = false;
      _infoTextIndex = 4;
      selectedPicture = PictureMarker.victory;
    } else {
      _infoTextIndex = 2;
    }
  }

  void _checkGameOver(String letter) {
    if(_wrongCounter > 5) {
      print("Wrong, you lost the game!");
      _playing = false;
      _infoTextIndex = 5;
      selectedPicture = PictureMarker.gameover;
    } else {
      _infoTextIndex = 3;
      setPicture();
    }
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
      default:
        return Image.asset('images/hangman.jpg');
    }
  }

  TextStyle spookyTextBig = const TextStyle(
    fontFamily: 'Halloween',
    fontSize: 16,
  );

  TextStyle spookyTextSmall = const TextStyle(
    fontFamily: 'Halloween',
    fontSize: 10,
  );

  TextStyle spookyTextTiny = const TextStyle(
    fontFamily: 'Halloween',
    fontSize: 8,
  );

  TextStyle textNormal = const TextStyle(
    fontSize: 16,
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

  // Method used to update single character in input and keep the
  // cursor at the end setState used to update buttons on input
  void _changeTextField(String value, TextEditingController controller) {
    setState(() {
      if (value.length > 1) {
        controller.text = value.substring(value.length - 1);
        controller.selection =
            TextSelection.fromPosition(const TextPosition(offset: 1));
      }
    });
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
          Text(String.fromCharCode(773) + ' ', style: textNormal),
        ],
      );
    }
    // Row Widget containing the play input for selecting
    // a letter and the button for submitting said letter
    Widget inputSection = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          child: TextField(
            controller: playController,
            keyboardType: TextInputType.text,
            textAlign: TextAlign.center,
            onChanged: (value) {
              _changeTextField(value, playController);
            },
            decoration: InputDecoration(
              hintStyle: textNormal,
              hintText: Language.of(context).letterHint,
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
          child: Text(Language.of(context).playButton, style: spookyTextSmall),
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
            textAlign: TextAlign.center,
            onChanged: (value) {
              _changeTextField(value, startController);
            },
            decoration: InputDecoration(
              hintStyle: textNormal,
              hintText: Language.of(context).wordLengthHint,
            ),
            inputFormatters: [
              FilteringTextInputFormatter(RegExp(r'[3-9]'), allow: true),
            ],
          ),
          width: 110,
        ),
        ElevatedButton(
          onPressed: startController.text.isNotEmpty ? _startButton : null,
          child: Text(Language.of(context).startButton, style: spookyTextSmall),
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
          child: Text(
            Language.of(context).infoText[_infoTextIndex],
            style: textNormal,
          ),
        ),
        startSection,
      ],
    );
    // App home section containing AppBar, info panel and main section.
    return Scaffold(
      appBar: AppBar(
        title: Text(Language.of(context).appTitle, style: spookyTextBig),
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
      body: SlidingUpPanel(
        header:
          Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
            child: Text(Language.of(context).rulesTitle, style: spookyTextTiny,)
          ),
        minHeight: 32,
        maxHeight: 360,
        panel: Container(
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
          child: Text(
            Language.of(context).gameRules,
            style: textNormal,
          ),
        ),
        body: mainSection,
      ),
    );
  }
}
