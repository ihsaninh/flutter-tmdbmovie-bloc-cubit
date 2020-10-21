import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:movie_app/configs/configs.dart';

class MovieCard extends StatelessWidget {
  final String title;
  final String poster;
  final double rating;
  final Function onTap;
  final String subtitle;

  MovieCard({
    @required this.title,
    @required this.poster,
    this.rating,
    this.subtitle,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(
          top: 8.0,
          right: 12.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(2.0),
              ),
              child: Stack(
                children: [
                  poster == null
                      ? Container(
                          height: 180.0,
                          width: 120.0,
                          child: Icon(
                            Icons.person,
                            size: 100,
                            color: Colors.white24,
                          ),
                        )
                      : Image.network(
                          '${Config.baseImageUrl}$poster',
                          fit: BoxFit.cover,
                          width: 120.0,
                          height: 180.0,
                        ),
                  Positioned.fill(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Color.fromRGBO(
                          0,
                          0,
                          0,
                          0.3,
                        ),
                        highlightColor: Color.fromRGBO(
                          0,
                          0,
                          0,
                          0.1,
                        ),
                        onTap: onTap,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 120,
              ),
              child: Container(
                padding: EdgeInsets.only(
                  top: 8.0,
                ),
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
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 120,
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: 4.0,
                ),
                child: rating == null
                    ? Text(
                        subtitle,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.white70,
                          height: 1.3,
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: 4.0,
                            ),
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
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
