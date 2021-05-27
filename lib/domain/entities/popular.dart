import 'package:equatable/equatable.dart';

import 'popular_result.dart';

class Popular extends Equatable {
  Popular({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  final int page;
  final List<PopularResult> results;
  final int totalPages;
  final int totalResults;

  @override
  List<Object> get props => [page, results, totalPages, totalResults];
}
