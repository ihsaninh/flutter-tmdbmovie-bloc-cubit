import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/models/MovieList.dart';

import 'package:movie_app/repositories/SearchMovieRepository.dart';

part 'SearchMovieState.dart';

class SearchMovieCubit extends Cubit<SearchMovieState> {

  final SearchMovieRepository repository;

  SearchMovieCubit({ this.repository }) : super(SearchMovieInitial());

  Future<void> getSearchMovies(String query) async {
    try{
      emit(SearchMovieLoadInProgress());
      final topRatedMovies = await repository.getSearchMovies(query);
      emit(SearchMovieLoadSuccess(topRatedMovies));
    } catch(e) {
      emit(SearchMovieLoadFailure());
    }
  }

  void reset() => emit(SearchMovieInitial());
}
