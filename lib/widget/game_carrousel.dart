import 'package:bingo/view/pauseScreen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class GameCarouselWidget extends StatefulWidget {
  final SharedPreferences prefs;
  const GameCarouselWidget({super.key, required this.prefs});
  @override
  _GameCarouselWidget createState() => _GameCarouselWidget();
}

class _GameCarouselWidget extends State<GameCarouselWidget> {
  // int _current = 0;
  List<String> imgList = [];
  late var child;

  createList() {
    imgList = widget.prefs.getStringList('imgList') as List<String>;
    child = imgList.isNotEmpty
        ? map<Widget>(
            imgList,
            (index, i) {
              return Container(
                margin: const EdgeInsets.all(5.0),
                child: Stack(children: <Widget>[
                  Image(
                    image: FileImage(File(i)),
                    fit: BoxFit.contain,
                    // width: 50,
                    height: 250, //screenWidth * 0.2,
                  ),
                ]),
              );
            },
          ).toList()
        : null;
  }

  @override
  void initState() {
    super.initState();
    createList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  static List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

//TODO: image screen height ratio
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(children: <Widget>[
      CarouselSlider(
          items: child,
          options: CarouselOptions(
            scrollDirection: Axis.vertical,
            autoPlay: true,
            viewportFraction: 0.33,
            height: screenHeight * 0.5,
            autoPlayAnimationDuration: const Duration(milliseconds: 1000),
            autoPlayInterval: const Duration(seconds: 5),
            pauseAutoPlayOnManualNavigate: false,
            pauseAutoPlayOnTouch: false,
          ))
    ]);
  }
}
