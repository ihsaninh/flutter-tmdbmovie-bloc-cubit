import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/models/movie_list.dart';

import 'package:movie_app/repositories/search_movie_repository.dart';

part 'search_movie_state.dart';

class SearchMovieCubit extends Cubit<SearchMovieState> {
  SearchMovieRepository repository = SearchMovieRepository();

  SearchMovieCubit() : super(SearchMovieInitial());

  Future<void> getSearchMovies(String query) async {
    try {
      emit(SearchMovieLoadInProgress());
      final topRatedMovies = await repository.getSearchMovies(query);
      emit(SearchMovieLoadSuccess(topRatedMovies));
    } catch (e) {
      emit(SearchMovieLoadFailure());
    }
  }

  void reset() => emit(SearchMovieInitial());
}
