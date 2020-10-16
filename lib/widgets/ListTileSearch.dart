import 'package:flutter/material.dart';

import 'package:movie_app/configs/Config.dart';

class ListTileSearch extends StatelessWidget {
  final String poster;
  final String title;
  final String date;

  ListTileSearch({
    @required this.poster,
    @required this.title,
    @required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: Container(
        height: 200,
        child: Image.network(
          '${Config.baseImageUrl}$poster',
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      subtitle: Text(
        date.length > 3 ? date.substring(0, 4) : date,
        style: TextStyle(
          color: Colors.white70,
        ),
      ),
    );
  }
}
