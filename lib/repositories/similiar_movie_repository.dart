import 'package:dio/dio.dart';

import 'package:movie_app/configs/configs.dart';
import 'package:movie_app/models/movie_list.dart';

class SimiliarMovieRepository {
  Dio dio = Dio();

  Future<List<MovieList>> getSimiliarMovies(int movieId) async {
    try {
      Response response = await dio.get(Config.similiarMovieUrl(movieId));
      return response.data['results']
          .map<MovieList>((json) => MovieList.fromJson(json))
          .toList();
    } catch (e) {
      throw e;
    }
  }
}
