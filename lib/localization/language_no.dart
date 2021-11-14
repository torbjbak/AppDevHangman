import 'language.dart';

class LanguageNo extends Language {

  // AppBar
  @override String get appTitle => "Hangman";
  @override String get language=> "Språk";
  @override String get english => "Engelsk";
  @override String get norwegian => "Norsk";

  // Input hints and buttons
  @override String get letterHint => "Bokstav";
  @override String get playButton => "Spill";
  @override String get wordLengthHint => "Ordlengde";
  @override String get startButton => "Start spillet";

  // Info text strings
  @override String get pickLength => "Velg en ordlengde mellom 3 & 9 og start spillet!";
  @override String get pickLetter => "Velg en bokstav (a-z)!";
  @override String get correctLetter => "' var riktig, prøv for neste bokstav!";
  @override String get wrongLetter => "' var feil, prøv igjen!";
  @override String get youWon => "' var riktig, du vant spillet!";
  @override String get youLost => "' var feil, du tapte spillet (og livet ditt)!";

  // Game rules
  @override String get rulesTitle => "Spilleregler";
  @override String get gameRules =>

      "1. Velg lengden på ordet du skal gjette (lengre = vanskeligere).\n"
      "2. Et tilfeldig engelsk substantiv med den lengden vil bli valgt.\n"
      "3. Gjett en bokstav (a-z). Store/små bokstaver er det samme.\n"
      "4. Hvis du gjetter feil, eller gjetter en bokstav du alt har gjettet, så bygges en del av galgen.\n"
      "5. Hvis du får mer enn fem feil blir galgen ferdig, og du taper spillet.";
}