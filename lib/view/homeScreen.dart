import 'package:bingo/view/gameScreen.dart';
import 'package:bingo/widget/mode_picker.dart';
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
                        Expanded(
                            child: Card(
                          elevation: 2,
                          child: SponsorPicker(prefs: widget.prefs),
                          color: Colors.grey[300],
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        )),
                        Expanded(
                            child:ModePicker(prefs: widget.prefs),
                        ),
                        Expanded(
                            child: Card(
                                child: SponsorPicker(prefs: widget.prefs))),
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
