import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function onTap;
  final double titleFontSize;
  final FontWeight titleFontWeight;
  final double subtitleFontSize;

  SectionHeader({
    @required this.title,
    @required this.subtitle,
    this.onTap,
    this.titleFontSize = 14.0,
    this.titleFontWeight = FontWeight.w600,
    this.subtitleFontSize = 13.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        12.0,
        16.0,
        10.0,
        12.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: titleFontSize,
              fontWeight: titleFontWeight,
              color: Colors.white70,
            ),
          ),
          Text(
            subtitle.toUpperCase(),
            style: TextStyle(
              fontSize: subtitleFontSize,
              fontWeight: FontWeight.w600,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
