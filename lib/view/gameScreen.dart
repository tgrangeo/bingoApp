import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreen();
}

class _GameScreen extends State<GameScreen> {
  List<int> selectedIndex = [];

  List<int> bingo = [];
  Color blue = Color.fromARGB(255, 140, 198, 213);
  Color green = Colors.green;
  bool verif = false;
  Icon iconVerif = const Icon(Icons.verified_outlined, size: 100);

  void reset() {
    bingo.clear();
    selectedIndex.clear();
    verif = false;
    iconVerif = const Icon(Icons.verified_outlined, size: 100);
    setState(() {});
  }

  void checkBingo(context) {
    if (bingo.length >= 5) {
      showDialog(
          context: context,
          builder: ((context) => Dialog(
                  child: Container(
                  width: 600,
                  height: 200,
                child: Column(
                  children: [
                  const Text(
                    "BINGO",
                    style: TextStyle(fontSize: 100),
                  ),
                  OutlinedButton(
                      onPressed: () {
                        reset();
                        Navigator.pop(context);
                      },
                      child: const Text("close"))
                ]),
              ))));
    }
  }

  void setButton(index, context) {
    if (selectedIndex.contains(index)) {
      if (verif == true) {
        bingo.add(index);
        checkBingo(context);
        print(bingo);
      } else {
        selectedIndex.remove(index);
      }
    } else if (verif == false) {
      selectedIndex.add(index);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Container(
            color: Color.fromARGB(255, 66, 66, 66),
            alignment: Alignment.center,
            child: Row(
              children: [
                Container(
                    // size de la grille
                    width: screenWidth * 0.8,
                    child: GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 11,
                        mainAxisExtent: screenHeight * 0.1,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      children: List<Widget>.generate(99, (int i) {
                        return Builder(builder: (BuildContext context) {
                          return ElevatedButton(
                              onPressed: () {
                                setButton(i, context);
                              },
                              style: OutlinedButton.styleFrom(
                                backgroundColor: selectedIndex.contains(i)
                                    ? verif
                                        ? bingo.contains(i)
                                            ? Colors.red
                                            : green
                                        : green
                                    : blue,
                                shadowColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(500),
                                  // side: BorderSide(color: Color.fromARGB(255, 89, 99, 244))
                                ),
                              ),
                              child: Text('${i + 1}',
                                  style: const TextStyle(fontSize: 48)));
                        });
                      }),
                    )),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      if (verif == false) {
                        verif = true;
                        iconVerif = const Icon(Icons.verified, size: 100);
                      } else {
                        iconVerif =
                            const Icon(Icons.verified_outlined, size: 100);
                        verif = false;
                      }
                      print(verif);
                    });
                  },
                  child: iconVerif,
                ),
                OutlinedButton(
                    onPressed: () {
                      reset();
                    },
                    child: const Text("reset"))
              ],
            )));
  }
}
