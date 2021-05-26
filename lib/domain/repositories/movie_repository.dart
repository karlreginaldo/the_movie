import 'package:dartz/dartz.dart';
import 'package:themovie/core/error/failure.dart';
import 'package:themovie/domain/entities/movie.dart';
import 'package:themovie/domain/entities/movie_detail.dart';
import 'package:themovie/domain/entities/popular.dart';

abstract class MovieRepository {
  Future<Either<Failure, MovieDetail>> getSpecificMovie({int id});
  Future<Either<Failure, Movie>> searchMovies({String query});
  Future<Either<Failure, Popular>> getInitialPopularMovies();
}
