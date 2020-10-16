import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_config/flutter_config.dart';

import 'package:movie_app/screens/Home.dart';
import 'package:movie_app/configs/Routes.dart';
import 'package:movie_app/constants/Colors.dart';
import 'package:movie_app/constants/Navigation.dart';
import 'package:movie_app/blocs/searchmovie/SearchMovieCubit.dart';
import 'package:movie_app/blocs/popularmovie/PopularMovieCubit.dart';
import 'package:movie_app/blocs/topratedmovie/TopRatedMovieCubit.dart';
import 'package:movie_app/blocs/genremovielist/GenreMovieListCubit.dart';
import 'package:movie_app/blocs/upcomingmovie/upcoming_movie_cubit.dart';

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
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: ColorBase.primary,
          accentColor: Colors.white10,
          accentColorBrightness: Brightness.light,
          scaffoldBackgroundColor: ColorBase.primary,
        ),
        home: Home(),
        onGenerateRoute: generateRoutes,
        navigatorKey: Navigation.navKey,
      ),
    );
  }
}
