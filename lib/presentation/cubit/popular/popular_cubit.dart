import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../core/constant/string.dart';
import '../../../core/usecase/usecase.dart';
import '../../../domain/entities/popular.dart';
import '../../../domain/usecases/get_initial_popular_movies.dart';

part 'popular_state.dart';

class PopularCubit extends Cubit<PopularState> {
  PopularCubit(this._getInitialPopularMovies) : super(PopularInitial());

  final GetInitialPopularMovies _getInitialPopularMovies;

  void getPopularMovies() async {
    emit(PopularLoading());
    final _eitherPopularMoviesOrFailure =
        await _getInitialPopularMovies(NoParams());

    _eitherPopularMoviesOrFailure.fold(
      (failure) => emit(PopularError(SERVER_FAILURE_MESSAGE)),
      (popular) => emit(
        PopularLoaded(popular),
      ),
    );
  }
}
