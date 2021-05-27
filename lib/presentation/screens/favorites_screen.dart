import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/components/custom_display_error.dart';
import '../widgets/result_container_for_favorites.dart';
import '../cubit/favorite/favorite_cubit.dart';
import '../widgets/components/custom_text_lato.dart';
import 'package:sizer/sizer.dart';
import '../widgets/components/linear_progress.dart';

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
                    CustomTextQuickSand(
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
