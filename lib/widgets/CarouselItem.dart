import 'package:flutter/material.dart';

import 'package:movie_app/configs/Config.dart';

class CarouselItem extends StatelessWidget {

  final String avatar;
  final String title;

  CarouselItem({
    @required this.avatar,
    @required this.title
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Stack(
          children: <Widget>[
            Image.network('${Config.baseImageUrl}$avatar', fit: BoxFit.cover),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    end: Alignment(0.0, -1),
                    begin: Alignment(0.0, 0.4),
                    colors: <Color>[
                      Colors.black,
                      Colors.black.withOpacity(0.0)
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 30.0,
              left: 10.0,
              child: Text(
                title,
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
    );
  }
}
