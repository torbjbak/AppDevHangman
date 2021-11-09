import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'dart:math';
import 'package:flutter/services.dart';

enum PictureMarker { hangman, zero, one, two, three, four, five, gameover }
void main() => runApp(const MyApp());

// The main application
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hangman',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const HomePage(title: 'Hangman')
    );
  }
}

// A stateful widget for the homepage, used in main App
class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

// The state of the homepage widget, used to save and display changes
class _HomePageState extends State<HomePage> {
  int _wrongCounter = 0;
  List<String> _word = [];
  List<bool> _correct = [];
  bool _playing = false;
  var rng = Random();
  var wordList = nouns;
  TextEditingController startController = TextEditingController();
  TextEditingController playController = TextEditingController();
  PictureMarker selectedPicture = PictureMarker.hangman;

  String test = "test";

  void _handleClick(String value) {
    switch (value) {
      case 'Language':
        break;
    }
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
      selectedPicture = PictureMarker.hangman;
      _reset();
    }
  }

  void _checkGameOver() {
    if(_wrongCounter > 5) {
      print("Wrong, you lost the game!");
      _reset();
      selectedPicture = PictureMarker.gameover;
    } else {
      setPicture();
    }
  }

  void _reset() {
    _wrongCounter = 0;
    _word = [];
    _correct = [];
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
    String img = 'images/hangman.jpg';
    switch(selectedPicture) {
      case PictureMarker.hangman:
        img = 'images/hangman.jpg';
        break;
      case PictureMarker.zero:
        img = 'images/zero.jpg';
        break;
      case PictureMarker.one:
        img = 'images/one.jpg';
        break;
      case PictureMarker.two:
        img = 'images/two.jpg';
        break;
      case PictureMarker.three:
        img = 'images/three.jpg';
        break;
      case PictureMarker.four:
        img = 'images/four.jpg';
        break;
      case PictureMarker.five:
        img = 'images/five.jpg';
        break;
      case PictureMarker.gameover:
        img = 'images/gameover.jpg';
        break;
    }
    return Image.asset(img);
  }

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
    // Row Widget containing the play input for selecting
    // a letter and the button for submitting said letter
    Widget playSection = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          child: TextField(
            controller: playController,
            onChanged: (value) {
              _changeTextField(value, playController);
            },
            decoration: const InputDecoration(
              hintText: 'Letter',
            ),
            inputFormatters: [
              FilteringTextInputFormatter(
                  RegExp(r'[a-z]', caseSensitive: false),
                  allow: true
              ),
            ],
          ),
          width: 80,
        ),
        ElevatedButton(
          onPressed: _playing && playController.text.isNotEmpty  ? _playButton : null,
          child: const Text('Play'),
        ),
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
            onChanged: (value) {
              _changeTextField(value, startController);
            },
            decoration: const InputDecoration(
              hintText: 'Word length',
            ),
            inputFormatters: [
              FilteringTextInputFormatter(RegExp(r'[3-9]'), allow: true),
            ],
          ),
          width: 100,
        ),
        ElevatedButton(
          onPressed: startController.text.isNotEmpty ? _startButton : null,
          child: const Text('Start game'),
        ),
      ],
    );

    // Widget for showing the correctly guessed letters of the word
    // as items in a ListView. Not yet guessed letters are hidden.
    Widget _listBuilder(BuildContext context, int index) {
      TextStyle style = const TextStyle(
        fontSize: 20,
        fontFamily: 'Arial',
      );
      return Column(
        children: [
          Text(_correct[index] ? _word[index] + ' ' : '  ', style: style),
          Text(String.fromCharCode(773) + ' ', style: style),
        ],
      );
    }

    // build method returns a Scaffold containing the AppBar and the homepage
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) {
              return {'Language'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                SizedBox(
                  child: getPicture(),
                  height: MediaQuery.of(context).size.width * 600 / 790,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 600 / 790,
                  child: Column(
                      children: [
                        Flexible(
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _word.length,
                              itemBuilder: _listBuilder,
                          ),
                        ),
                        playSection,
                    ],
                  ),
                ),
              ],
            ),
            startSection,
          ],
        ),
      ),
    );
  }
}
