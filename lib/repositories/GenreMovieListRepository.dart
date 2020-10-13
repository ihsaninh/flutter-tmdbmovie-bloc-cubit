import 'package:dio/dio.dart';

import 'package:movie_app/configs/Config.dart';
import 'package:movie_app/models/MovieList.dart';

class GenreMovieListRepository {
  Dio dio = Dio();

  Future<List<MovieList>> getGenreMovieList(String genreId) async {
    try {
      Response response = await dio.get("${Config.genreMovieListUrl}&with_genres=$genreId");
      return response.data['results']
          .map<MovieList>((json) => MovieList.fromJson(json))
          .toList();
    } catch (e) {
      throw e;
    }
  }
}
