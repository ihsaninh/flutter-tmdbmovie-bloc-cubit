import 'package:dio/dio.dart';

import 'package:movie_app/configs/configs.dart';
import 'package:movie_app/models/movie_cast.dart';

class MovieCastRepository {
  Dio dio = Dio();

  Future<MovieCast> getMovieCast(int movieId) async {
    try {
      Response response = await dio.get(Config.movieCreditlUrl(movieId));
      return MovieCast.fromJson(response.data);
    } catch (e) {
      throw e;
    }
  }
}