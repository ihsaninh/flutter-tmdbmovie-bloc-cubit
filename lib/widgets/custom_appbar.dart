import 'package:flutter/material.dart';
import 'package:movie_app/constants/navigation.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Movies DB'),
      elevation: 0.0,
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () => Navigator.pushNamed(
            context,
            Navigation.SearchPage,
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.settings,
          ),
          onPressed: () {},
        ),
      ],
      leading: Icon(
        Icons.motion_photos_on_rounded,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

}
