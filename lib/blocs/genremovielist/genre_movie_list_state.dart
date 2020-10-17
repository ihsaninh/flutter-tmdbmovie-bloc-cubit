part of 'genre_movie_list_cubit.dart';

abstract class GenreMovieListState extends Equatable {
  const GenreMovieListState();
}

class GenreMovieListInitial extends GenreMovieListState {
  @override
  List<Object> get props => [];
}

class GenreMovieListLoadInProgress extends GenreMovieListState {
  @override
  List<Object> get props => [];
}

class GenreMovieListLoadSuccess extends GenreMovieListState {
  GenreMovieListLoadSuccess(this.genreMovieLists);

  final List<MovieList> genreMovieLists;

  @override
  List<Object> get props => [genreMovieLists];
}

class GenreMovieListLoadFailure extends GenreMovieListState {
  @override
  List<Object> get props => [];
}
