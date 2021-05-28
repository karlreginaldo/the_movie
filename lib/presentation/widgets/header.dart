import 'package:flutter/material.dart';
import '../../core/constant/color.dart';
import '../../core/constant/icon.dart';
import '../cubit/home/home_cubit.dart';
import 'components/search_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Header extends StatelessWidget {
  const Header({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: CONTAINER_COLOR,
          ),
          // Not functional yet!
          child: IconButton(
            onPressed: () async {
              context.read<HomeCubit>().goHome();
            },
            icon: HOME_BAR_ICON,
          ),
        ),
        Row(
          children: [
            SearchButton(),
            SizedBox(
              width: 10,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: CONTAINER_COLOR,
              ),
              child: IconButton(
                onPressed: () async {
                  context.read<HomeCubit>()..goFavorites();
                },
                icon: FAVORITE_ICON,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
