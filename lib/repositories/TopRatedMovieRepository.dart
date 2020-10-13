import 'package:dio/dio.dart';

import 'package:movie_app/configs/Config.dart';
import 'package:movie_app/models/MovieList.dart';

class TopRatedMovieRepository {
  Dio dio = Dio();

  Future<List<MovieList>> getTopRatedMovies() async {
    try {
      Response response = await dio.get(Config.topRatedUrl);
      return response.data['results']
          .map<MovieList>((json) => MovieList.fromJson(json))
          .toList();
    } catch (e) {
      throw e;
    }
  }
}
