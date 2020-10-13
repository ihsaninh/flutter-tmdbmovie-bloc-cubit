import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/models/MovieList.dart';

import 'package:movie_app/repositories/TopRatedMovieRepository.dart';

part 'TopRatedMovieState.dart';

class TopRatedMovieCubit extends Cubit<TopRatedMovieState> {

  final TopRatedMovieRepository repository;

  TopRatedMovieCubit({ this.repository }) : super(TopRatedMovieInitial());

  Future<void> getTopRatedMovie() async {
    try{
      emit(TopRatedMovieLoadInProgress());
      final topRatedMovies = await repository.getTopRatedMovies();
      emit(TopRatedMovieLoadSuccess(topRatedMovies));
    } catch(e) {
      emit(TopRatedMovieLoadFailure());
    }
  }
}
