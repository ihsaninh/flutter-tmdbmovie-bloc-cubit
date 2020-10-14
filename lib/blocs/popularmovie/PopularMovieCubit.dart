import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/models/MovieList.dart';

import 'package:movie_app/repositories/PopularMovieRepository.dart';

part 'PopularMovieState.dart';

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
