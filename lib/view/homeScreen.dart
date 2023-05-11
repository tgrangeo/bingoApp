import 'package:bingo/view/gameScreen.dart';
import 'package:bingo/widget/color_picker.dart';
import 'package:bingo/widget/mode_picker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widget/sponsor_picker.dart';
import '../widget/time_picker.dart';

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
                Color(0xffD7DDE8),// (144, 144, 144, 1),
                Color.fromARGB(255, 152, 136, 93),
                // Color(0xff757F9A),
                // const Color.fromARGB(255, 252, 179, 51),
              ],)),
       child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: screenHeight * 0.1,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: AssetImage('assets/logo_caserne.png'), width: screenHeight * 0.15),
                Text("LOTO POMPIER",style: TextStyle(fontSize: screenHeight * 0.10),),
                Image(image: AssetImage('assets/logo_caserne.png'), width: screenHeight * 0.15),
              ],
            ),
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                    //TODO: height responsive
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



                    OutlinedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black),
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
              child: const Text(
                "Play",
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
