import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import '../../core/constant/color.dart';
import '../../core/constant/icon.dart';
import '../../core/constant/string.dart';
import '../../core/utils/favorite_filter.dart';
import '../../core/utils/genre_filter.dart';
import '../../data/models/favorite_model.dart';
import '../../domain/entities/result.dart';
import '../cubit/favorite/favorite_cubit.dart';
import '../cubit/movie/movie_details_cubit.dart';
import '../screens/detail_screen.dart';
import 'package:sizer/sizer.dart';
import '../../dependency_injector.dart';
import 'components/custom_text_quick_sand.dart';

class ResultContainerForSearch extends StatefulWidget {
  const ResultContainerForSearch({
    Key key,
    @required this.movie,
  }) : super(key: key);
  final Result movie;

  @override
  _ResultContainerForSearchState createState() =>
      _ResultContainerForSearchState();
}

class _ResultContainerForSearchState extends State<ResultContainerForSearch> {
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
    return GestureDetector(
      onTap: () => toDetailScreen(widget.movie.id),
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: CONTAINER_COLOR,
        ),
        child: Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Stack(
                  children: [
                    Image.network(widget.movie.posterPath != null
                        ? SD_IMAGE_LINK + widget.movie.posterPath
                        : NO_IMAGE_LINK),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: favoriteFilter(id: widget.movie.id)
                          ? IconButton(
                              icon: FAVORITE_ICON_TRUE,
                              onPressed: () {
                                context
                                    .read<FavoriteCubit>()
                                    .delFavorite(id: widget.movie.id);
                                BlocProvider.of<FavoriteCubit>(context)
                                    .getFavorites();
                                setState(() {});
                              },
                            )
                          : IconButton(
                              icon: FAVORITE_ICON_FALSE,
                              onPressed: () {
                                context.read<FavoriteCubit>().addFavorite(
                                      fav: FavoriteModel(
                                        average: widget.movie.voteAverage,
                                        id: widget.movie.id,
                                        overview: widget.movie.overview,
                                        title: widget.movie.title,
                                        genresId: widget.movie.genreIds,
                                        posterPath: widget.movie.posterPath,
                                      ),
                                    );
                                BlocProvider.of<FavoriteCubit>(context)
                                    .getFavorites();

                                setState(() {});
                              },
                            ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextQuickSand(
                          widget.movie.title,
                          size: 10.0.sp,
                          weight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        CustomTextQuickSand(
                          widget.movie.overview,
                          color: Colors.grey,
                          maxLines: 3,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SmoothStarRating(
                            allowHalfRating: false,
                            rating: widget.movie.voteAverage / 2,
                            isReadOnly: true,
                            color: Colors.green,
                            size: 15,
                            borderColor: Colors.green,
                            spacing: 0.0),
                        SizedBox(
                          width: 5,
                        ),
                        CustomTextQuickSand(
                          '${widget.movie.voteAverage}',
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        CustomTextQuickSand(
                          'Genre: ',
                          overflow: TextOverflow.clip,
                          color: Colors.grey,
                        ),
                        Expanded(
                          child: Wrap(
                            children: genreFilter(widget.movie.genreIds)
                                .map(
                                  (genre) => CustomTextQuickSand(
                                    genre.name + ' ',
                                    overflow: TextOverflow.clip,
                                    color: Colors.grey,
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
