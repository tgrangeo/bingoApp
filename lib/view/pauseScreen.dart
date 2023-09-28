//import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:bingo/widget/pause_carousel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widget/stopwatch.dart';
import '../style/style.dart' as s;
import 'package:lottie/lottie.dart';

class PauseScreen extends StatefulWidget {
  final SharedPreferences prefs;
  PauseScreen({super.key, required this.prefs});

  @override
  State<PauseScreen> createState() => _PauseScreen();
}

class _PauseScreen extends State<PauseScreen> with TickerProviderStateMixin {
  int sponsorLen = 0;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    sponsorLen = widget.prefs.getStringList('imgList')!.length;
    _controller = AnimationController(vsync: this);
    // _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xffD7DDE8),
                Color.fromARGB(255, 152, 136, 93),
              ],
            )),
            child: Stack(alignment: Alignment.topCenter, children: [
              Positioned(
                  top: screenHeight * 0.02,
                  left: screenWidth * 0.02,
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 42,
                      ))),
              SizedBox(height: screenHeight * 0.15),
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Image(
                      image: const AssetImage('assets/logo_caserne.png'),
                      width: screenHeight * 0.3),
                  SizedBox(width: screenWidth * 0.05),
                  StopWatchTimerPage(prefs: widget.prefs),
                  SizedBox(width: screenWidth * 0.05),
                ]),
                SizedBox(height: screenWidth * 0.06),
                Card(
                    color: const Color.fromARGB(122, 228, 231, 234),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    elevation: 20,
                    child: Container(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, left: 100, right: 100),
                        child: const Text("Merci a nos partenaires :",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 48,
                            )))),
                SizedBox(height: screenWidth * 0.01),
                sponsorLen > 0
                    ? SizedBox(
                        width: screenWidth * 0.6,
                        child: CarouselWidget(prefs: widget.prefs),
                      )
                    : const Text("no sponsor"),
              ])
            ])));
  }
}
