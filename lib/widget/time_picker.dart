import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

var timeList = [
  0,
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  9,
  10,
  11,
  12,
  13,
  14,
  15,
  16,
  17,
  18,
  19,
  20,
  21,
  22,
  23,
  24,
  25,
  26,
  27,
  28,
  29,
  30,
  31,
  32,
  33,
  34,
  35,
  36,
  37,
  38,
  39,
  40,
  41,
  42,
  43,
  44,
  45,
  46,
  47,
  48,
  49,
  50,
  51,
  52,
  53,
  54,
  55,
  56,
  57,
  58,
  59
];

class TimePicker extends StatefulWidget {
  final SharedPreferences prefs;
  TimePicker({super.key, required this.prefs});

  @override
  State<TimePicker> createState() => _TimePicker();
}

class _TimePicker extends State<TimePicker> {
  int hours = 0;
  int minutes = 0;
  int secondes = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2,
        color: Colors.grey[300],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          children: [
            const Text(
                  "Pause time",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
            const SizedBox(
                  height: 20,
                ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("hours : "),
                DropdownButton(
                    value: hours,
                    items: timeList.map((int items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items.toString()),
                      );
                    }).toList(),
                    onChanged: (value) => setState(() {
                          hours = value!;
                          widget.prefs.setInt('hours', hours);
                        })),
                const SizedBox(
                  width: 5,
                ),
                const Text("min : "),
                DropdownButton(
                    value: minutes,
                    items: timeList.map((int items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items.toString()),
                      );
                    }).toList(),
                    onChanged: (value) => setState(() {
                          minutes = value!;
                           widget.prefs.setInt('minutes', minutes);
                        })),
                const SizedBox(
                  width: 5,
                ),
                const Text("sec : "),
                DropdownButton(
                    value: secondes,
                    items: timeList.map((int items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items.toString()),
                      );
                    }).toList(),
                    onChanged: (value) => setState(() {
                          secondes = value!;
                          widget.prefs.setInt('secondes', secondes);
                        })),
              ],
            )
          ],
        ));
  }
}
