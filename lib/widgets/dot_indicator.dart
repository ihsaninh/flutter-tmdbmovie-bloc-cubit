import 'package:flutter/material.dart';

import 'package:movie_app/constants/colors.dart';
import 'package:movie_app/models/movie_list.dart';

class DotIndicator extends StatelessWidget {
  final List<MovieList> lists;
  final int currentIndex;

  DotIndicator({@required this.lists, @required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 5.0,
      left: 0.0,
      right: 0.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: lists.sublist(0, 5).map((item) {
          int index = lists.indexOf(item);
          return Container(
            width: 5.0,
            height: 5.0,
            margin: EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 3.0,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: currentIndex == index
                  ? Colors.white
                  : Color.fromRGBO(255, 255, 255, 0.4),
            ),
          );
        }).toList(),
      ),
    );
  }
}
