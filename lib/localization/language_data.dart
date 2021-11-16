// Data class containing all supported languages.
class LanguageData {
  final String name;
  final String languageCode;

  LanguageData(this.name, this.languageCode);

  static List<LanguageData> languageList() {
    return <LanguageData>[
      LanguageData('English', 'en'),
      LanguageData('Norsk', 'no'),
    ];
  }
}