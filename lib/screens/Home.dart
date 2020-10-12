import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/blocs/popularmovie/cubit/PopularMovieCubit.dart';
import 'package:movie_app/configs/Config.dart';

import 'package:movie_app/constants/Colors.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
              print(state.popularMovies);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      CarouselSlider(
                        items: state.popularMovies.map((item) => Container(
                          child: Container(
                            margin: EdgeInsets.all(5.0),
                            child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                child: Stack(
                                  children: <Widget>[
                                    Image.network('${Config.baseImageUrl}${item.backdropPath}', fit: BoxFit.fill),
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
                                )
                            ),
                          ),
                        )).toList(),
                        options: CarouselOptions(
                          autoPlay: true,
                          viewportFraction: 1.0,
                          enlargeCenterPage: false,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          }
                        ),
                      ),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: state.popularMovies.map((item) {
                            int index = state.popularMovies.indexOf(item);
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
                      )
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
}

// Widget getNewMoviees() {
//   return SizedBox(height: 16.0),
//     Padding(
//       padding: EdgeInsets.all(16.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             'New Trailer',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 18
//             ),
//           ),
//           Text(
//             'See All',
//             style: TextStyle(
//               color: ColorBase.amethystSmoke,
//               fontSize: 16.0
//             ),
//           )
//         ],
//       ),
//     ),
//     Container(
//       height: MediaQuery.of(context).size.height * 0.28,
//       child: ListView.builder(
//         padding: EdgeInsets.only(left: 16),
//         scrollDirection: Axis.horizontal,
//         itemCount: popularMovies.length,
//         itemBuilder: (context, index) {
//           return Column(
//             children: [
//               Container(
//                 height: 160.0,
//                 width: MediaQuery.of(context).size.width * 0.6,
//                 margin: EdgeInsets.all(5.0),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                   child: Image.network(popularMovies[index].avatar, fit: BoxFit.cover),
//                 ),
//               ),
//               SizedBox(height: 5.0),
//               Text(
//                 'Captain Philips 2019',
//                 style: TextStyle(
//                   color: ColorBase.amethystSmoke,
//                   fontSize: 16.0
//                 ),
//               ),
//               SizedBox(height: 5.0),
//               Text(
//                 'Drama . Action . Crime',
//                 style: TextStyle(
//                   color: ColorBase.mandy,
//                   fontSize: 12.0
//                 ),
//               )
//             ],
//           );
//         },
//       ),
//     );
// }