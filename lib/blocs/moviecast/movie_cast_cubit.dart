import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/models/movie_cast.dart';
import 'package:movie_app/repositories/movie_cast_repository.dart';

part 'movie_cast_state.dart';

class MovieCastCubit extends Cubit<MovieCastState> {
  MovieCastCubit() : super(MovieCastInitial());

  MovieCastRepository repository = MovieCastRepository();

  Future<void> getMovieCast(int movieId) async {
    try {
      emit(MovieCastLoadInProgress());
      final movieCasts = await repository.getMovieCast(movieId);
      emit(MovieCastLoadSuccess(movieCasts));
    } catch (e) {
      throw e;
    }
  }
}
