import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SponsorPicker extends StatefulWidget {
  final SharedPreferences prefs;
  const SponsorPicker({super.key, required this.prefs});
  @override
  _SponsorPicker createState() => _SponsorPicker();
}

class _SponsorPicker extends State<SponsorPicker> {
  List<String> pathList = [];

  pickFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true, allowedExtensions: ['jpg', 'png'],);
    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();
      for (int i = 0; i < files.length; i++) {
        print(files[i].path);
        if (files[i].path.split('.').last == 'png' || pathList[i].split('.').last == 'jpg'){ // check cause allowed extension don't seems to work
          pathList.add(files[i].path);
        }
      }
      widget.prefs.setStringList('imgList', pathList);
      setState(() {});
    } else {
      print("cancel");
    }
  }

  deletePath(int i) {
    print(i);
    pathList.removeAt(i);
    widget.prefs.setStringList('imgList', pathList);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Sponsor",style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
        ),),
        pathList.isNotEmpty
           ?
        Container(
            alignment: Alignment.center,
            height: 200,
            width:400,
            child: ListView.separated(
              padding: const EdgeInsets.all(20.0),
              itemCount: pathList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    height: 50,
                    color: Color.fromARGB(255, 47, 206, 206),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child: Text(pathList[index].split('/').last)),
                        IconButton(
                            onPressed:() {
                              deletePath(index);
                            },
                            icon: const Icon(Icons.delete))
                      ],
                    ) 
                    );
              
              },
              separatorBuilder: (BuildContext context, int index) =>
              const SizedBox(height: 10,),
            )):Text("no sponsor please add one"),
        OutlinedButton(
            onPressed: (() {
              pickFile();
            }),
            child: const Text("add")),
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }
}
