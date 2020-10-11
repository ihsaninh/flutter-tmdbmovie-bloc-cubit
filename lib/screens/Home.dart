import 'package:flutter/material.dart';

import 'package:movie_app/constants/Colors.dart';
import 'package:carousel_slider/carousel_slider.dart';

final List<String> imgList = [
  'https://image.tmdb.org/t/p/w500/aO5ILS7qnqtFIprbJ40zla0jhpu.jpg',
  'https://image.tmdb.org/t/p/w500/kMe4TKMDNXTKptQPAdOF0oZHq3V.jpg',
  'https://image.tmdb.org/t/p/w500/zzWGRw277MNoCs3zhyG3YmYQsXv.jpg',
  'https://image.tmdb.org/t/p/w500/pq0JSpwyT2URytdFG0euztQPAyR.jpg',
  'https://image.tmdb.org/t/p/w500/86L8wqGMDbwURPni2t7FQ0nDjsH.jpg',
];

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _current = 0;

  final List<Widget> imageSliders = imgList.map((item) => Container(
    child: Container(
      margin: EdgeInsets.all(5.0),
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          child: Stack(
            children: <Widget>[
              Image.network(item, fit: BoxFit.cover),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(300, 0, 0, 0),
                        Color.fromARGB(0, 0, 0, 0)
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: Text(
                    'No. ${imgList.indexOf(item)} image',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          )
      ),
    ),
  )).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies db'),
        centerTitle: true,
        elevation: 0.0,
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {}
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.whatshot),
          onPressed: () {},
        ),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CarouselSlider(
                  items: imageSliders,
                  options: CarouselOptions(
                    autoPlay: true,
                    viewportFraction: 1.0,
                    enlargeCenterPage: false,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }
                  ),
                ),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imgList.map((url) {
                      int index = imgList.indexOf(url);
                      return Container(
                        width: 6.0,
                        height: 6.0,
                        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _current == index
                              ? ColorBase.mandy
                              : Color.fromRGBO(255, 255, 255, 0.4),
                        ),
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'New Trailer',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18
                    ),
                  ),
                  Text(
                    'See All',
                    style: TextStyle(
                      color: ColorBase.amethystSmoke,
                      fontSize: 16.0
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.28,
              child: ListView.builder(
                padding: EdgeInsets.only(left: 16),
                scrollDirection: Axis.horizontal,
                itemCount: imgList.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        height: 160.0,
                        width: MediaQuery.of(context).size.width * 0.6,
                        margin: EdgeInsets.all(5.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          child: Image.network(imgList[index], fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        'Captain Philips 2019',
                        style: TextStyle(
                          color: ColorBase.amethystSmoke,
                          fontSize: 16.0
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        'Drama . Action . Crime',
                        style: TextStyle(
                          color: ColorBase.mandy,
                          fontSize: 12.0
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
