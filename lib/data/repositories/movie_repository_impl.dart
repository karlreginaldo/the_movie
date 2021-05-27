import '../../core/error/exception.dart';
import '../../core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../datasources/movie_local_data_source.dart';
import '../datasources/movie_remote_data_source.dart';
import '../../domain/entities/chose_genre.dart';
import '../../domain/entities/favorite.dart';
import '../../domain/entities/movie_detail.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/popular.dart';
import '../../domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource _remote;
  final MovieLocalDataSource _local;
  MovieRepositoryImpl(this._remote, this._local);

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
