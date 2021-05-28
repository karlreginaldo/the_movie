import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../cubit/genre/genre_cubit.dart';
import '../widgets/movie_list_container.dart';
import '../widgets/popular_list_view_container.dart';
import '../widgets/components/custom_text_quick_sand.dart';
import '../widgets/components/genre_filter_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: CustomTextQuickSand(
            'Popular Movies',
            size: 18.0.sp,
            weight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: PopularListViewContainer(),
        ),
        SizedBox(
          height: 50,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            children: [
              CustomTextQuickSand(
                'Genres',
                size: 18.0.sp,
                weight: FontWeight.bold,
              ),
              SizedBox(
                width: 10,
              ),
              GenreFilterButton(),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: BlocBuilder<GenreCubit, GenreState>(
            builder: (context, state) {
              if (state is GenreLoading) {
                return Center(child: CustomTextQuickSand('Please Wait...'));
              } else if (state is GenreLoaded) {
                return Column(
                  children: [
                    Column(
                      children: state.movies
                          .map((movie) => MoviesListContainer(
                                movie: movie,
                              ))
                          .toList(),
                    ),
                  ],
                );
              }
              return Container();
            },
          ),
        )
      ],
    );
  }
}
