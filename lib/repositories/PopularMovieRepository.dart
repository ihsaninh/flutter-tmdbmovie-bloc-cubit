import 'package:dio/dio.dart';

import 'package:movie_app/models/PopularMovie.dart';

class PopularMovieRepository {
  Dio dio = Dio();

  Future<List<PopularMovie>> getPopularMovies() async {
    try {
      Response response = await dio.get('https://api.themoviedb.org/3/movie/popular?api_key=52c752b31bfe181e2fa03ee3fb20eecd&page=1');
      return response.data['results']
          .map<PopularMovie>((json) => PopularMovie.fromJson(json))
          .toList();
    } catch (e) {
      throw e;
    }
  }
}
