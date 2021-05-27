import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Favorite extends Equatable {
  final int id;
  final String title;
  final String overview;
  final double average;
  final List<int> genresId;
  final String posterPath;
  Favorite({
    @required this.id,
    @required this.title,
    @required this.overview,
    @required this.average,
    @required this.genresId,
    @required this.posterPath,
  });

  @override
  List<Object> get props {
    return [
      id,
      title,
      overview,
      average,
      genresId,
      posterPath,
    ];
  }
}
