import '../../core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../../core/usecase/usecase.dart';
import '../entities/favorite.dart';
import '../repositories/movie_repository.dart';

class GetFavorites implements UseCase<List<Favorite>, NoParams> {
  final MovieRepository _repo;

  GetFavorites(this._repo);

  @override
  Future<Either<Failure, List<Favorite>>> call(NoParams params) async =>
      await _repo.getFavorites();
}
