import '../entities/favorite.dart';
import '../repositories/movie_repository.dart';
import 'package:meta/meta.dart';

class AddFavorite {
  final MovieRepository _repo;

  AddFavorite(this._repo);

  Future<void> call({@required Favorite fav}) async =>
      await _repo.addFavorite(fav: fav);
}
