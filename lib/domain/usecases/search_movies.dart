import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:themovie/core/error/failure.dart';
import 'package:themovie/core/usecase/usecase.dart';
import 'package:themovie/domain/entities/movie.dart';
import 'package:themovie/domain/entities/movie_detail.dart';
import 'package:themovie/domain/repositories/movie_repository.dart';

class SearchMovies implements UseCase<Movie, SearchMoviesParams> {
  final MovieRepository _repo;

  SearchMovies(this._repo);

  @override
  Future<Either<Failure, Movie>> call(SearchMoviesParams params) async =>
      await _repo.searchMovies(query: params.query);
}

class SearchMoviesParams extends Equatable {
  final String query;

  SearchMoviesParams(this.query);
  @override
  List<Object> get props => throw UnimplementedError();
}
