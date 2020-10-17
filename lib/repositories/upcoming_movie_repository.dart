import 'package:dio/dio.dart';

import 'package:movie_app/configs/configs.dart';
import 'package:movie_app/models/movie_list.dart';

class UpcomingMovieRepository {
  Dio dio = Dio();

  Future<List<MovieList>> getUpcomingMovies() async {
    try {
      Response response = await dio.get(Config.upcomingMovieUrl);
      return response.data['results']
          .map<MovieList>((json) => MovieList.fromJson(json))
          .toList();
    } catch (e) {
      throw e;
    }
  }
}
