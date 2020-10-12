import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/models/MovieList.dart';

import 'package:movie_app/repositories/PopularMovieRepository.dart';

part 'PopularMovieState.dart';

class PopularMovieCubit extends Cubit<PopularMovieState> {

  final PopularMovieRepository repository;

  PopularMovieCubit({ this.repository }) : super(PopularMovieInitial());

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
