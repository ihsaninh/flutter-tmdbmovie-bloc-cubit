import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_config/flutter_config.dart';

import 'package:movie_app/screens/movie_home.dart';
import 'package:movie_app/configs/routes.dart';
import 'package:movie_app/constants/colors.dart';
import 'package:movie_app/constants/navigation.dart';
import 'package:movie_app/blocs/searchmovie/search_movie_cubit.dart';
import 'package:movie_app/blocs/popularmovie/popular_movie_cubit.dart';
import 'package:movie_app/blocs/topratedmovie/top_rated_movie_cubit.dart';
import 'package:movie_app/blocs/genremovielist/genre_movie_list_cubit.dart';
import 'package:movie_app/blocs/upcomingmovie/upcoming_movie_cubit.dart';
import 'package:movie_app/blocs/moviecast/movie_cast_cubit.dart';
import 'package:movie_app/blocs/moviedetail/movie_detail_cubit.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    print('$error, $stackTrace');
    super.onError(cubit, error, stackTrace);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await FlutterConfig.loadEnvVariables();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MultiBlocProvider(
      providers: [
        BlocProvider<PopularMovieCubit>(
          create: (context) => PopularMovieCubit()..getPopularMovies(),
        ),
        BlocProvider<GenreMovieListCubit>(
          create: (context) => GenreMovieListCubit()..getGenreMovieList(),
        ),
        BlocProvider<TopRatedMovieCubit>(
          create: (context) => TopRatedMovieCubit()..getTopRatedMovie(),
        ),
        BlocProvider<SearchMovieCubit>(
          create: (context) => SearchMovieCubit(),
        ),
        BlocProvider<UpcomingMovieCubit>(
          create: (context) => UpcomingMovieCubit()..getUpcomingMovies(),
        ),
        BlocProvider<MovieDetailCubit>(
          create: (context) => MovieDetailCubit(),
        ),
        BlocProvider<MovieCastCubit>(
          create: (context) => MovieCastCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: ColorBase.primary,
          accentColor: Colors.white10,
          accentColorBrightness: Brightness.light,
          scaffoldBackgroundColor: ColorBase.primary,
        ),
        home: MovieHome(),
        onGenerateRoute: generateRoutes,
        navigatorKey: Navigation.navKey,
      ),
    );
  }
}
