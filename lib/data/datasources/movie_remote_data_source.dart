import 'dart:convert';

import 'package:themovie/core/constant/string.dart';
import 'package:themovie/core/error/exception.dart';
import 'package:themovie/data/models/movie_detail_model.dart';

import 'package:meta/meta.dart';
import 'package:themovie/data/models/movie_model.dart';
import 'package:http/http.dart' as http;

abstract class MovieRemoteDataSource {
  ///Link https://api.themoviedb.org/3/movie/$id?api_key=API_KEY
  Future<MovieDetailModel> getSpecificMovie({@required int id});

  ///Link:https://api.themoviedb.org/3/search/movie?api_key=API_KEY&query=$query
  Future<MovieModel> searchMovies({@required String query});
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final http.Client _client;

  MovieRemoteDataSourceImpl(this._client);

  @override
  Future<MovieDetailModel> getSpecificMovie({int id}) async =>
      await _getResponse(
          'https://api.themoviedb.org/3/movie/$id?api_key=$API_KEY');

  @override
  Future<MovieModel> searchMovies({String query}) async => await _getResponse(
      'https://api.themoviedb.org/3/search/movie?api_key=$API_KEY&query=$query');

  Future<dynamic> _getResponse(String url) async {
    final _response = await _client.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );
    return _response.statusCode == 200
        ? MovieModel.fromJson(json.decode(_response.body))
        : throw ServerException();
  }
}
