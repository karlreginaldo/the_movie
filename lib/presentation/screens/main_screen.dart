import 'package:flutter/material.dart';
import 'package:themovie/data/datasources/movie_remote_data_source.dart';
import 'package:http/http.dart' as http;
import 'package:themovie/data/repositories/movie_repository_impl.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  MovieRemoteDataSourceImpl remote = MovieRemoteDataSourceImpl(http.Client());
  @override
  Widget build(BuildContext context) {
    MovieRepositoryImpl repo = MovieRepositoryImpl(remote);

    return Scaffold(
        body: Container(
      child: Center(
        child: TextButton(
          onPressed: () async {
            final result = await repo.searchMovies(query: 'Fight');
            result.fold(
                (failure) => print(failure), (right) => print(right.results));
          },
          child: Text(
            'Test',
          ),
        ),
      ),
    ));
  }
}
