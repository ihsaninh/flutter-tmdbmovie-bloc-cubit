import 'package:flutter/material.dart';

import 'package:movie_app/configs/configs.dart';

class CarouselItem extends StatelessWidget {
  final String avatar;
  final String title;

  CarouselItem({@required this.avatar, @required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
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
      ),
    );
  }
}
