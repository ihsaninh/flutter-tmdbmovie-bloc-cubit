import 'package:dio/dio.dart';

import 'package:movie_app/configs/configs.dart';
import 'package:movie_app/models/movie_list.dart';

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
