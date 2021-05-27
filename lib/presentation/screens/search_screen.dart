import 'package:flutter/material.dart';
import '../../domain/entities/movie.dart';
import '../widgets/result_container_for_search.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen(
    this.movie, {
    Key key,
  }) : super(key: key);
  final Movie movie;

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.movie.results
          .map(
            (movie) => ResultContainerForSearch(
              movie: movie,
            ),
          )
          .toList(),
    );
  }
}
