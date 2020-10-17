part of 'top_rated_movie_cubit.dart';

@immutable
abstract class TopRatedMovieState extends Equatable {
  const TopRatedMovieState();
}

class TopRatedMovieInitial extends TopRatedMovieState {
  @override
  List<Object> get props => [];
}

class TopRatedMovieLoadInProgress extends TopRatedMovieState {
  @override
  List<Object> get props => [];
}

class TopRatedMovieLoadSuccess extends TopRatedMovieState {
  TopRatedMovieLoadSuccess(this.topRatedMovies);

  final List<MovieList> topRatedMovies;

  @override
  List<Object> get props => [topRatedMovies];
}

class TopRatedMovieLoadFailure extends TopRatedMovieState {
  @override
  List<Object> get props => [];
}
