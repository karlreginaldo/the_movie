import 'package:equatable/equatable.dart';
import 'package:themovie/domain/entities/result.dart';

class Movie extends Equatable {
  Movie({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  final int page;
  final List<Result> results;
  final int totalPages;
  final int totalResults;

  @override
  List<Object> get props => [page, results, totalPages, totalResults];
}
