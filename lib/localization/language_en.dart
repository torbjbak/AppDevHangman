

import 'package:app_dev_project/localization/language.dart';

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
  @override String get pickLength => "Pick a word length between 3 & 9 and start the game!";
  @override String get pickLetter => "Pick a letter (a-z)!";
  @override String get correctLetter => "' was correct, try for the next letter!";
  @override String get wrongLetter => "' was wrong, try again!";
  @override String get youWon => "' was correct, you won the game!";
  @override String get youLost => "' was wrong, you lost the game (and your life)!";

  // Game rules
  @override String get rulesTitle => "Game rules";
  @override String get gameRules =>
      "1. Pick the length of the word you have to guess (longer = harder).\n"
      "2. A random English noun of that length will be chosen.\n"
      "3. Guess a letter (a-z). Capitalization is ignored.\n"
      "4. If you guess wrong or guess a letter you already guessed, a piece of the gallows are built.\n"
      "5. If you get more than five wrong the gallows will be completed, and you lose the game.";
}