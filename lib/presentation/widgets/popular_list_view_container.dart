import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import '../../core/constant/icon.dart';
import '../../core/constant/string.dart';
import '../../core/utils/favorite_filter.dart';
import '../../data/models/favorite_model.dart';
import '../cubit/favorite/favorite_cubit.dart';
import '../cubit/movie/movie_details_cubit.dart';
import '../cubit/popular/popular_cubit.dart';
import 'package:sizer/sizer.dart';
import '../screens/detail_screen.dart';
import '../../dependency_injector.dart';
import 'components/custom_text_quick_sand.dart';
import 'components/linear_progress.dart';

class PopularListViewContainer extends StatefulWidget {
  @override
  _PopularListViewContainerState createState() =>
      _PopularListViewContainerState();
}

class _PopularListViewContainerState extends State<PopularListViewContainer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void toDetailScreen(int id) => Navigator.push(
        context,
        PageRouteBuilder(
          transitionsBuilder: (context, animation, animationTime, child) {
            animation = CurvedAnimation(
                reverseCurve: Curves.easeIn,
                parent: animation,
                curve: Curves.bounceInOut);
            return ScaleTransition(
              scale: animation,
              child: child,
            );
          },
          pageBuilder: (context, animation, animationTime) =>
              BlocProvider.value(
            value: sl<MovieDetailsCubit>(),
            child: DetailScreen(
              id: id,
            ),
          ),
        ),
      );
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularCubit, PopularState>(
      builder: (context, state) {
        if (state is PopularLoading) {
          return LinearProgress();
        } else if (state is PopularLoaded) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                children: state.movies
                    .map(
                      (movie) => GestureDetector(
                        onTap: () => toDetailScreen(movie.id),
                        child: Container(
                          width: 200,
                          margin: EdgeInsets.only(right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Stack(
                                  children: [
                                    Image.network(
                                      movie.posterPath != null
                                          ? SD_IMAGE_LINK + movie.posterPath
                                          : NO_IMAGE_LINK,
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: favoriteFilter(id: movie.id)
                                          ? IconButton(
                                              icon: FAVORITE_ICON_TRUE,
                                              onPressed: () {
                                                context
                                                    .read<FavoriteCubit>()
                                                    .delFavorite(id: movie.id);
                                                BlocProvider.of<FavoriteCubit>(
                                                        context)
                                                    .getFavorites();
                                                setState(() {});
                                              },
                                            )
                                          : IconButton(
                                              icon: FAVORITE_ICON_FALSE,
                                              onPressed: () {
                                                context
                                                    .read<FavoriteCubit>()
                                                    .addFavorite(
                                                      fav: FavoriteModel(
                                                        average:
                                                            movie.voteAverage,
                                                        id: movie.id,
                                                        overview:
                                                            movie.overview,
                                                        title: movie.title,
                                                        genresId:
                                                            movie.genreIds,
                                                        posterPath:
                                                            movie.posterPath,
                                                      ),
                                                    );
                                                BlocProvider.of<FavoriteCubit>(
                                                        context)
                                                    .getFavorites();

                                                setState(() {});
                                              },
                                            ),
                                    )
                                  ],
                                ),
                              ),
                              CustomTextQuickSand(
                                movie.title + ' (${movie.releaseDate.year})',
                                size: 10.0.sp,
                                weight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Row(
                                children: [
                                  SmoothStarRating(
                                      allowHalfRating: false,
                                      rating: movie.voteAverage / 2,
                                      isReadOnly: true,
                                      color: Colors.green,
                                      size: 15,
                                      borderColor: Colors.green,
                                      spacing: 0.0),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  CustomTextQuickSand(
                                    movie.voteAverage.toString(),
                                    color: Colors.grey,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList()),
          );
        }
        return Container();
      },
    );
  }
}
