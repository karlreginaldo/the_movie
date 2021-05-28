import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../core/constant/string.dart';
import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/search_movies.dart';
import 'package:meta/meta.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._searchMovies) : super(HomeInitial());

  final SearchMovies _searchMovies;

  void searchMovies({@required String query}) async {
    if (query.isEmpty) {
      emit(
        SearchEmpty('Please Search Something...'),
      );
    } else {
      emit(
        SearchLoading(),
      );

      final _eitherMoviesOrFailure = await _searchMovies(
        SearchMoviesParams(query),
      );

      _eitherMoviesOrFailure.fold(
        (failure) => emit(SearchError(SERVER_FAILURE_MESSAGE)),
        (movies) => emit(movies.isNotEmpty
            ? MovieLoaded(movies)
            : SearchEmpty('Can\'t find the movie')),
      );
    }
  }

  void goFavorites() {
    emit(Favorites());
  }

  void goHome() {
    emit(HomeInitial());
  }
}
