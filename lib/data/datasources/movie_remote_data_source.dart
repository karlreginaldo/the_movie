import 'dart:convert';
import 'dart:math';
import '../../core/constant/string.dart';
import '../../core/error/exception.dart';
import '../models/movie_detail_model.dart';
import 'package:meta/meta.dart';
import '../models/movie_model.dart';
import 'package:http/http.dart' as http;

abstract class MovieRemoteDataSource {
  Future<MovieDetailModel> getSpecificMovie({@required int id});

  Future<List<MovieModel>> searchMovies({@required String query});

  Future<List<MovieModel>> getInitialPopularMovies();

  Future<List<MovieModel>> chooseGenre({@required int genreID});
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
  Future<List<MovieModel>> searchMovies({String query}) async => _getMovieList(
      'https://api.themoviedb.org/3/search/movie?api_key=$API_KEY&query=$query');

  @override
  Future<List<MovieModel>> getInitialPopularMovies() => _getMovieList(
      'https://api.themoviedb.org/3/movie/popular?api_key=$API_KEY&language=en-US&page=${Random().nextInt(500)}');

  @override
  Future<List<MovieModel>> chooseGenre({int genreID}) async => _getMovieList(
      'https://api.themoviedb.org/3/discover/movie?api_key=$API_KEY&with_genres=$genreID');

  Future<List<MovieModel>> _getMovieList(String url) async {
    final _response = await _client.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );
    final Map<String, dynamic> decoded = json.decode(_response.body);

    final List<dynamic> movies = decoded['results'];

    List<MovieModel> movieList = [];

    movies.forEach((json) {
      movieList.add(MovieModel.fromJson(json));
    });

    return _response.statusCode == 200 ? movieList : throw ServerException();
  }
}
