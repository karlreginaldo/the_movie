import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../core/error/failure.dart';

import '../../core/usecase/usecase.dart';
import '../entities/movie.dart';
import '../entities/movie_detail.dart';
import '../repositories/movie_repository.dart';

class GetSpecificMovie implements UseCase<MovieDetail, GetSpecificMovieParams> {
  final MovieRepository _repo;

  GetSpecificMovie(this._repo);
  @override
  Future<Either<Failure, MovieDetail>> call(
          GetSpecificMovieParams params) async =>
      await _repo.getSpecificMovie(id: params.id);
}

class GetSpecificMovieParams extends Equatable {
  final int id;

  GetSpecificMovieParams(this.id);

  @override
  List<Object> get props => [id];
}
