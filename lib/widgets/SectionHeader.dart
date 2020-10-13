import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {

  final String title;
  final String subtitle;
  final Function onTap;

  SectionHeader({
    @required this.title,
    @required this.subtitle,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 16.0, bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
              color: Colors.white70,
            ),
          ),
          Text(
            subtitle.toUpperCase(),
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
