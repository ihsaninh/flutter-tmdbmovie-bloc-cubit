import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:movie_app/constants/navigation.dart';
import 'package:movie_app/models/genre.dart';
import 'package:movie_app/models/movie_list.dart';
import 'package:movie_app/widgets/carousel_item.dart';
import 'package:movie_app/widgets/custom_appbar.dart';
import 'package:movie_app/widgets/dot_indicator.dart';
import 'package:movie_app/widgets/movie_card.dart';
import 'package:movie_app/widgets/section_header.dart';
import 'package:movie_app/blocs/popularmovie/popular_movie_cubit.dart';
import 'package:movie_app/blocs/topratedmovie/top_rated_movie_cubit.dart';
import 'package:movie_app/blocs/upcomingmovie/upcoming_movie_cubit.dart';
import 'package:movie_app/blocs/genremovielist/genre_movie_list_cubit.dart';

class MovieHome extends StatefulWidget {
  @override
  _MovieHomeState createState() => _MovieHomeState();
}

class _MovieHomeState extends State<MovieHome>
    with SingleTickerProviderStateMixin {
  int _current = 0;
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      length: genres.length,
      vsync: this,
      initialIndex: 0,
    );
    _tabController.addListener(_handleTabIndex);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabIndex);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabIndex() {
    setState(() {});
  }

  void _getGenreListById(int id) {
    context
        .bloc<GenreMovieListCubit>()
        .getGenreMovieList(genreId: genres[id].id);
  }

  void _onPressMovie(int movieId) {
    if (movieId != null) {
      Navigator.pushNamed(context, Navigation.MovieDetail, arguments: movieId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<PopularMovieCubit, PopularMovieState>(
              builder: (context, state) {
                if (state is PopularMovieLoadInProgress) {
                  return Container(
                    height: 220,
                    child: Center(
                      child: Transform.scale(
                        scale: 0.7,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                } else if (state is PopularMovieLoadSuccess) {
                  return Stack(
                    children: [
                      _buildCarouselSlider(state.popularMovies),
                      _buildCarouselIndicator(state.popularMovies),
                    ],
                  );
                } else {
                  return Text(
                    'Failed Get Data Banner',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  );
                }
              },
            ),
            _buildTabbar(),
            BlocBuilder<GenreMovieListCubit, GenreMovieListState>(
              builder: (context, state) {
                if (state is GenreMovieListLoadInProgress) {
                  return Container(
                    height: 250,
                    child: Center(
                      child: Transform.scale(
                        scale: 0.7,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                } else if (state is GenreMovieListLoadSuccess) {
                  return Container(
                    child: _buildTabBarView(state.genreMovieLists),
                  );
                } else {
                  return Text(
                    'Failed Get Data Tab',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  );
                }
              },
            ),
            BlocBuilder<TopRatedMovieCubit, TopRatedMovieState>(
              builder: (context, state) {
                if (state is TopRatedMovieLoadInProgress) {
                  return Container(
                    height: 250,
                    child: Center(
                      child: Transform.scale(
                        scale: 0.7,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                } else if (state is TopRatedMovieLoadSuccess) {
                  return _buildTopRatedMovie(state.topRatedMovies);
                } else {
                  return Text(
                    'Failed Get Data Top Rated Movies',
                    style: TextStyle(color: Colors.white),
                  );
                }
              },
            ),
            BlocBuilder<UpcomingMovieCubit, UpcomingMovieState>(
              builder: (context, state) {
                if (state is UpcomingMovieLoadInProgress) {
                  return Container(
                    height: 250,
                    child: Center(
                      child: Transform.scale(
                        scale: 0.7,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                } else if (state is UpcomingMovieLoadSuccess) {
                  return _buildUpcomingMovie(state.upcomingMovies);
                } else {
                  return Text(
                    'Failed Get Data Upcoming Movies',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  _buildCarouselSlider(List<MovieList> list) {
    return CarouselSlider(
      items: list.sublist(0, 5).map(
        (item) {
          return CarouselItem(
            avatar: item.backdropPath,
            title: item.title,
          );
        },
      ).toList(),
      options: CarouselOptions(
        autoPlay: true,
        viewportFraction: 1,
        enlargeCenterPage: false,
        onPageChanged: (index, reason) {
          setState(
            () {
              _current = index;
            },
          );
        },
      ),
    );
  }

  _buildCarouselIndicator(List<MovieList> list) {
    return DotIndicator(
      lists: list,
      currentIndex: _current,
    );
  }

  _buildTabbar() {
    return TabBar(
      controller: _tabController,
      onTap: (index) => _getGenreListById(index),
      labelColor: Colors.white,
      indicatorWeight: 3,
      indicatorColor: Colors.white,
      isScrollable: true,
      labelStyle: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.w600,
      ),
      tabs: genres.map(
        (item) {
          return Tab(
            text: item.name.toUpperCase(),
          );
        },
      ).toList(),
    );
  }

  _buildTabBarView(List<MovieList> genreListMovies) {
    return Container(
      height: 250,
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: genres.map((item) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: genreListMovies.length,
            itemBuilder: (context, index) {
              MovieList data = genreListMovies[index];
              return MovieCard(
                title: data.title,
                poster: data.posterPath,
                rating: data.voteAverage,
                onTap: () => _onPressMovie(data.id),
              );
            },
            padding: EdgeInsets.symmetric(
              horizontal: 12.0,
            ),
          );
        }).toList(),
      ),
    );
  }

  _buildTopRatedMovie(List<MovieList> topRatedMovies) {
    return Column(
      children: [
        SectionHeader(
          title: 'Top Rated Movies',
          subtitle: 'See All',
        ),
        Container(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: topRatedMovies.length,
            itemBuilder: (context, index) {
              MovieList data = topRatedMovies[index];
              return MovieCard(
                title: data.title,
                poster: data.posterPath,
                rating: data.voteAverage,
                onTap: () => _onPressMovie(data.id),
              );
            },
            padding: EdgeInsets.symmetric(
              horizontal: 12.0,
            ),
          ),
        ),
      ],
    );
  }

  _buildUpcomingMovie(List<MovieList> upcomingMovies) {
    return Column(
      children: [
        SectionHeader(
          title: 'Upcoming Movies',
          subtitle: 'See All',
        ),
        Container(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: upcomingMovies.length,
            itemBuilder: (context, index) {
              MovieList data = upcomingMovies[index];
              return MovieCard(
                title: data.title,
                poster: data.posterPath,
                rating: data.voteAverage,
                onTap: () => _onPressMovie(data.id),
              );
            },
            padding: EdgeInsets.symmetric(
              horizontal: 12.0,
            ),
          ),
        ),
      ],
    );
  }
}
