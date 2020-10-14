import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:movie_app/constants/Navigation.dart';
import 'package:movie_app/models/Genre.dart';
import 'package:movie_app/models/MovieList.dart';
import 'package:movie_app/widgets/CarouselItem.dart';
import 'package:movie_app/widgets/DotIndicator.dart';
import 'package:movie_app/widgets/MovieCard.dart';
import 'package:movie_app/widgets/SectionHeader.dart';
import 'package:movie_app/blocs/popularmovie/PopularMovieCubit.dart';
import 'package:movie_app/blocs/topratedmovie/TopRatedMovieCubit.dart';
import 'package:movie_app/blocs/genremovielist/GenreMovieListCubit.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  int _current = 0;
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: genres.length , vsync: this, initialIndex: 0);
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
    context.bloc<GenreMovieListCubit>().getGenreMovieList(genreId: genres[id].id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies DB'),
        centerTitle: true,
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => Navigator.pushNamed(context, Navigation.SearchPage)
          ),
        ],
        leading: Icon(Icons.motion_photos_on_rounded),
      ),
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
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
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
                  return Text('Failed Get Data Banner', style: TextStyle(color: Colors.white));
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
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                    ),
                  );
                } else if (state is GenreMovieListLoadSuccess) {
                  return Container(
                    child: _buildTabBarView(state.genreMovieLists),
                  );
                } else {
                  return Text('Failed Get Data Tab', style: TextStyle(color: Colors.white));
                }
              }
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
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                    ),
                  );
                } else if (state is TopRatedMovieLoadSuccess) {
                  return _buildTopRatedMovie(state.topRatedMovies);
                } else {
                  return Text('Failed Get Data Tab', style: TextStyle(color: Colors.white));
                }
              }
            )
          ],
        ),
      ),
    );
  }

  _buildCarouselSlider(List<MovieList> list) {
    return CarouselSlider(
      items: list.sublist(0, 5).map((item) {
        return CarouselItem(
          avatar: item.backdropPath,
          title: item.title,
        );
      }).toList(),
      options: CarouselOptions(
        autoPlay: true,
        viewportFraction: 1,
        enlargeCenterPage: false,
        onPageChanged: (index, reason) {
          setState(() {
            _current = index;
          });
        }
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
      labelStyle: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600),
      controller: _tabController,
      onTap: (index) => _getGenreListById(index),
      labelColor: Colors.white,
      indicatorWeight: 3,
      indicatorColor: Colors.white,
      isScrollable: true,
      tabs: genres.map((item) {
        return Tab(
          text: item.name.toUpperCase(),
        );
      }).toList(),
    );
  }

  _buildTabBarView(List <MovieList> genreListMovies) {
    return Container(
      height: 250,
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: genres.map((item) {
          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            scrollDirection: Axis.horizontal,
            itemCount: genreListMovies.length,
            itemBuilder: (context, index) {
              var data = genreListMovies[index];
              return MovieCard(
                title: data.title,
                poster: data.posterPath,
                rating: data.voteAverage,
              );
            }
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
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            scrollDirection: Axis.horizontal,
            itemCount: topRatedMovies.length,
            itemBuilder: (context, index) {
              var data = topRatedMovies[index];
              return MovieCard(
                title: data.title,
                poster: data.posterPath,
                rating: data.voteAverage,
              );
            }
          ),
        ),
      ],
    );
  }
}