import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/blocs/moviedetail/movie_detail_cubit.dart';
import 'package:movie_app/widgets/carousel_item.dart';

class MovieDetail extends StatefulWidget {
  final int movieId;
  MovieDetail({this.movieId});

  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  @override
  void initState() {
    context.bloc<MovieDetailCubit>().getMovieDetail(widget.movieId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MovieDetailCubit, MovieDetailState>(
          builder: (context, state) {
        if (state is MovieDetailLoadInProgress) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.white,
              ),
            ),
          );
        } else if (state is MovieDetailLoadSuccess) {
          var data = state.movieDetail;
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 250.0,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios_rounded),
                  onPressed: () => Navigator.pop(context),
                ),
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    data.title,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  background: CarouselSlider(
                    items: data.images.backdrops.map(
                      (item) {
                        return CarouselItem(
                          avatar: item.filePath,
                          title: '',
                        );
                      },
                    ).toList(),
                    options: CarouselOptions(
                      autoPlay: true,
                      viewportFraction: 1,
                      enlargeCenterPage: false,
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 75,
                      color: Colors.black12,
                    ),
                  ),
                  childCount: 10,
                ),
              )
            ],
          );
        } else {
          return Container();
        }
      }),
    );
  }
}
