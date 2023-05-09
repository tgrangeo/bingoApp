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
        color: Colors.grey[300],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        elevation: 2,
        child: Column(children: [
          const Text(
            "Option",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Text("selected color :     "),
              OutlinedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(colorSelect)),
                  onPressed: () {
                    _showDialog("colorSelect");
                  },
                  child: const Text("")),
            ],
          ),
          Row(
            children: [
              const Text("selected text color :     "),
              OutlinedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white)),
                  onPressed: () {
                    setState(() => textSelected = Colors.white);
                    widget.prefs.setInt('textColorSelect', textSelected.value);
                  },
                  child: const Text("")),
              const SizedBox(
                width: 10,
              ),
              OutlinedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black)),
                  onPressed: () {
                    setState(() => textSelected = Colors.black);
                    widget.prefs.setInt('textColorSelect', textSelected.value);
                  },
                  child: const Text("")),
            ],
          ),
          const SizedBox(
            height: 100,
          ),
          Row(
            children: [
              const Text("unselected color :     "),
              OutlinedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(colorUnselect)),
                  onPressed: () {
                    _showDialog("colorUnselect");
                  },
                  child: const Text("")),
            ],
          ),
          Row(
            children: [
              const Text("unselected text color :     "),
              OutlinedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white)),
                  onPressed: () {
                    setState(() => textUnselected = Colors.white);
                    widget.prefs.setInt('textColorUnselect', textUnselected.value);
                  },
                  child: const Text("")),
              const SizedBox(
                width: 10,
              ),
              OutlinedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black)),
                  onPressed: () {
                    setState(() => textUnselected = Colors.black);
                    widget.prefs.setInt('textColorUnselect', textUnselected.value);
                  },
                  child: const Text("")),
            ],
          ),
          const SizedBox(
            height: 100,
          ),
          const Text("Preview :"),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment:MainAxisAlignment.center,
            children: [
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
                  style: TextStyle(fontSize: 48, color: textUnselected)))
           ],
          ),
        ]));
  }
}
