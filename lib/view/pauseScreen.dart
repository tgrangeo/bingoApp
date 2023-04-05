//import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:flutter/material.dart';
import '../widget/stopwatch.dart';

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
                StopWatchTimerPage(),
                SizedBox(width: screenWidth * 0.05),
              ]),
              SizedBox(height: screenWidth * 0.06),
              const Text("Merci a nos partenaires :", style: TextStyle(color: Colors.black,fontSize: 48, decoration: TextDecoration.underline)),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children: [
                    for (var item in imgList)
                      Center(
                        child: Image(
                          image: item,
                          fit: BoxFit.cover,
                          width: screenWidth * 0.2,
                        ),
                      )
                  ],
                ),
              )
            ])));
  }
}
