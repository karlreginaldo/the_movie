import 'package:equatable/equatable.dart';

import 'chose_genre_result.dart';

class ChosenGenre extends Equatable {
  ChosenGenre({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  final int page;
  final List<ChosenGenreResult> results;
  final int totalPages;
  final int totalResults;

  @override
  List<Object> get props => [page, results, totalPages, totalResults];
}
