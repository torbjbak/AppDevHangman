import 'language.dart';

// Norwegian translations of the abstract Language class.
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
  @override List<String> get infoText => [
    "Velg en ordlengde mellom 3 & 9 og start spillet!",
    "Velg en bokstav (a-z)!",
    "Riktig, prøv på neste bokstav!",
    "Feil, prøv igjen!",
    "Riktig, du vant spillet!",
    "Feil, du tapte spillet (og livet ditt)!"
  ];

  // Game rules
  @override String get rulesTitle => "Spilleregler";
  @override String get gameRules =>
      "1. Velg lengden på ordet du skal gjette (lengre = vanskeligere).\n"
      "2. Et tilfeldig engelsk substantiv med den lengden blir valgt.\n"
      "3. Gjett en bokstav (a-z). Store/små bokstaver er det samme.\n"
      "4. Hvis du gjetter feil, eller gjetter en bokstav du alt har gjettet, så bygges en del av galgen.\n"
      "5. Hvis du får mer enn fem feil blir galgen ferdig, og du taper spillet.";
}