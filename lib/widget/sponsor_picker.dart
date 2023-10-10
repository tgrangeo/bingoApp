import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SponsorPicker extends StatefulWidget {
  final SharedPreferences prefs;
  const SponsorPicker({super.key, required this.prefs});
  @override
  SponsorPickerState createState() => SponsorPickerState();
}

class SponsorPickerState extends State<SponsorPicker> {
  late List<String> pathList;

  @override
  void initState() {
    super.initState();
    // List<String>? imgList = widget.prefs.getStringList('imgList');
    // if (imgList != null) {
    //   pathList = imgList;
    // } else {
    // Si la valeur est null, initialisez pathList comme une nouvelle liste vide.
    pathList = [];
    // }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      allowedExtensions: ['jpg', 'png', 'jpeg', 'svg'],
    );
    if (result != null && result.paths.isNotEmpty) {
      List<File> files = result.paths.map((path) => File(path!)).toList();
      for (int i = 0; i < files.length; i++) {
        if (['png', 'jpg', 'jpeg', 'svg']
            .contains(files[i].path.split('.').last.toLowerCase())) {
          pathList.add(files[i].path);
        }
      }
      widget.prefs.setStringList('imgList', pathList);
      setState(() {});
      // ignore: use_build_context_synchronously
      // Navigator.of(context).pop();
    }
    // else {
    //   // Handle the cancel action properly
    //   print("Canceled file selection");
    // }
  }

  deletePath(int i) {
    pathList.removeAt(i);
    widget.prefs.setStringList('imgList', pathList);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 20,
        color: const Color.fromARGB(160, 228, 231, 234),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Sponsor",
              style: TextStyle(
                fontSize: 33,
                fontWeight: FontWeight.bold,
              ),
            ),
            pathList.isNotEmpty
                ? Expanded(
                    child: ListView.separated(
                    padding: const EdgeInsets.all(20.0),
                    itemCount: pathList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          height: 50,
                          padding: const EdgeInsets.only(right: 15, left: 15),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 2,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                  child: Text(
                                pathList[index].split('/').last,
                                style: const TextStyle(fontSize: 22),
                              )),
                              const Expanded(child: SizedBox()),
                              IconButton(
                                  iconSize: 30,
                                  onPressed: () {
                                    deletePath(index);
                                  },
                                  icon: Icon(
                                    Icons.close,
                                    color: Colors.red[700],
                                  ))
                            ],
                          ));
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                      height: 10,
                    ),
                  ))
                : const Expanded(
                    child: Align(
                        alignment: Alignment.center,
                        child: Text("no sponsor please add one"))),
            const SizedBox(
              height: 10,
            ),
            OutlinedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black),
                padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.all(20)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0))),
              ),
              onPressed: () {
                pickFile();
              },
              child: const Text(
                "Ajouter",
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ));
  }
}
