import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/models/movie_list.dart';
import 'package:movie_app/repositories/genre_movie_list_repository.dart';

part 'genre_movie_list_state.dart';

class GenreMovieListCubit extends Cubit<GenreMovieListState> {
  GenreMovieListRepository repository = GenreMovieListRepository();

  GenreMovieListCubit() : super(GenreMovieListInitial());

  Future<void> getGenreMovieList({int genreId = 28}) async {
    try {
      emit(GenreMovieListLoadInProgress());
      final genreMovisLists = await repository.getGenreMovieList(genreId);
      emit(GenreMovieListLoadSuccess(genreMovisLists));
    } catch (e) {
      throw e;
    }
  }
}
