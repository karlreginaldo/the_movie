import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/icon.dart';
import '../../../core/utils/genre_filter.dart';
import '../../cubit/genre/genre_cubit.dart';
import 'custom_text_quick_sand.dart';

class GenreFilterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (id) =>
          BlocProvider.of<GenreCubit>(context).chooseGenre(genreID: id),
      child: HOME_DOWN_ICON,
      itemBuilder: (context) {
        return genreList
            .map(
              (genre) => PopupMenuItem(
                child: CustomTextQuickSand(genre.name),
                value: genre.id,
              ),
            )
            .toList();
      },
      color: CONTAINER_COLOR,
    );
  }
}
