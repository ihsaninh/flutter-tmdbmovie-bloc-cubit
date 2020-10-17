import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/models/movie_list.dart';

import 'package:movie_app/repositories/top_rated_movie_repository.dart';

part 'top_rated_movie_state.dart';

class TopRatedMovieCubit extends Cubit<TopRatedMovieState> {
  TopRatedMovieRepository repository = TopRatedMovieRepository();

  TopRatedMovieCubit() : super(TopRatedMovieInitial());

  Future<void> getTopRatedMovie() async {
    try {
      emit(TopRatedMovieLoadInProgress());
      final topRatedMovies = await repository.getTopRatedMovies();
      emit(TopRatedMovieLoadSuccess(topRatedMovies));
    } catch (e) {
      emit(TopRatedMovieLoadFailure());
    }
  }
}
