part of 'movie_details_cubit.dart';

abstract class MovieDetailsState extends Equatable {
  const MovieDetailsState();

  @override
  List<Object> get props => [];
}

class MovieDetailsInitial extends MovieDetailsState {}

class MovieDetailsLoading extends MovieDetailsState {}

class MovieDetailsLoaded extends MovieDetailsState {
  final MovieDetail movieDetail;

  MovieDetailsLoaded(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class MovieDetailsError extends MovieDetailsState {
  final String message;

  MovieDetailsError(this.message);

  @override
  List<Object> get props => [message];
}
