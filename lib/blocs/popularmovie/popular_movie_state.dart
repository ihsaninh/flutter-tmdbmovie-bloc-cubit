part of 'popular_movie_cubit.dart';

abstract class PopularMovieState extends Equatable {
  const PopularMovieState();
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

  final List<MovieList> popularMovies;

  @override
  List<Object> get props => [popularMovies];
}

class PopularMovieLoadFailure extends PopularMovieState {
  @override
  List<Object> get props => [];
}
