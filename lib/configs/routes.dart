import 'package:flutter/cupertino.dart';

import 'package:movie_app/constants/navigation.dart';
import 'package:movie_app/screens/movie_detail.dart';
import 'package:movie_app/screens/movie_home.dart';
import 'package:movie_app/screens/search.dart';

Route generateRoutes(RouteSettings settings) {
  final args = settings.arguments;

  switch (settings.name) {
    case Navigation.MovieHome:
      return buildRoute(settings, MovieHome());
    case Navigation.SearchPage:
      return buildRoute(settings, SearchPage());
    case Navigation.MovieDetail:
      return buildRoute(settings, DetailMovie(movieId: args));
    default:
      return null;
  }
}

CupertinoPageRoute buildRoute(RouteSettings settings, Widget builder) {
  return CupertinoPageRoute(
    settings: settings,
    builder: (BuildContext context) => builder,
  );
}
