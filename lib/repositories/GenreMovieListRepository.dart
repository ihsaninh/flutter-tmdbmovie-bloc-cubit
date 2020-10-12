import 'package:dio/dio.dart';

import 'package:movie_app/models/MovieList.dart';

class GenreMovieListRepository {
  Dio dio = Dio();

  Future<List<MovieList>> getGenreMovieList(String genreId) async {
    try {
      Response response = await dio.get('https://api.themoviedb.org/3/discover/movie?api_key=52c752b31bfe181e2fa03ee3fb20eecd&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=$genreId');
      return response.data['results']
          .map<MovieList>((json) => MovieList.fromJson(json))
          .toList();
    } catch (e) {
      throw e;
    }
  }
}
