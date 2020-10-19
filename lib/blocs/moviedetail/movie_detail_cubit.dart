import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/models/movie_detail.dart';
import 'package:movie_app/repositories/movie_detail.dart';

part 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  MovieDetailCubit() : super(MovieDetailInitial());

  MovieDetailRepository repository = MovieDetailRepository();

  Future<void> getMovieDetail(int movieId) async {
    try {
      emit(MovieDetailLoadInProgress());
      final movieDetail = await repository.getMovieDetail(movieId);
      emit(MovieDetailLoadSuccess(movieDetail));
    } catch(e) {
      emit(MovieDetailLoadFailure());
    }
  }
}
