part of 'genre_cubit.dart';

abstract class GenreState extends Equatable {
  const GenreState();

  @override
  List<Object> get props => [];
}

class GenreInitial extends GenreState {}

class GenreLoading extends GenreState {}

class GenreLoaded extends GenreState {
  final ChosenGenre genre;

  GenreLoaded(this.genre);

  @override
  List<Object> get props => [genre];
}

class GenreError extends GenreState {
  final String message;

  GenreError(this.message);

  @override
  List<Object> get props => [message];
}
