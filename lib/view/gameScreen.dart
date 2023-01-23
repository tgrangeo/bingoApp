import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreen();
}

class _GameScreen extends State<GameScreen> {
  List<int> selectedIndex = [];
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  List<int> bingo = [];
  Color blue = Colors.grey;
  Color green = Colors.green;
  bool verif = false;
  bool isHover = false;

  void reset() {
    bingo.clear();
    selectedIndex.clear();
    verif = false;
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
                child: Column(children: [
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
        if (bingo.contains(index) == false) {
          bingo.add(index);
        }
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

  void setVerif() {
    setState(() {
      if (verif == false) {
        verif = true;
      } else {
        verif = false;
      }
      print(verif);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Container(
            //color: Color.fromARGB(255, 66, 66, 66),
            alignment: Alignment.center,
            child: Row(
              children: [
                AnimatedContainer(
                  height: double.infinity,
                  width: !(isHover) ? 50 : 200,
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.only(right: 10),
                  child: Container(
                    //height: 30,
                    color: Colors.grey,
                    child: InkWell(
                      onTap: () {},
                      child: !(isHover)
                          ? const SizedBox()
                          : Column(
                              children: [
                                const SizedBox(height: 10),
                                const Image(
                                    image: AssetImage('assets/ol.png'),
                                    fit: BoxFit.cover,
                                    width: 170,),
                                const SizedBox(height: 10),
                                AnimatedButton(
                                  height: 40,
                                  width: 150,
                                  text: "Bingo",
                                  onPress: setVerif,
                                  isReverse: true,
                                  selectedTextColor: Colors.black,
                                  animatedOn: AnimatedOn.onHover,
                                  transitionType: TransitionType.LEFT_TO_RIGHT,
                                  backgroundColor: Colors.grey,
                                  borderColor: Colors.white,
                                  borderRadius: 20,
                                  borderWidth: 2,
                                ),
                                const SizedBox(height: 10),
                                AnimatedButton(
                                  height: 40,
                                  width: 150,
                                  text: "Reset",
                                  onPress: reset,
                                  isReverse: true,
                                  selectedTextColor: Colors.black,
                                  animatedOn: AnimatedOn.onHover,
                                  transitionType: TransitionType.LEFT_TO_RIGHT,
                                  backgroundColor: Colors.grey,
                                  borderColor: Colors.white,
                                  borderRadius: 20,
                                  borderWidth: 2,
                                ),
                                const SizedBox(height: 420),
                                AnimatedButton(
                                  height: 40,
                                  width: 150,
                                  text: "Back",
                                  onPress: () {
                                    Navigator.of(context).pop();
                                  },
                                  isReverse: true,
                                  selectedTextColor: Colors.black,
                                  animatedOn: AnimatedOn.onHover,
                                  transitionType: TransitionType.LEFT_TO_RIGHT,
                                  backgroundColor: Colors.grey,
                                  borderColor: Colors.white,
                                  borderRadius: 20,
                                  borderWidth: 2,
                                )
                                //DrawerButton(context: context, tt: "reset", onPress: reset())
                              ],
                            ),
                      //!(isHover) ? Text("Hover") : Text("Button"),
                      onHover: (val) {
                        setState(() {
                          isHover = val;
                        });
                      },
                    ),
                  ),
                ),
                Container(
                    // size de la grille
                    width: screenWidth * 0.8,
                    child: GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 10,
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
                                  style: const TextStyle(fontSize: 48, color: Colors.white)));
                        });
                      }),
                    )),
              ],
            )));
  }
}
