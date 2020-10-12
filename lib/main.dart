import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_app/blocs/genremovielist/GenreMovieListCubit.dart';
import 'package:movie_app/blocs/popularmovie/PopularMovieCubit.dart';
import 'package:movie_app/repositories/GenreMovieListRepository.dart';
import 'package:movie_app/repositories/PopularMovieRepository.dart';
import 'package:movie_app/screens/Home.dart';
import 'package:movie_app/constants/Colors.dart';

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

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: Colors.transparent
        ),
    );
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiBlocProvider(
      providers: [
        BlocProvider<PopularMovieCubit>(
          create:(context) => PopularMovieCubit(
            repository: PopularMovieRepository()
          ),
        ),
        BlocProvider<GenreMovieListCubit>(
          create: (contect) => GenreMovieListCubit(
            repository: GenreMovieListRepository()
          ),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: ColorBase.primary,
          scaffoldBackgroundColor: ColorBase.primary,
        ),
        home: Home(),
      ),
    );
  }
}