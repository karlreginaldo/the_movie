import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/movie.dart';
import '../../../core/constant/string.dart';
import '../../../domain/usecases/choose_genre.dart';
import 'package:meta/meta.dart';
part 'genre_state.dart';

class GenreCubit extends Cubit<GenreState> {
  GenreCubit(this._chooseGenre) : super(GenreInitial());

  final ChooseGenre _chooseGenre;

  void chooseGenre({@required int genreID}) async {
    emit(GenreLoading());

    final _eitherChosenGenreOrFailure =
        await _chooseGenre(ChooseGenreParams(genreID));

    _eitherChosenGenreOrFailure.fold(
        (failure) => emit(GenreError(SERVER_FAILURE_MESSAGE)),
        (movies) => emit(GenreLoaded(movies)));
  }
}
