import 'package:bingo/view/pauseScreen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

List<String> imgList = [
  'assets/sponsor/captain.png',
  'assets/sponsor/jetm.png',
  'assets/sponsor/justin_bridou.png',
  'assets/sponsor/ricard.png',
];

class CarouselWidget extends StatefulWidget {
  @override
  _CarouselWidget createState() => _CarouselWidget();
}

class _CarouselWidget extends State<CarouselWidget> {
  int _current = 0;

  static List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

  static final child = imgList.length > 0
      ? map<Widget>(
          imgList,
          (index, i) {
            return Container(
              margin: EdgeInsets.all(5.0),
              child: Stack(children: <Widget>[
                Image(
                  image: AssetImage(i),
                  fit: BoxFit.cover,
                  // width: 50,
                   height: 250, //screenWidth * 0.2,
                ),
              ]),
            );
          },
        ).toList()
      : null;


//TODO: image screen height ratio
  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;
    return Column(children: <Widget>[
      CarouselSlider(
          items: child,
          options: CarouselOptions(
            autoPlay: true,
            viewportFraction: 0.33,
            height: 250,
            autoPlayAnimationDuration: const Duration(milliseconds: 1000),
            autoPlayInterval: const Duration(seconds: 5),
            pauseAutoPlayOnManualNavigate: false,
            pauseAutoPlayOnTouch: false,
          ))
    ]);
  }
}
