import '../../core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../../core/usecase/usecase.dart';
import '../entities/popular.dart';
import '../repositories/movie_repository.dart';

class GetInitialPopularMovies implements UseCase<Popular, NoParams> {
  final MovieRepository _repo;

  GetInitialPopularMovies(this._repo);

  @override
  Future<Either<Failure, Popular>> call(NoParams params) async =>
      await _repo.getInitialPopularMovies();
}
