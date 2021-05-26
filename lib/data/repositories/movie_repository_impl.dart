import 'package:themovie/core/error/exception.dart';
import 'package:themovie/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:themovie/data/datasources/movie_remote_data_source.dart';
import 'package:themovie/domain/entities/chose_genre.dart';
import 'package:themovie/domain/entities/movie_detail.dart';
import 'package:themovie/domain/entities/movie.dart';
import 'package:themovie/domain/entities/popular.dart';
import 'package:themovie/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource _remote;

  MovieRepositoryImpl(this._remote);

  @override
  Future<Either<Failure, MovieDetail>> getSpecificMovie({int id}) async {
    try {
      final _movie = await _remote.getSpecificMovie(id: id);
      return Right(_movie);
    } on ServerException {
      return Left(
        ServerFailure(),
      );
    }
  }

  @override
  Future<Either<Failure, Movie>> searchMovies({String query}) async {
    try {
      final _movies = await _remote.searchMovies(query: query);
      return Right(_movies);
    } on ServerException {
      return Left(
        ServerFailure(),
      );
    }
  }

  @override
  Future<Either<Failure, Popular>> getInitialPopularMovies() async {
    try {
      final _popularMovies = await _remote.getInitialPopularMovies();
      return Right(_popularMovies);
    } on ServerException {
      return Left(
        ServerFailure(),
      );
    }
  }

  @override
  Future<Either<Failure, ChosenGenre>> chooseGenre({int genreID}) async {
    try {
      final _chosenGenreMovies = await _remote.chooseGenre(genreID: genreID);
      return Right(_chosenGenreMovies);
    } on ServerException {
      return Left(
        ServerFailure(),
      );
    }
  }
}
