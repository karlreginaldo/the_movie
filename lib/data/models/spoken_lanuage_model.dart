import 'package:themovie/domain/entities/spoken_language.dart';

class SpokenLanguageModel extends SpokenLanguage {
  SpokenLanguageModel({
    this.englishName,
    this.iso6391,
    this.name,
  }) : super(englishName: englishName, iso6391: iso6391, name: name);

  final String englishName;
  final String iso6391;
  final String name;

  factory SpokenLanguageModel.fromJson(Map<String, dynamic> json) =>
      SpokenLanguageModel(
        englishName: json["english_name"],
        iso6391: json["iso_639_1"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "english_name": englishName,
        "iso_639_1": iso6391,
        "name": name,
      };
}
