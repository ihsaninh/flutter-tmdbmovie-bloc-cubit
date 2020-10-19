part of 'movie_detail_cubit.dart';

@immutable
abstract class MovieDetailState extends Equatable{
  const MovieDetailState();
}

class MovieDetailInitial extends MovieDetailState {
  @override
  List<Object> get props => [];
}

class MovieDetailLoadInProgress extends MovieDetailState {
  @override
  List<Object> get props => [];
}

class MovieDetailLoadSuccess extends MovieDetailState {

  MovieDetailLoadSuccess(this.movieDetail);

  final MovieDetail movieDetail;

  @override
  List<Object> get props => [movieDetail];
}

class MovieDetailLoadFailure extends MovieDetailState {
  @override
  List<Object> get props => [];
}