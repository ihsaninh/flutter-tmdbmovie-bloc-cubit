import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/blocs/popularmovie/cubit/PopularMovieCubit.dart';
import 'package:movie_app/configs/Config.dart';

import 'package:movie_app/constants/Colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:movie_app/models/PopularMovie.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _current = 0;

  @override
  void initState() {
    context.bloc<PopularMovieCubit>().getPopularMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies db'),
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
        child: BlocBuilder<PopularMovieCubit, PopularMovieState>(
          builder: (context, state) {
            if (state is PopularMovieLoadInProgress) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularMovieLoadSuccess) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      _buildCarouselSlider(state.popularMovies),
                      _buildCarouselIndicator(state.popularMovies),
                    ],
                  ),
                ],
              );
            } else {
              return Text('Gagal bro', style: TextStyle(color: Colors.white));
            }
          }
        ),
      ),
    );
  }

  _buildCarouselSlider(List<PopularMovie> list) {
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

  _buildCarouselIndicator(List<PopularMovie> list) {
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
}