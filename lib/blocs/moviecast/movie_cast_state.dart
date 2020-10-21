part of 'movie_cast_cubit.dart';

@immutable
abstract class MovieCastState extends Equatable{
  const MovieCastState();
}

class MovieCastInitial extends MovieCastState {
  @override
  List<Object> get props => [];
}

class MovieCastLoadInProgress extends MovieCastState {
  @override
  List<Object> get props => [];
}

class MovieCastLoadSuccess extends MovieCastState {

  MovieCastLoadSuccess(this.movieCasts);

  final MovieCast movieCasts;

  @override
  List<Object> get props => [movieCasts];
}

class MovieCastlLoadFailure extends MovieCastState {
  @override
  List<Object> get props => [];
}