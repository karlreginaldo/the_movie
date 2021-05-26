part of 'movie_cubit.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final Movie movie;

  MovieLoaded(this.movie);

  @override
  List<Object> get props => [movie];
}

class MovieDetailLoaded extends MovieState {
  final MovieDetail movieDetail;

  MovieDetailLoaded(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class MovieError extends MovieState {
  final String message;

  MovieError(this.message);

  @override
  List<Object> get props => [message];
}
