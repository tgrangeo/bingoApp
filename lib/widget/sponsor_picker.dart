import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SponsorPicker extends StatefulWidget {
  final SharedPreferences prefs;
  const SponsorPicker({super.key,required this.prefs});
  @override
  _SponsorPicker createState() => _SponsorPicker();
}

class _SponsorPicker extends State<SponsorPicker> {
  pickFile() async {
    //TODO:allow restriction png jpg etc...
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();
      List<String> pathList = [];
      for (int i = 0; i < files.length; i++) {
        pathList.add(files[i].path);
      }
      widget.prefs.setStringList('imgList', pathList);
    } else {
      print("cancel");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OutlinedButton(
            onPressed: (() {
              pickFile();
            }),
            child: const Text("Pick")),
        const Text("WIPpicker"),
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }
}
