import 'package:dio/dio.dart';

import 'package:movie_app/configs/configs.dart';
import 'package:movie_app/models/movie_list.dart';

class GenreMovieListRepository {
  Dio dio = Dio();

  Future<List<MovieList>> getGenreMovieList(int genreId) async {
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
