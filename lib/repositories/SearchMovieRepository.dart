import 'package:dio/dio.dart';

import 'package:movie_app/configs/Config.dart';
import 'package:movie_app/models/MovieList.dart';

class SearchMovieRepository {
  Dio dio = Dio();

  Future<List<MovieList>> getSearchMovies(String query) async {
    try {
      Response response = await dio.get("${Config.seacrhMovieUrl}&query=$query");
      return response.data['results']
          .map<MovieList>((json) => MovieList.fromJson(json))
          .toList();
    } catch (e) {
      throw e;
    }
  }
}
