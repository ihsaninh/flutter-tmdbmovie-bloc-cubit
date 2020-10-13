import 'package:dio/dio.dart';

import 'package:movie_app/models/MovieList.dart';

class TopRatedMovieRepository {
  Dio dio = Dio();

  Future<List<MovieList>> getTopRatedMovies() async {
    try {
      Response response = await dio.get('https://api.themoviedb.org/3/movie/top_rated?api_key=52c752b31bfe181e2fa03ee3fb20eecd&language=en-EN&page=1');
      return response.data['results']
          .map<MovieList>((json) => MovieList.fromJson(json))
          .toList();
    } catch (e) {
      throw e;
    }
  }
}
