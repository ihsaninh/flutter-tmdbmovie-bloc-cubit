import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:movie_app/configs/Config.dart';

class MovieCard extends StatelessWidget {

  final String title;
  final String poster;
  final double rating;
  final Function onTap;

  MovieCard({
    @required this.title,
    @required this.poster,
    @required this.rating,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8.0, right: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(2.0)),
            child: Image.network(
              '${Config.baseImageUrl}$poster',
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
                title,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                    color: Colors.white,
                    height: 1.3,
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
                  rating.toString(),
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
                    initialRating: rating / 2,
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
}
