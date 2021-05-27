import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../core/constant/string.dart';
import '../../../core/usecase/usecase.dart';

import '../../../domain/entities/favorite.dart';
import '../../../domain/usecases/add_favorite.dart';
import '../../../domain/usecases/del_favorite.dart';
import '../../../domain/usecases/get_favorites.dart';
import 'package:meta/meta.dart';
part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit({
    @required GetFavorites getFavorites,
    @required AddFavorite addFavorite,
    @required DelFavorite delFavorite,
  })  : _getFavorites = getFavorites,
        _addFavorite = addFavorite,
        _delFavorite = delFavorite,
        super(FavoriteInitial());

  final GetFavorites _getFavorites;
  final AddFavorite _addFavorite;
  final DelFavorite _delFavorite;

  void getFavorites() async {
    emit(FavoriteLoading());

    final _eitherFavoritesOrFailure = await _getFavorites.call(NoParams());

    _eitherFavoritesOrFailure.fold(
        (failure) => emit(FavoriteError(CACHE_FAILURE_MESSAGE)),
        (list) => emit(FavoriteLoaded(list)));
  }

  void addFavorite({@required Favorite fav}) async {
    await _addFavorite(fav: fav);
  }

  void delFavorite({@required int id}) async {
    await _delFavorite(id: id);
  }
}
