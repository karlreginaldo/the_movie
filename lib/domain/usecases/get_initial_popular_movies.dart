import 'package:themovie/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:themovie/core/usecase/usecase.dart';
import 'package:themovie/domain/entities/popular.dart';
import 'package:themovie/domain/repositories/movie_repository.dart';

class GetInitialPopularMovies implements UseCase<Popular, NoParams> {
  final MovieRepository _repo;

  GetInitialPopularMovies(this._repo);

  @override
  Future<Either<Failure, Popular>> call(NoParams params) async =>
      await _repo.getInitialPopularMovies();
}
