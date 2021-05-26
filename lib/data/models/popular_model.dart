// To parse this JSON data, do
//
//     final popular = popularFromJson(jsonString);

import 'dart:convert';

import 'package:themovie/data/models/popular_result_model.dart';
import 'package:themovie/domain/entities/popular.dart';

PopularModel popularFromJson(String str) =>
    PopularModel.fromJson(json.decode(str));

String popularToJson(PopularModel data) => json.encode(data.toJson());

class PopularModel extends Popular {
  PopularModel({
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
  final List<PopularResultModel> results;
  final int totalPages;
  final int totalResults;

  factory PopularModel.fromJson(Map<String, dynamic> json) => PopularModel(
        page: json["page"],
        results: List<PopularResultModel>.from(
            json["results"].map((x) => PopularResultModel.fromJson(x))),
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
