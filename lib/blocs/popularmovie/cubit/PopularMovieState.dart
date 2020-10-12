part of 'PopularMovieCubit.dart';

abstract class PopularMovieState extends Equatable {
  const PopularMovieState();

  @override
  List<Object> get props => [];
}

class PopularMovieInitial extends PopularMovieState {
  @override
  List<Object> get props => [];
}

class PopularMovieLoadInProgress extends PopularMovieState {
  @override
  List<Object> get props => [];
}

class PopularMovieLoadSuccess extends PopularMovieState {
  PopularMovieLoadSuccess(this.popularMovies);

  final List<PopularMovie> popularMovies;

  @override
  List<Object> get props => [popularMovies];
}

class PopularMovieLoadFailure extends PopularMovieState {
  @override
  List<Object> get props => [];
}