import 'package:app_dev_project/localization/language.dart';

// English translations of the abstract Language class.
class LanguageEn extends Language {
  // AppBar
  @override String get appTitle => "Hangman";
  @override String get language=> "Language";
  @override String get english => "English";
  @override String get norwegian => "Norwegian";

  // Input hints and buttons
  @override String get letterHint => "Letter";
  @override String get playButton => "Play";
  @override String get wordLengthHint => "Word length";
  @override String get startButton => "Start game";

  // Info text strings
  @override List<String> get infoText => [
    "Pick a word length between 3 & 9 and start the game!",
    "Pick a letter (a-z)!",
    "Correct, try the next letter!",
    "Wrong, try again!",
    "Correct, you won the game!",
    "Wrong, you lost the game (and your life)!"
  ];

  // Game rules
  @override String get rulesTitle => "Game rules";
  @override String get gameRules =>
      "1. Pick the length of the word you have to guess (longer = harder).\n"
      "2. A random English noun of that length will be chosen.\n"
      "3. Guess a letter (a-z). Capitalization is ignored.\n"
      "4. If you guess wrong or guess a letter you already guessed, a piece of the gallows are built.\n"
      "5. If you get more than five wrong the gallows will be completed, and you lose the game.";
}