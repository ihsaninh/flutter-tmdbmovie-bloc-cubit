import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/blocs/genremovielist/GenreMovieListCubit.dart';

import 'package:movie_app/configs/Config.dart';
import 'package:movie_app/constants/Colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:movie_app/models/Genre.dart';
import 'package:movie_app/models/MovieList.dart';
import 'package:movie_app/blocs/popularmovie/PopularMovieCubit.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  int _current = 0;
  TabController _tabController;

  @override
  void initState() {
    context.bloc<PopularMovieCubit>().getPopularMovies();
    context.bloc<GenreMovieListCubit>().getGenreMovieList(genres[0].id.toString());
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
            onPressed: () {}
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.whatshot),
          onPressed: () {},
        ),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<PopularMovieCubit, PopularMovieState>(
              builder: (context, state) {
                if (state is PopularMovieLoadInProgress) {
                  return CircularProgressIndicator();
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
                      height: 200,
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
            )
          ],
        ),
      ),
    );
  }

  _buildCarouselSlider(List<MovieList> list) {
    return CarouselSlider(
      items: list.sublist(0, 5).map((item) => Container(
        child: Container(
          margin: EdgeInsets.all(5.0),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Stack(
              children: <Widget>[
                Image.network('${Config.baseImageUrl}${item.backdropPath}', fit: BoxFit.cover),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        end: Alignment(0.0, -1),
                        begin: Alignment(0.0, 0.4),
                        colors: <Color>[
                          Color(0x8A000000),
                          Colors.black12.withOpacity(0.0)
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 24.0,
                  left: 10.0,
                  child: Text(
                    item.originalTitle,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      )).toList(),
      options: CarouselOptions(
        autoPlay: true,
        viewportFraction: 0.98,
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
    return Positioned(
      bottom: 5.0,
      left: 0.0,
      right: 0.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: list.sublist(0,5).map((item) {
          int index = list.indexOf(item);
          return Container(
            width: 5.0,
            height: 5.0,
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 3.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _current == index
                ? ColorBase.mandy
                : Color.fromRGBO(255, 255, 255, 0.4),
            ),
          );
        }).toList(),
      ),
    );
  }

  _buildTabbar() {
    return TabBar(
      controller: _tabController,
      onTap: (index) => context.bloc<GenreMovieListCubit>().getGenreMovieList(genres[index].id.toString()),
      labelColor: Colors.white,
      indicatorColor: ColorBase.mandy,
      isScrollable: true,
      tabs: genres.map((item) {
        return Tab(
          text: item.name,
        );
      }).toList(),
    );
  }

  _buildTabBarView(List <MovieList> genreListMovies) {
    return Container(
      height: 300,
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
              return Container(
                padding: EdgeInsets.only(top: 8.0, right: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(2.0)),
                      child: Image.network(
                        '${Config.baseImageUrl}${data.posterPath}',
                        fit: BoxFit.cover,
                        width: 120.0,
                        height: 180.0,
                      ),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 120),
                      child: Container(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text(
                          data.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13.0,
                            color: Colors.white,
                            height: 1.3
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "${data.voteAverage}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13.0,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 4.0),
                            child: RatingBar(
                              onRatingUpdate: null,
                              itemCount: 5,
                              ignoreGestures: true,
                              itemSize: 12.0,
                              initialRating: data.voteAverage / 2,
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
          );
        }).toList(),
      ),
    );
  }
}