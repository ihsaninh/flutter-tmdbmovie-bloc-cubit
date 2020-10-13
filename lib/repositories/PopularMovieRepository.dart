import 'package:dio/dio.dart';

import 'package:movie_app/configs/Config.dart';
import 'package:movie_app/models/MovieList.dart';

class PopularMovieRepository {
  Dio dio = Dio();

  Future<List<MovieList>> getPopularMovies() async {
    try {
      Response response = await dio.get(Config.popularUrl);
      return response.data['results']
          .map<MovieList>((json) => MovieList.fromJson(json))
          .toList();
    } catch (e) {
      throw e;
    }
  }
}
