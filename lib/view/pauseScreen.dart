//import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:bingo/widget/carousel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widget/stopwatch.dart';

class PauseScreen extends StatefulWidget {
  final SharedPreferences prefs;
  PauseScreen({super.key, required this.prefs});

  @override
  State<PauseScreen> createState() => _PauseScreen();
}

class _PauseScreen extends State<PauseScreen> {
  int sponsorLen = 0;

  @override
  void initState() {
    sponsorLen = widget.prefs.getStringList('imgList')!.length;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.2), BlendMode.dstATop),
                image: const Image(
                  image: AssetImage('assets/logo_caserne.png'),
                ).image,
              ),
            ),
            child: Column(children: [
              OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("retour")),
              SizedBox(height: screenHeight * 0.15),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                SizedBox(width: screenWidth * 0.05),
                StopWatchTimerPage(prefs: widget.prefs),
                SizedBox(width: screenWidth * 0.05),
              ]),
              SizedBox(height: screenWidth * 0.06),
              const Text("Merci a nos partenaires :",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 48,
                      decoration: TextDecoration.underline)),
              SizedBox(height: screenWidth * 0.01),
              sponsorLen > 0 ? SizedBox(
                width: screenWidth * 0.6,
                child: CarouselWidget(prefs: widget.prefs),
              ): const Text("no sponsor"),
            ])));
  }
}
