part of 'popular_cubit.dart';

abstract class PopularState extends Equatable {
  const PopularState();

  @override
  List<Object> get props => [];
}

class PopularInitial extends PopularState {}

class PopularLoading extends PopularState {}

class PopularLoaded extends PopularState {
  final Popular popular;

  PopularLoaded(this.popular);
  @override
  List<Object> get props => [popular];
}

class PopularError extends PopularState {
  final String message;

  PopularError(this.message);

  @override
  List<Object> get props => [message];
}
