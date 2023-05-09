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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                    //TODO: height responsive
                    height: 600,
                    child: Row(
                      children: [
                        Expanded(child: SponsorPicker(prefs: widget.prefs)),
                        Expanded(child:Column(children: [
                          Expanded(child: ModePicker(prefs: widget.prefs)),
                          Expanded(child: TimePicker(prefs: widget.prefs)),
                        ])),
                        Expanded(child: ColorPickerWidget(prefs: widget.prefs)),
                      ],
                    ))),
            OutlinedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => GameScreen(prefs: widget.prefs),
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
