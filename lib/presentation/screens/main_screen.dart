import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themovie/data/datasources/movie_remote_data_source.dart';
import 'package:http/http.dart' as http;
import 'package:themovie/data/repositories/movie_repository_impl.dart';
import 'package:themovie/presentation/cubit/movie_cubit.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BlocBuilder<MovieCubit, MovieState>(
          builder: (context, state) {
            if (state is MovieInitial) {
              return Text('Wait');
            } else if (state is MovieLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MovieDetailLoaded) {
              return Text(state.movieDetail.originalLanguage);
            }
            return Container();
          },
        ),
        TextButton(
          onPressed: () async {
            context.read<MovieCubit>().getSpecificMovie(id: 550);
          },
          child: Text(
            'Test',
          ),
        ),
      ],
    ));
  }
}
