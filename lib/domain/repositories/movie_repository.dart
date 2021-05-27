import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../entities/chose_genre.dart';
import '../entities/favorite.dart';
import '../entities/movie.dart';
import '../entities/movie_detail.dart';
import '../entities/popular.dart';
import 'package:meta/meta.dart';

abstract class MovieRepository {
  Future<Either<Failure, MovieDetail>> getSpecificMovie({int id});
  Future<Either<Failure, Movie>> searchMovies({String query});
  Future<Either<Failure, Popular>> getInitialPopularMovies();
  Future<Either<Failure, ChosenGenre>> chooseGenre({int genreID});
  Future<Either<Failure, List<Favorite>>> getFavorites();
  Future<void> addFavorite({@required Favorite fav});
  Future<void> delFavorite({@required int id});
}
