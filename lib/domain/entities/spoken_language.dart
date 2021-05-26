import 'package:equatable/equatable.dart';

class SpokenLanguage extends Equatable {
  SpokenLanguage({
    this.englishName,
    this.iso6391,
    this.name,
  });

  final String englishName;
  final String iso6391;
  final String name;

  @override
  List<Object> get props => [englishName, iso6391, name];
}
