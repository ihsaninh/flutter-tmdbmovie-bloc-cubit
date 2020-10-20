import 'package:flutter/material.dart';

import 'package:movie_app/configs/configs.dart';

class CarouselItem extends StatelessWidget {
  final String avatar;
  final String title;
  final Function onTap;

  CarouselItem({
    @required this.avatar,
    @required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          ShaderMask(
            shaderCallback: (rect) {
              return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black, Colors.transparent],
              ).createShader(
                Rect.fromLTRB(
                  0,
                  0,
                  rect.width,
                  rect.height,
                ),
              );
            },
            blendMode: BlendMode.dstIn,
            child: Image.network(
              '${Config.baseImageUrl}$avatar',
              fit: BoxFit.cover,
            ),
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
          Positioned(
            bottom: 30.0,
            left: 10.0,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
