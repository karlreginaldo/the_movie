import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../entities/movie.dart';
import '../../core/error/failure.dart';
import '../../core/usecase/usecase.dart';
import '../repositories/movie_repository.dart';

class ChooseGenre implements UseCase<List<Movie>, ChooseGenreParams> {
  final MovieRepository _repo;

  ChooseGenre(this._repo);

  @override
  Future<Either<Failure, List<Movie>>> call(ChooseGenreParams params) async =>
      await _repo.chooseGenre(genreID: params.genreID);
}

class ChooseGenreParams extends Equatable {
  final int genreID;

  ChooseGenreParams(this.genreID);

  @override
  List<Object> get props => [genreID];
}
