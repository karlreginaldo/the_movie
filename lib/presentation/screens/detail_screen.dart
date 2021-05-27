import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:themovie/core/constant/icon.dart';
import 'package:themovie/domain/entities/movie_detail.dart';
import '../../core/constant/color.dart';

import '../../core/constant/string.dart';
import '../../core/utils/genre_filter.dart';
import '../../domain/entities/spoken_language.dart';
import '../cubit/movie/movie_details_cubit.dart';
import '../widgets/components/circular_progress.dart';
import '../widgets/components/custom_text_lato.dart';
import 'package:sizer/sizer.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({
    Key key,
    @required this.id,
  }) : super(key: key);
  final int id;
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    BlocProvider.of<MovieDetailsCubit>(context)
      ..getSpecificMovie(id: widget.id);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
          builder: (context, state) {
            if (state is MovieDetailsLoading) {
              return LinearProgressIndicator(
                backgroundColor: Colors.green,
                valueColor: AlwaysStoppedAnimation<Color>(SCAFFOLD_COLOR),
              );
            } else if (state is MovieDetailsLoaded) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Image.network(
                          HD_IMAGE_LINK + state.movieDetail.posterPath,
                        ),
                        Positioned(
                          top: 25,
                          left: 25,
                          child: IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: BACK_BUTTON_ICON,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleAndRate(state.movieDetail),
                          SizedBox(
                            height: 5,
                          ),
                          CustomTextLato(
                            state.movieDetail.tagline,
                            overflow: TextOverflow.clip,
                            size: 12.0.sp,
                            color: Colors.green,
                            weight: FontWeight.bold,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GenreAndRuntime(state.movieDetail),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextLato(
                            state.movieDetail.overview,
                            color: Colors.white.withOpacity(0.7),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextLato(
                                state.movieDetail.status,
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          CustomTextLato(
                            state.movieDetail.releaseDate.year.toString(),
                            color: Colors.white.withOpacity(0.9),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Wrap(
                            children: state.movieDetail.spokenLanguages
                                .map(
                                  (spokenLanguage) => Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: CustomTextLato(
                                      spokenLanguage.englishName,
                                      color: Colors.white.withOpacity(0.9),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          CustomTextLato(
                            'Production Companies',
                            size: 15.0.sp,
                            weight: FontWeight.bold,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    ProductionCompanies(state.movieDetail),
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}

class GenreAndRuntime extends StatelessWidget {
  const GenreAndRuntime(
    this.movieDetail, {
    Key key,
  }) : super(key: key);
  final MovieDetail movieDetail;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            child: Wrap(
              children: movieDetail.genres
                  .map(
                    (genre) => CustomTextLato(
                      genre.name + ', ',
                      overflow: TextOverflow.clip,
                      color: Colors.grey,
                    ),
                  )
                  .toList(),
            ),
          ),
          VerticalDivider(
            color: Colors.grey,
            thickness: 2,
            endIndent: 10,
            indent: 10,
          ),
          Expanded(
            child: CustomTextLato(
              'Runtime: ${movieDetail.runtime} min',
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class TitleAndRate extends StatelessWidget {
  const TitleAndRate(
    this.movieDetail, {
    Key key,
  }) : super(key: key);
  final MovieDetail movieDetail;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: CustomTextLato(
            movieDetail.title,
            overflow: TextOverflow.clip,
            size: 18.0.sp,
            weight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            SmoothStarRating(
                allowHalfRating: false,
                rating: movieDetail.voteAverage / 2,
                isReadOnly: true,
                color: Colors.green,
                size: 15,
                borderColor: Colors.green,
                spacing: 0.0),
            SizedBox(
              width: 5,
            ),
            CustomTextLato(
              movieDetail.voteAverage.toString(),
              color: Colors.grey,
            ),
          ],
        ),
      ],
    );
  }
}

class ProductionCompanies extends StatelessWidget {
  const ProductionCompanies(
    this.movieDetail, {
    Key key,
  }) : super(key: key);
  final MovieDetail movieDetail;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: movieDetail.productionCompanies
            .map(
              (company) => Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: CONTAINER_COLOR,
                      backgroundImage: NetworkImage(company.logoPath != null
                          ? '$SD_IMAGE_LINK${company.logoPath}'
                          : NO_IMAGE_LINK),
                      radius: 42,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CustomTextLato(
                      '${company.name} ' + company.originCountry,
                      size: 10.0.sp,
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
