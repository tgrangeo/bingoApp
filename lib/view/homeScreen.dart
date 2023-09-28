import 'package:bingo/view/gameScreen.dart';
import 'package:bingo/widget/color_picker.dart';
import 'package:bingo/widget/mode_picker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widget/sponsor_picker.dart';
import '../widget/time_picker.dart';
import 'package:lottie/lottie.dart';
import 'dart:math' as math;

import '../style/style.dart' as s;

class MyHomePage extends StatefulWidget {
  final SharedPreferences prefs;
  const MyHomePage({super.key, required this.title, required this.prefs});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Center(
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xffD7DDE8),
            Color.fromARGB(255, 152, 136, 93),
          ],
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: screenHeight * 0.056,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                    image: AssetImage('assets/logo_caserne.png'),
                    width: screenHeight * 0.15),
                Text(
                  "LOTO POMPIER",
                  style: TextStyle(fontSize: screenHeight * 0.10),
                ),
                Image(
                    image: AssetImage('assets/logo_caserne.png'),
                    width: screenHeight * 0.15),
              ],
            ),
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                    height: 600,
                    child: Row(
                      children: [
                        Expanded(child: SponsorPicker(prefs: widget.prefs)),
                        Expanded(
                            child: Column(children: [
                          Expanded(child: ModePicker(prefs: widget.prefs)),
                          Expanded(child: TimePicker(prefs: widget.prefs)),
                        ])),
                        Expanded(child: ColorPickerWidget(prefs: widget.prefs)),
                      ],
                    ))),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    height: 200,
                    width: 160,
                    child: Transform.rotate(
                      angle: math.pi / 180 * -90,
                      alignment: Alignment.center,
                      child: Lottie.asset('assets/lottie/seat-1.json'),
                    )),
                SizedBox(
                  height: 100,
                  width: 200,
                  child: OutlinedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(s.Style.yellow),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          const EdgeInsets.all(20)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => GameScreen(prefs: widget.prefs),
                        ),
                      );
                    },
                    child: Text(
                      "JOUER",
                      style: TextStyle(color: s.Style.black, fontSize: 44),
                    ),
                  ),
                ),
                SizedBox(
                    height: 200,
                    width: 160,
                    child: Transform.rotate(
                      angle: math.pi / 180 * 90,
                      alignment: Alignment.center,
                      child: Lottie.asset('assets/lottie/seat-1.json'),
                    ))
              ],
            )
          ],
        ),
      ),
    ));
  }
}
