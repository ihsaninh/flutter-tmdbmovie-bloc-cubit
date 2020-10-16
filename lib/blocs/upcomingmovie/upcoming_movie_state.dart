part of 'upcoming_movie_cubit.dart';

@immutable
abstract class UpcomingMovieState extends Equatable {
  const UpcomingMovieState();
}

class UpcomingMovieInitial extends UpcomingMovieState {
  @override
  List<Object> get props => [];
}

class UpcomingMovieLoadInProgress extends UpcomingMovieState {
  @override
  List<Object> get props => [];
}

class UpcomingMovieLoadSuccess extends UpcomingMovieState {
  UpcomingMovieLoadSuccess(this.upcomingMovies);

  final List<MovieList> upcomingMovies;

  @override
  List<Object> get props => [upcomingMovies];
}

class UpcomingMovieLoadFailure extends UpcomingMovieState {
  @override
  List<Object> get props => [];
}
