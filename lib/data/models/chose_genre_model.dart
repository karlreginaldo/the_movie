// To parse this JSON data, do
//
//     final chosenGenreModel = chosenGenreModelFromJson(jsonString);

import 'dart:convert';

import 'package:themovie/domain/entities/chose_genre.dart';

import 'chose_genre_result_model.dart';

ChosenGenreModel chosenGenreModelFromJson(String str) =>
    ChosenGenreModel.fromJson(json.decode(str));

String chosenGenreModelToJson(ChosenGenreModel data) =>
    json.encode(data.toJson());

class ChosenGenreModel extends ChosenGenre {
  ChosenGenreModel({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  }) : super(
            page: page,
            results: results,
            totalPages: totalPages,
            totalResults: totalResults);

  final int page;
  final List<ChosenGenreResultModel> results;
  final int totalPages;
  final int totalResults;

  factory ChosenGenreModel.fromJson(Map<String, dynamic> json) =>
      ChosenGenreModel(
        page: json["page"],
        results: List<ChosenGenreResultModel>.from(
            json["results"].map((x) => ChosenGenreResultModel.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}
