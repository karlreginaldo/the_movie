part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class Favorites extends HomeState {
  @override
  List<Object> get props => [];
}

class SearchLoading extends HomeState {
  @override
  List<Object> get props => [];
}

class MovieLoaded extends HomeState {
  final Movie movie;

  MovieLoaded(this.movie);

  @override
  List<Object> get props => [movie];
}

class SearchEmpty extends HomeState {
  final String message;

  SearchEmpty(this.message);

  @override
  List<Object> get props => [message];
}

class SearchError extends HomeState {
  final String message;

  SearchError(this.message);

  @override
  List<Object> get props => [message];
}
