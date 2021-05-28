import 'package:themovie/data/models/movie_model.dart';

import '../../core/error/exception.dart';
import '../../core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../datasources/movie_local_data_source.dart';
import '../datasources/movie_remote_data_source.dart';
import '../../domain/entities/favorite.dart';
import '../../domain/entities/movie_detail.dart';
import '../../domain/entities/movie.dart';
import '../../domain/repositories/movie_repository.dart';

typedef Future<List<MovieModel>> _MovieList();

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource _remote;
  final MovieLocalDataSource _local;
  MovieRepositoryImpl(this._remote, this._local);

  @override
  Future<Either<Failure, List<Movie>>> searchMovies({String query}) async =>
      _getMovies(() => _remote.searchMovies(query: query));

  @override
  Future<Either<Failure, List<Movie>>> getInitialPopularMovies() async =>
      _getMovies(() => _remote.getInitialPopularMovies());

  @override
  Future<Either<Failure, List<Movie>>> chooseGenre({int genreID}) async =>
      _getMovies(() => _remote.chooseGenre(genreID: genreID));

  Future<Either<Failure, List<Movie>>> _getMovies(
      _MovieList voidCallBack) async {
    try {
      final _movies = await voidCallBack();
      return Right(_movies);
    } on ServerException {
      return Left(
        ServerFailure(),
      );
    }
  }

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
  Future<void> addFavorite({fav}) async => await _local.addFavorite(fav: fav);
  @override
  Future<void> delFavorite({int id}) async => await _local.delFavorite(id: id);

  @override
  Future<Either<Failure, List<Favorite>>> getFavorites() async {
    try {
      final _favorites = await _local.getFavorites();
      return Right(_favorites);
    } on CachceException {
      return Left(
        CacheFailure(),
      );
    }
  }
}
