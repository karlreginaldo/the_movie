import '../repositories/movie_repository.dart';
import 'package:meta/meta.dart';

class DelFavorite {
  final MovieRepository _repo;

  DelFavorite(this._repo);

  Future<void> call({@required int id}) async =>
      await _repo.delFavorite(id: id);
}
