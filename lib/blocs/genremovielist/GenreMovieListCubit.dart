import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/models/MovieList.dart';
import 'package:movie_app/repositories/GenreMovieListRepository.dart';

part 'GenreMovieListState.dart';

class GenreMovieListCubit extends Cubit<GenreMovieListState> {

  final GenreMovieListRepository repository;

  GenreMovieListCubit({ this.repository }) : super(GenreMovieListInitial());

  Future<void> getGenreMovieList(String genreId) async {
    try {
      emit(GenreMovieListLoadInProgress());
      final genreMovisLists = await repository.getGenreMovieList(genreId);
      emit(GenreMovieListLoadSuccess(genreMovisLists));
    } catch(e) {
      throw e;
    }
  }
}

