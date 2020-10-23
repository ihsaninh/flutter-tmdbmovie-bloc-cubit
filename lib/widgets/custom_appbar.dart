import 'package:flutter/material.dart';
import 'package:movie_app/constants/navigation.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  final bool showSearchButton;

  CustomAppBar({this.showSearchButton = true});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Movies DB'),
      elevation: 0.0,
      actions: [
        showSearchButton ? IconButton(
          icon: Icon(Icons.search),
          onPressed: () => Navigator.pushNamed(
            context,
            Navigation.SearchPage,
          ),
        ) : Container(),
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
