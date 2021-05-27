import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../core/constant/string.dart';
import '../../../domain/entities/movie_detail.dart';
import '../../../domain/usecases/get_specific_movie.dart';
import 'package:meta/meta.dart';
part 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  MovieDetailsCubit(this._getSpecificMovie) : super(MovieDetailsInitial());

  final GetSpecificMovie _getSpecificMovie;

  void getSpecificMovie({@required int id}) async {
    emit(MovieDetailsLoading());
    final _eitherMovieDetailsOrFailure =
        await _getSpecificMovie(GetSpecificMovieParams(id));

    _eitherMovieDetailsOrFailure.fold(
      (failure) => emit(
        MovieDetailsError(SERVER_FAILURE_MESSAGE),
      ),
      (movieDetails) => emit(
        MovieDetailsLoaded(movieDetails),
      ),
    );
  }
}
