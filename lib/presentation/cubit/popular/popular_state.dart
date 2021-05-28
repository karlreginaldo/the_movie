part of 'popular_cubit.dart';

abstract class PopularState extends Equatable {
  const PopularState();

  @override
  List<Object> get props => [];
}

class PopularInitial extends PopularState {}

class PopularLoading extends PopularState {}

class PopularLoaded extends PopularState {
  final List<Movie> movies;

  PopularLoaded(this.movies);
  @override
  List<Object> get props => [movies];
}

class PopularError extends PopularState {
  final String message;

  PopularError(this.message);

  @override
  List<Object> get props => [message];
}
