import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../entities/favorite.dart';
import '../entities/movie.dart';
import '../entities/movie_detail.dart';
import 'package:meta/meta.dart';

abstract class MovieRepository {
  Future<Either<Failure, MovieDetail>> getSpecificMovie({int id});
  Future<Either<Failure, List<Movie>>> searchMovies({String query});
  Future<Either<Failure, List<Movie>>> getInitialPopularMovies();
  Future<Either<Failure, List<Movie>>> chooseGenre({int genreID});
  Future<Either<Failure, List<Favorite>>> getFavorites();
  Future<void> addFavorite({@required Favorite fav});
  Future<void> delFavorite({@required int id});
}
