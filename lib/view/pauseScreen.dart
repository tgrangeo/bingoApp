//import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:flutter/material.dart';
import '../widget/stopwatchtest.dart';

List imgList = [
  AssetImage('assets/sponsor/captain.png'),
  AssetImage('assets/sponsor/jetm.png'),
  AssetImage('assets/sponsor/justin_bridou.png'),
  AssetImage('assets/sponsor/ricard.png'),
];

class PauseScreen extends StatefulWidget {
  PauseScreen({super.key});

  @override
  State<PauseScreen> createState() => _PauseScreen();
}

class _PauseScreen extends State<PauseScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Container(
            child: Column(children: [
      SizedBox(height: screenHeight * 0.15),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Image(
          image: AssetImage('assets/ol.png'),
          fit: BoxFit.cover,
          width: 170,
        ),
        SizedBox(width: screenWidth * 0.05),
        StopWatchTimerPage(),
        SizedBox(width: screenWidth * 0.05),
        const Image(
          image: AssetImage('assets/ol.png'),
          fit: BoxFit.cover,
          width: 170,
        ),
      ]),
      Expanded(child:ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: [
          // showing list of images
          for (var item in imgList)
            Center(
              child: Image(
                image: item,
                fit: BoxFit.cover,
                width: 300,
              ),
              //child: Container(width: 150, height: 100, child: item),
            )
        ],
      ),
    )])));
  }
}
