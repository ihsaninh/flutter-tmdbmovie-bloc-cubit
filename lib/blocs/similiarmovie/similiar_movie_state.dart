part of 'similiar_movie_cubit.dart';

@immutable
abstract class SimiliarMovieState extends Equatable{
  const SimiliarMovieState();
}

class SimiliarMovieInitial extends SimiliarMovieState {
  @override
  List<Object> get props => [];
}

class SimiliarMovieLoadInProgress extends SimiliarMovieState {
  @override
  List<Object> get props => [];
}

class SimiliarMovieLoadSuccess extends SimiliarMovieState {
  final List<MovieList> similiarMovies;

  SimiliarMovieLoadSuccess(this.similiarMovies);

  @override
  List<Object> get props => [similiarMovies];
}

class SimiliarMovieLoadFailure extends SimiliarMovieState {
  @override
  List<Object> get props => [];
}
