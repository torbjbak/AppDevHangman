import 'dart:html';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'dart:math';

import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

// The main application
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Widget playSection = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          child: TextFormField(
            decoration: const InputDecoration(
              hintText: 'Letter',
            ),
            inputFormatters: [
              LengthLimitingTextInputFormatter(1)
            ],
          ),
          width: 80,
        ),
        ElevatedButton(
            onPressed: () {  },
            child: const Text('Play'),
        ),
      ],
    );


    Widget startSection = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          child: TextFormField(
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'3-9'))
            ],
          ),
          width: 80,
        ),
        ElevatedButton(
          onPressed: () {  },
          child: const Text('Start new game'),
        ),
      ],
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hangman',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('Hangman'),
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
                  Image.asset(
                    'images/hangman.jpg',
                  ),
                  playSection,
                ]
              ),
              startSection,
            ],
          ),
        ),
      ),
    );
  }
}

// Widget for the home page of your application. It is stateful, meaning
// that it has a State object that contains fields that affect how it looks.
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _word = "";
  var rng = Random();
  // var wordList = nouns.sort((a, b) => a.length.compareTo(b.length));

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  /*void _decrementCounter() {
    setState(() {

      _counter--;
    });
  }*/

  void _pressButton() {
    int words = 1000;
    setState(() {
      _word = nouns.take(words).elementAt(rng.nextInt(words));
    });
  }

  void handleClick(String value) {
    switch (value) {
      case 'Language':
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: handleClick,
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
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see thre wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_word),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('test'),
                ElevatedButton(
                    onPressed: _pressButton, child: const Text('Button')),
              ],
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.exposure_plus_1),
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: _decrementCounter,
        tooltip: 'Decrement',
        child: const Icon(Icons.exposure_minus_1),
      ),*/// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
