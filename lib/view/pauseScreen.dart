//import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:flutter/material.dart';
import '../widget/stopwatchtest.dart';


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
      child: Column(
        children: [
          StopWatchTimerPage(),
        ],
      ),
    ));
  }
}
