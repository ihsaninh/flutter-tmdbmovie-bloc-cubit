import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/models/MovieList.dart';
import 'package:movie_app/repositories/GenreMovieListRepository.dart';

part 'GenreMovieListState.dart';

class GenreMovieListCubit extends Cubit<GenreMovieListState> {
  GenreMovieListRepository repository = GenreMovieListRepository();

  GenreMovieListCubit() : super(GenreMovieListInitial());

  Future<void> getGenreMovieList({int genreId = 28}) async {
    print(genreId);
    try {
      emit(GenreMovieListLoadInProgress());
      final genreMovisLists = await repository.getGenreMovieList(genreId);
      emit(GenreMovieListLoadSuccess(genreMovisLists));
    } catch (e) {
      throw e;
    }
  }
}
