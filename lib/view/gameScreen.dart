import 'dart:math';

import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:flutter/material.dart';
import 'pauseScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:confetti/confetti.dart';

class GameScreen extends StatefulWidget {
  final SharedPreferences prefs;
  GameScreen({super.key, required this.prefs});

  @override
  State<GameScreen> createState() => _GameScreen();
}

class _GameScreen extends State<GameScreen> {
  List<int> selectedIndex = [];
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  List<int> bingo = [];
  bool verif = false;
  bool isHover = false;
  ConfettiController confettiController = ConfettiController();
  late Color unselected;
  late Color selected;
  late Color textunselected;
  late Color textselected;
  late String mode;
  late bool checkboxValue;

  @override
  initState() {
    mode = widget.prefs.getString('mode') ?? "libre";
    checkboxValue = false;
    unselected =
        Color(widget.prefs.getInt('colorUnselect') ?? Colors.black.value);
    selected = Color(widget.prefs.getInt('colorSelect') ??
        const Color.fromARGB(255, 252, 179, 51).value);
    textunselected =
        Color(widget.prefs.getInt('textColorUnselect') ?? Colors.white.value);
    textselected =
        Color(widget.prefs.getInt('textColorSelect') ?? Colors.black.value);
  }
  @override
  void dispose() {
    confettiController.dispose();
    super.dispose();
  }

  void reset() {
    bingo.clear();
    selectedIndex.clear();
    verif = false;
    setState(() {});
  }

  void showBingo() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
        content: Stack(alignment: AlignmentDirectional.center, children: [
          Row(
            children: const [
              Image(
                image: AssetImage('assets/party.png'),
                fit: BoxFit.cover,
                width: 170,
              ),
              Text(
                'Bingo',
                style: TextStyle(fontSize: 100),
              ),
              Image(
                image: AssetImage('assets/party.png'),
                fit: BoxFit.cover,
                width: 170,
              ),
            ],
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: ConfettiWidget(
                confettiController: confettiController,
                numberOfParticles: 50,
                emissionFrequency: 0.01,
                shouldLoop: true,
                blastDirection: 7 * pi / 6,
                child: const SizedBox(
                  width: 0,
                ),
              )),
          Align(
              alignment: Alignment.centerRight,
              child: ConfettiWidget(
                confettiController: confettiController,
                numberOfParticles: 50,
                emissionFrequency: 0.01,
                shouldLoop: true,
                blastDirection: 11 * pi / 6,
                child: const SizedBox(
                  width: 0,
                ),
              )),
        ]),
        actionsAlignment: MainAxisAlignment.center,
        actions: <Widget>[
          OutlinedButton(
            onPressed: () {
              Navigator.pop(context, 'fermer');
              confettiController.stop();
            },
            child: const Text(
              'fermer',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  void setButton(index, context) {
    if (verif == true) {
      if (bingo.contains(index)) {
        bingo.remove(index);
      } else if (selectedIndex.contains(index)) {
        bingo.add(index);
        if (bingo.length == 5) {
          showBingo();
          confettiController.play();
        }
      }
    } else {
      if (selectedIndex.contains(index)) {
        selectedIndex.remove(index);
      } else {
        selectedIndex.add(index);
      }
    }
    setState(() {});
  }

  Color colorButton(index) {
    if (verif == true) {
      if (bingo.contains(index)) {
        return Colors.red; // select
      } else if (selectedIndex.contains(index)) {
        return selected; // verif
      }
    } else {
      if (selectedIndex.contains(index)) {
        return selected; // unselect
      } else {
        return unselected; //select
      }
    }
    return Colors.black; // pitier jamais la
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
                // Align(alignment: Alignment.topCenter,child:ConfettiWidget(confettiController: confettiController, shouldLoop: true,child: const SizedBox(width: 0,),)),
                AnimatedContainer(
                  height: double.infinity,
                  width: !(isHover) ? 50 : 200,
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.only(right: 10),
                  child: Container(
                    color: Colors.grey,
                    child: InkWell(
                      onTap: () {},
                      child: !(isHover)
                          ? const SizedBox()
                          : Column(
                              children: [
                                const SizedBox(height: 10),
                                const Image(
                                  image: AssetImage('assets/logo_caserne.png'),
                                  fit: BoxFit.cover,
                                  width: 170,
                                ),
                                const SizedBox(height: 10),
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
                                const SizedBox(height: 10),
                                AnimatedButton(
                                  height: 40,
                                  width: 150,
                                  text: "Pause",
                                  onPress: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PauseScreen(prefs: widget.prefs),
                                      ),
                                    );
                                  },
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
                                InkWell(
                                  onTap: () {
                                    print(verif);
                                    setState(() {
                                      if (verif) {
                                        verif = false;
                                        checkboxValue = false;
                                      } else {
                                        verif = true;
                                        checkboxValue = true;
                                      }
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 150,
                                    decoration:
                                        BoxDecoration(border: Border.all(color: Colors.white,width: 2),borderRadius: const BorderRadius.all(Radius.circular(20))),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Checkbox(
                                          value: checkboxValue,
                                          onChanged: null,
                                        ),
                                        const Text("Verif", style: TextStyle(fontSize: 20, color: Colors.white),)
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 580),
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
                                ),
                              ],
                            ),
                      onHover: (val) {
                        setState(() {
                          isHover = val;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.1),
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
                                backgroundColor: colorButton(i),
                                shadowColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(500),
                                ),
                              ),
                              child: Text('${i + 1}',
                                  style: TextStyle(
                                      fontSize: screenWidth * 0.028, //55,
                                      color: selectedIndex.contains(i)
                                          ? textselected
                                          : textunselected)));
                        });
                      }),
                    )),
                // Align(alignment: Alignment.topCenter,child:ConfettiWidget(confettiController: confettiController, shouldLoop: true,child: const SizedBox(width: 0,),)),
                //  Align(alignment: Alignment.bottomLeft,child:ConfettiWidget(confettiController: confettiController, shouldLoop: true,child: const SizedBox(width: 0,),)),
              ],
            )));
  }
}
