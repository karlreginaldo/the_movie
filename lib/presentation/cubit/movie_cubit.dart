import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:themovie/core/constant/string.dart';

import 'package:themovie/domain/entities/movie.dart';
import 'package:themovie/domain/entities/movie_detail.dart';
import 'package:themovie/domain/usecases/get_specific_movie.dart';
import 'package:themovie/domain/usecases/search_movies.dart';

part 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  MovieCubit({
    GetSpecificMovie getMovie,
    SearchMovies searchMovies,
  })  : _getMovie = getMovie,
        _searchMovies = searchMovies,
        super(
          MovieInitial(),
        );

  final GetSpecificMovie _getMovie;
  final SearchMovies _searchMovies;
  void getSpecificMovie({@required int id}) async {
    emit(MovieLoading());

    final eitherMovieDetailOrFailure =
        await _getMovie(GetSpecificMovieParams(id));

    eitherMovieDetailOrFailure.fold(
      (failure) => emit(
        MovieError(SERVER_FAILURE_MESSAGE),
      ),
      (movieDetail) => emit(
        MovieDetailLoaded(movieDetail),
      ),
    );
  }

  void searchMovies({@required String query}) async {
    emit(
      MovieLoading(),
    );

    final _eitherMoviesOrFailure = await _searchMovies(
      SearchMoviesParams(query),
    );

    _eitherMoviesOrFailure.fold(
      (failure) => emit(
        MovieError(SERVER_FAILURE_MESSAGE),
      ),
      (movie) => emit(
        MovieLoaded(movie),
      ),
    );
  }
}
