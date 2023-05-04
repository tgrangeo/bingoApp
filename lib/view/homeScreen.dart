import 'package:bingo/view/gameScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widget/sponsor_picker.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SponsorPicker(prefs:widget.prefs),
            OutlinedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => GameScreen(prefs:widget.prefs),
                    ),
                  );
                },
                child: const Text("play"))
          ],
        ),
      ),
    );
  }
}
