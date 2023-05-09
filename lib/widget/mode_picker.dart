import 'package:bingo/view/gameScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ModePicker extends StatefulWidget {
  final SharedPreferences prefs;
  const ModePicker({super.key, required this.prefs});

  @override
  State<ModePicker> createState() => _ModePicker();
}

class _ModePicker extends State<ModePicker> {
  int select = 0;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Card(
      color: Colors.grey[300],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      elevation: 2,
      child: Column(
        children: [
          const Text(
            "Mode",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Wrap(direction: Axis.vertical, spacing: 10, children: [
            InkWell(
              onTap: () {
                setState(() {
                  select = 1;
                });
                widget.prefs.setString('mode', "normal");
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                color: select == 1 ? Colors.amber : Colors.grey,
                child: const Text("normal"),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  select = 2;
                });
                widget.prefs.setString('mode', "libre");
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                color: select == 2 ? Colors.amber : Colors.grey,
                child: const Text("libre"),
              ),
            )
          ])
        ],
      ),
    );
  }
}
