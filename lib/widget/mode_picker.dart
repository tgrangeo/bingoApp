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
  int select = 2;

  @override
  void initState() {
    var mode = widget.prefs.getString("mode");
    if (mode == "normal") {
      select = 1;
    } else {
      select = 2;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Card(
      color: Color.fromARGB(151, 228, 231, 234),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      elevation: 20,
      child: Column(children: [
        const SizedBox(height: 10),
        const Text(
          "Mode",
          style: TextStyle(
            fontSize: 33,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          OutlinedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  select == 1 ? Colors.black : Colors.transparent),
              padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.all(20)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  //TODO: border bigger and black 
                  // side: const BorderSide(width: 5.0, color: Colors.green),
              // side: BorderSide(width: 5.0, color: Colors.green,style: BorderStyle.solid)
            )),
            ),
            onPressed: () {
              setState(() {
                select = 1;
              });
              widget.prefs.setString('mode', "normal");
            },
            child: Text(
              "Normal",
              style: TextStyle(
                  color: select == 1 ? Colors.white : Colors.black,
                  fontSize: 22),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          OutlinedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  select == 2 ? Colors.black : Colors.transparent),
              padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.all(20)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: const BorderSide(width: 2),
              )),
            ),
            onPressed: () {
              setState(() {
                select = 2;
              });
              widget.prefs.setString('mode', "libre");
            },
            child: Text(
              "Libre",
              style: TextStyle(
                  color: select == 2 ? Colors.white : Colors.black,
                  fontSize: 22),
            ),
          ),
        ])),
      ]),
    );
  }
}
