import 'package:flutter/material.dart';

import 'package:movie_app/constants/navigation.dart';
import 'package:movie_app/screens/home.dart';
import 'package:movie_app/screens/search.dart';

Route generateRoutes(RouteSettings settings) {
  final args = settings.arguments;

  switch (settings.name) {
    case Navigation.Home:
      return buildRoute(settings, Home());
    case Navigation.SearchPage:
      return buildRoute(settings, SearchPage());
    default:
      return null;
  }
}

MaterialPageRoute buildRoute(RouteSettings settings, Widget builder) {
  return MaterialPageRoute(
    settings: settings,
    builder: (BuildContext context) => builder,
  );
}
