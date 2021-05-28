import '../entities/movie.dart';

import '../../core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../../core/usecase/usecase.dart';
import '../repositories/movie_repository.dart';

class GetInitialPopularMovies implements UseCase<List<Movie>, NoParams> {
  final MovieRepository _repo;

  GetInitialPopularMovies(this._repo);

  @override
  Future<Either<Failure, List<Movie>>> call(NoParams params) async =>
      await _repo.getInitialPopularMovies();
}
