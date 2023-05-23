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
  late int hours;
  late int minutes;
  late int secondes;

  @override
  initState() {
    hours = widget.prefs.getInt('hours') ?? 0;
    minutes = widget.prefs.getInt('minutes') ?? 0;
    secondes = widget.prefs.getInt('secondes') ?? 0;
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 20,
        color: Color.fromARGB(160, 228,231,234),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          children: [
            const SizedBox(height: 10,),
            const Text(
              "Temps de pause",
              style: TextStyle(
                fontSize: 33,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(child:Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("hours : ", style:TextStyle(fontSize: 22, color: Colors.black)),
                DropdownButton(
                    value: hours,
                    iconEnabledColor: Colors.black,
                    style: const TextStyle(fontSize: 22, color: Colors.black),
                    items: timeList.map((int items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Center(child: Text(items.toString())),
                      );
                    }).toList(),
                    onChanged: (value) => setState(() {
                          hours = value!;
                          widget.prefs.setInt('hours', hours);
                          widget.prefs.setInt('minutes', minutes);
                          widget.prefs.setInt('secondes', secondes);
                        })),
                const SizedBox(
                  width: 5,
                ),
                const Text("min : ", style:TextStyle(fontSize: 22, color: Colors.black)),
                DropdownButton(
                    iconEnabledColor: Colors.black,
                    value: minutes,
                    style: const TextStyle(fontSize: 22, color: Colors.black),
                    items: timeList.map((int items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Center(child: Text(items.toString())),
                      );
                    }).toList(),
                    onChanged: (value) => setState(() {
                          minutes = value!;
                          widget.prefs.setInt('hours', hours);
                          widget.prefs.setInt('minutes', minutes);
                          widget.prefs.setInt('secondes', secondes);
                        })),
                const SizedBox(
                  width: 5,
                ),
                const Text("sec : ", style:TextStyle(fontSize: 22, color: Colors.black)),
                DropdownButton(
                    value: secondes,
                    iconEnabledColor: Colors.black,
                    style: const TextStyle(fontSize: 22, color: Colors.black),
                    items: timeList.map((int items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Center(child: Text(items.toString())),
                      );
                    }).toList(),
                    onChanged: (value) => setState(() {
                          secondes = value!;
                          widget.prefs.setInt('hours', hours);
                          widget.prefs.setInt('minutes', minutes);
                          widget.prefs.setInt('secondes', secondes);
                        })),
              ],
            ))
          ],
        ));
  }
}
