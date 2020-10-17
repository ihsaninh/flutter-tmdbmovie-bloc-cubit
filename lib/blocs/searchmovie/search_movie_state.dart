part of 'search_movie_cubit.dart';

@immutable
abstract class SearchMovieState extends Equatable {
  const SearchMovieState();
}

class SearchMovieInitial extends SearchMovieState {
  @override
  List<Object> get props => [];
}

class SearchMovieLoadInProgress extends SearchMovieState {
  @override
  List<Object> get props => [];
}

class SearchMovieLoadSuccess extends SearchMovieState {
  SearchMovieLoadSuccess(this.searchMovieResult);

  final List<MovieList> searchMovieResult;

  @override
  List<Object> get props => [searchMovieResult];
}

class SearchMovieLoadFailure extends SearchMovieState {
  @override
  List<Object> get props => [];
}
