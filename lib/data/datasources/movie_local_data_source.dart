import 'package:hive/hive.dart';
import '../models/favorite_model.dart';
import 'package:meta/meta.dart';

abstract class MovieLocalDataSource {
  Future<List<FavoriteModel>> getFavorites();
  Future<void> addFavorite({@required FavoriteModel fav});
  Future<void> delFavorite({@required int id});
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final _storage = Hive.box('favorites');

  @override
  Future<void> addFavorite({FavoriteModel fav}) async {
    _storage.put(fav.id, fav.toMap());
  }

  @override
  Future<void> delFavorite({int id}) async {
    _storage.delete(id);
  }

  @override
  Future<List<FavoriteModel>> getFavorites() async {
    var cacheFavorites = _storage.values.toList();

    final _convertedListOfMap =
        cacheFavorites.map((map) => Map<String, dynamic>.from(map)).toList();

    final _convertedListOfModel =
        _convertedListOfMap.map((map) => FavoriteModel.fromMap(map)).toList();
    return _convertedListOfModel;
  }
}
