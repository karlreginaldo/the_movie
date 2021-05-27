import 'package:flutter/material.dart';
import '../widgets/components/custom_text_lato.dart';
import '../widgets/components/genre_filter_button.dart';
import '../widgets/result_container_for_genre.dart';
import '../widgets/result_container_for_popular_movies.dart';
import 'package:sizer/sizer.dart';

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
          child: CustomTextLato(
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
          child: ResultContainerForPopularMovies(),
        ),
        SizedBox(
          height: 50,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            children: [
              CustomTextLato(
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
          child: ResultContainerForGenre(),
        )
      ],
    );
  }
}
