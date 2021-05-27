import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:themovie/core/utils/favorite_filter.dart';
import 'package:themovie/core/utils/genre_filter.dart';
import 'package:themovie/data/models/favorite_model.dart';
import 'package:themovie/presentation/widgets/components/custom_display_error.dart';
import 'package:themovie/presentation/widgets/result_container_for_favorites.dart';
import '../../core/constant/color.dart';
import '../../core/constant/icon.dart';
import '../../core/constant/string.dart';
import '../../domain/entities/favorite.dart';
import '../cubit/favorite/favorite_cubit.dart';
import '../cubit/movie/movie_details_cubit.dart';
import 'detail_screen.dart';
import '../widgets/components/custom_text_lato.dart';
import 'package:sizer/sizer.dart';
import '../widgets/components/linear_progress.dart';
import '../../dependency_injector.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        if (state is FavoriteLoading) {
          return LinearProgress();
        } else if (state is FavoriteLoaded) {
          return state.favorites.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextLato(
                      'Favorite Movies',
                      size: 18.0.sp,
                      weight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: state.favorites
                          .map(
                            (fav) => ResultContainerForFavorite(
                              movie: fav,
                            ),
                          )
                          .toList(),
                    ),
                  ],
                )
              : CustomDisplayError(
                  title: 'Favorites is empty',
                  message: 'Go browse something and tap the heart!',
                  color: Colors.green);
        }
        return Text('None');
      },
    );
  }
}
