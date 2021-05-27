import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../core/error/failure.dart';
import '../../core/usecase/usecase.dart';
import '../entities/chose_genre.dart';
import '../repositories/movie_repository.dart';

class ChooseGenre implements UseCase<ChosenGenre, ChooseGenreParams> {
  final MovieRepository _repo;

  ChooseGenre(this._repo);

  @override
  Future<Either<Failure, ChosenGenre>> call(ChooseGenreParams params) async =>
      await _repo.chooseGenre(genreID: params.genreID);
}

class ChooseGenreParams extends Equatable {
  final int genreID;

  ChooseGenreParams(this.genreID);

  @override
  List<Object> get props => [genreID];
}
