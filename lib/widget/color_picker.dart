import 'dart:io';
import 'package:bingo/widget/sponsor_picker.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerWidget extends StatefulWidget {
  final SharedPreferences prefs;
  ColorPickerWidget({super.key, required this.prefs});
  @override
  _ColorPickerWidget createState() => _ColorPickerWidget();
}

class _ColorPickerWidget extends State<ColorPickerWidget> {
  Color pickerColor = Color(0xff443a49);
  // Color currentColor = Color(0xff443a49);

  late Color colorSelect;
  late Color colorUnselect;
  late Color textSelected;
  late Color textUnselected;

  @override
  initState() {
    colorUnselect =
        Color(widget.prefs.getInt('colorUnselect') ?? Colors.black.value);
    colorSelect = Color(widget.prefs.getInt('colorSelect') ??
        const Color.fromARGB(255, 252, 179, 51).value);

    textUnselected =
        Color(widget.prefs.getInt('textColorUnselect') ?? Colors.white.value);
    textSelected =
        Color(widget.prefs.getInt('textColorSelect') ?? Colors.black.value);
  }

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  void _showDialog(tochange) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Pick a color!'),
            content: SingleChildScrollView(
                child: ColorPicker(
              pickerColor: pickerColor,
              onColorChanged: changeColor,
            )),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('confirm'),
                onPressed: () {
                  setState(() {
                    if (tochange == "colorSelect") {
                      colorSelect = pickerColor;
                      widget.prefs.setInt('colorSelect', colorSelect.value);
                    } else if (tochange == "colorUnselect") {
                      colorUnselect = pickerColor;
                      widget.prefs.setInt('colorUnselect', colorUnselect.value);
                    }
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Card(
        color: Color.fromARGB(160, 228, 231, 234),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        elevation: 20,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          // const SizedBox(height: 10,),
          const Text(
            "Couleurs des nombres",
            style: TextStyle(
              fontSize: 33,
              fontWeight: FontWeight.bold,
            ),
          ),

          Column(children: [
            const Text("Bouton non selectionné",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  decoration: TextDecoration.underline,
                )),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("couleur du fond :     ",
                    style: TextStyle(color: Colors.black, fontSize: 18)),
               ClipOval(
                    child: Material(
                      color: colorUnselect,
                      child: InkWell(
                        onTap: () {
                          _showDialog("colorUnselect");
                        },
                        child: const SizedBox(width: 38, height: 38),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("couleur du texte :     ",
                    style: TextStyle(color: Colors.black, fontSize: 18)),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  child: IconButton(
                      onPressed: () {
                        setState(() => textUnselected = Colors.white);
                        widget.prefs
                            .setInt('textColorUnselect', textUnselected.value);
                      },
                      icon: Icon(
                        Icons.check,
                        color: Colors.black,
                        size: textUnselected == Colors.white ? 25 : 0,
                      )),
                ),
                const SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.black,
                  child: IconButton(
                      onPressed: () {
                        setState(() => textUnselected = Colors.black);
                        widget.prefs
                            .setInt('textColorUnselect', textUnselected.value);
                      },
                      icon: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: textUnselected == Colors.black ? 25 : 0,
                      )),
                ),
              ],
            ),
          ]),

          Column(
            children: [
              const Text("Bouton selectionné",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    decoration: TextDecoration.underline,
                  )),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("couleur du fond :     ",
                      style: TextStyle(color: Colors.black, fontSize: 18)),
                  ClipOval(
                    child: Material(
                      color: colorSelect, // Button color
                      child: InkWell(
                        // Splash color
                        onTap: () {
                          _showDialog("colorSelect");
                        },
                        child: const SizedBox(width: 38, height: 38),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Couleur du texte:     ",
                      style: TextStyle(color: Colors.black, fontSize: 18)),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    child: IconButton(
                        onPressed: () {
                          setState(() => textSelected = Colors.white);
                          widget.prefs
                              .setInt('textColorSelect', textSelected.value);
                        },
                        icon: Icon(
                          Icons.check,
                          color: Colors.black,
                          size: textSelected == Colors.white ? 25 : 0,
                        )),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.black,
                    child: IconButton(
                        onPressed: () {
                          setState(() => textSelected = Colors.black);
                          widget.prefs
                              .setInt('textColorSelect', textSelected.value);
                        },
                        icon: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: textSelected == Colors.black ? 25 : 0,
                        )),
                  ),
                ],
              ),
            ],
          ),

          const Text("Aperçue :",
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                decoration: TextDecoration.underline,
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    backgroundColor: colorUnselect,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(500),
                    ),
                  ),
                  child: Text('69',
                      style: TextStyle(fontSize: 48, color: textUnselected))),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    backgroundColor: colorSelect,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(500),
                    ),
                  ),
                  child: Text('69',
                      style: TextStyle(fontSize: 48, color: textSelected))),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ]));
  }
}
