import 'dart:convert';

import '../../core/constant/string.dart';
import '../../core/error/exception.dart';
import '../models/chose_genre_model.dart';
import '../models/movie_detail_model.dart';
import 'package:meta/meta.dart';
import '../models/movie_model.dart';
import 'package:http/http.dart' as http;
import '../models/popular_model.dart';

abstract class MovieRemoteDataSource {
  ///Link https://api.themoviedb.org/3/movie/$id?api_key=API_KEY
  Future<MovieDetailModel> getSpecificMovie({@required int id});

  ///Link:https://api.themoviedb.org/3/search/movie?api_key=API_KEY&query=$query
  Future<MovieModel> searchMovies({@required String query});

  Future<PopularModel> getInitialPopularMovies();
  Future<ChosenGenreModel> chooseGenre({@required int genreID});
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final http.Client _client;

  MovieRemoteDataSourceImpl(this._client);

  @override
  Future<MovieDetailModel> getSpecificMovie({int id}) async {
    final _response = await _client.get(
      'https://api.themoviedb.org/3/movie/$id?api_key=$API_KEY',
      headers: {
        'Content-Type': 'application/json',
      },
    );
    return _response.statusCode == 200
        ? MovieDetailModel.fromJson(json.decode(_response.body))
        : throw ServerException();
  }

  @override
  Future<MovieModel> searchMovies({String query}) async {
    final _response = await _client.get(
      'https://api.themoviedb.org/3/search/movie?api_key=$API_KEY&query=$query',
      headers: {
        'Content-Type': 'application/json',
      },
    );
    return _response.statusCode == 200
        ? MovieModel.fromJson(json.decode(_response.body))
        : throw ServerException();
  }

  @override
  Future<PopularModel> getInitialPopularMovies() async {
    final _response = await _client.get(
      'https://api.themoviedb.org/3/movie/popular?api_key=$API_KEY&language=en-US&page=3',
      headers: {
        'Content-Type': 'application/json',
      },
    );
    return _response.statusCode == 200
        ? PopularModel.fromJson(json.decode(_response.body))
        : throw ServerException();
  }

  @override
  Future<ChosenGenreModel> chooseGenre({int genreID}) async {
    final _response = await _client.get(
      'https://api.themoviedb.org/3/discover/movie?api_key=$API_KEY&with_genres=$genreID',
      headers: {
        'Content-Type': 'application/json',
      },
    );
    return _response.statusCode == 200
        ? ChosenGenreModel.fromJson(json.decode(_response.body))
        : throw ServerException();
  }
}
