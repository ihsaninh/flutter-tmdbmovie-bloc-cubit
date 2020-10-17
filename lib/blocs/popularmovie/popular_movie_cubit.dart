import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/models/movie_list.dart';

import 'package:movie_app/repositories/popular_movie_repository.dart';

part 'popular_movie_state.dart';

class PopularMovieCubit extends Cubit<PopularMovieState> {
  PopularMovieCubit() : super(PopularMovieInitial());

  PopularMovieRepository repository = PopularMovieRepository();

  Future<void> getPopularMovies() async {
    try {
      emit(PopularMovieLoadInProgress());
      final popularMovies = await repository.getPopularMovies();
      emit(PopularMovieLoadSuccess(popularMovies));
    } catch (e) {
      emit(PopularMovieLoadFailure());
    }
  }
}
