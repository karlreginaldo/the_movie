import 'dart:convert';

import 'package:meta/meta.dart';

import '../../domain/entities/favorite.dart';

class FavoriteModel extends Favorite {
  final int id;
  final String title;
  final String overview;
  final double average;
  final List<int> genresId;
  final String posterPath;
  FavoriteModel({
    @required this.id,
    @required this.title,
    @required this.overview,
    @required this.average,
    @required this.genresId,
    @required this.posterPath,
  }) : super(
            average: average,
            id: id,
            overview: overview,
            title: title,
            genresId: genresId,
            posterPath: posterPath);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'overview': overview,
      'average': average,
      'genresId': genresId,
      'posterPath': posterPath,
    };
  }

  factory FavoriteModel.fromMap(Map<String, dynamic> map) {
    return FavoriteModel(
      id: map['id'],
      title: map['title'],
      overview: map['overview'],
      average: map['average'],
      genresId: List<int>.from(map['genresId']),
      posterPath: map['posterPath'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FavoriteModel.fromJson(String source) =>
      FavoriteModel.fromMap(json.decode(source));
}
