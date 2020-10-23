import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/models/movie_list.dart';
import 'package:movie_app/repositories/similiar_movie_repository.dart';

part 'similiar_movie_state.dart';

class SimiliarMovieCubit extends Cubit<SimiliarMovieState> {
  SimiliarMovieCubit() : super(SimiliarMovieInitial());

  SimiliarMovieRepository repository = SimiliarMovieRepository();

  Future<void> getSimiliarMovies(int movieId) async {
    try {
      emit(SimiliarMovieLoadInProgress());
      final similiarMovies = await repository.getSimiliarMovies(movieId);
      emit(SimiliarMovieLoadSuccess(similiarMovies));
    } catch(e) {
      emit(SimiliarMovieLoadFailure());
    }
  }

}
