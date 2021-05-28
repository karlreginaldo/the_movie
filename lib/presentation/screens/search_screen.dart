import 'package:flutter/material.dart';
import '../../domain/entities/movie.dart';
import '../widgets/movie_list_container.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen(
    this.movies, {
    Key key,
  }) : super(key: key);
  final List<Movie> movies;

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.movies
          .map(
            (movie) => MoviesListContainer(
              movie: movie,
            ),
          )
          .toList(),
    );
  }
}
