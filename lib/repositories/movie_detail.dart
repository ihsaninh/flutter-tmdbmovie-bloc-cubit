import 'package:dio/dio.dart';

import 'package:movie_app/configs/configs.dart';
import 'package:movie_app/models/movie_cast.dart';
import 'package:movie_app/models/movie_detail.dart';

class MovieDetailRepository {
  Dio dio = Dio();

  Future<MovieDetail> getMovieDetail(int movieId) async {
    try {
      Response response = await dio.get(Config.movieDetailUrl(movieId));
      return MovieDetail.fromJson(response.data);
    } catch (e) {
      throw e;
    }
  }

  Future<MovieCast> getMovieCast(int movieId) async {
    try {
      Response response = await dio.get(Config.movieCreditlUrl(movieId));
      return MovieCast.fromJson(response.data);
    } catch (e) {
      throw e;
    }
  }
}
