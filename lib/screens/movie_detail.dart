import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/blocs/moviedetail/movie_detail_cubit.dart';
import 'package:movie_app/configs/configs.dart';
import 'package:movie_app/models/movie_detail.dart';
import 'package:movie_app/utils/helpers.dart';
import 'package:movie_app/widgets/carousel_item.dart';
import 'package:movie_app/widgets/custom_appbar.dart';

class DetailMovie extends StatefulWidget {
  final int movieId;
  DetailMovie({this.movieId});

  @override
  _DetailMovieState createState() => _DetailMovieState();
}

class _DetailMovieState extends State<DetailMovie> {
  @override
  void initState() {
    context.bloc<MovieDetailCubit>().getMovieDetail(widget.movieId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
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
          MovieDetail data = state.movieDetail;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _featuredImages(data.images.backdrops),
              _movieTitleInfo(data),
              _divider(),
              _movieDescInfo(data),
              _divider(),
              _movieInfoStatus(data),
              _divider(),
            ],
          );
        } else {
          return Container();
        }
      }),
    );
  }

  Widget _featuredImages(List<Backdrop> data) {
    return CarouselSlider(
      items: data.map((item) {
        return CarouselItem(
          avatar: item.filePath,
          title: '',
        );
      }).toList(),
      options: CarouselOptions(
        autoPlay: true,
        viewportFraction: 1,
        enlargeCenterPage: false,
      ),
    );
  }

  Widget _movieTitleInfo(MovieDetail data) {
    int year = DateTime.parse(data.releaseDate.toString()).year;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 8,
                child: Text(
                  data.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 28.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  splashRadius: 20.0,
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
          RichText(
            text: TextSpan(
              text: '${year.toString()} ',
              style: TextStyle(fontSize: 12.0, color: Colors.white70),
              children: <TextSpan>[
                TextSpan(text: '• '),
                TextSpan(
                  text: Helper.convertHoursMinutes(data.runtime),
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _movieDescInfo(MovieDetail data) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 1,
              child: Image.network(
                "${Config.baseImageUrl}${data.posterPath}",
                height: 180.0,
                width: 120.0,
                fit: BoxFit.fill,
              )),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                children: [
                  Container(
                    height: 30,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: data.genres.length,
                      itemBuilder: (context, index) {
                        Genre genre = data.genres[index];
                        return Padding(
                          padding: EdgeInsets.only(right: 6.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white12,
                              ),
                              borderRadius: BorderRadius.circular(3.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 6.0,
                                horizontal: 12,
                              ),
                              child: Text(
                                genre.name,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      data.overview,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                      style: TextStyle(
                        height: 1.4,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _movieInfoStatus(MovieDetail data) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: Center(
              child: Column(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: RichText(
                      text: TextSpan(
                        text: '${data.voteAverage}',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '/10',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 4.0,
                    ),
                    child: Text(
                      'Rating',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Center(
              child: Column(
                children: [
                  Icon(
                    Icons.attach_money,
                    color: Colors.green,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      data.revenue < 1
                          ? 'USD -'
                          : NumberFormat.compactCurrency(
                              locale: 'en',
                              decimalDigits: 0,
                              name: "USD ",
                            ).format(data.revenue),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 4.0,
                    ),
                    child: Text(
                      'Revenue',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13.0,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Center(
              child: Column(
                children: [
                  Icon(
                    Icons.local_movies_outlined,
                    color: Colors.redAccent,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      data.status,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 4.0,
                    ),
                    child: Text(
                      'Status',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Divider(
      color: Colors.white12,
      thickness: 1,
      endIndent: 0,
    );
  }
}
