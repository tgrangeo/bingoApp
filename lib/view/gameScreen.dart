import 'dart:math';

import 'package:bingo/view/pauseScreen.dart';
import 'package:flutter/material.dart';
import 'pauseScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:confetti/confetti.dart';
import '../style/style.dart' as s;
import 'dart:math' as math;

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
  late Color hovercolor;

  @override
  initState() {
    mode = widget.prefs.getString('mode') ?? "libre";
    checkboxValue = false;
    hovercolor = Colors.transparent;
    unselected =
        Color(widget.prefs.getInt('colorUnselect') ?? Colors.black.value);
    selected = Color(widget.prefs.getInt('colorSelect') ??
        Color.fromARGB(255, 252, 178, 51).value);
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
        backgroundColor: s.Style.grey,
        body: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xffD7DDE8), // (144, 144, 144, 1),
                Color.fromARGB(255, 152, 136, 93),
                // Color(0xff757F9A),
                // const Color.fromARGB(255, 252, 179, 51),
              ],
            )),
            alignment: Alignment.center,
            child: Row(
              children: [
                AnimatedContainer(
                  height: double.infinity,
                  width: !(isHover) ? 70 : 200,
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.only(right: 10),
                  child: Container(
                    // decoration: const BoxDecoration(
                    //     gradient: LinearGradient(
                    //   begin: Alignment.topCenter,
                    //   end: Alignment.bottomCenter,
                    //   colors: [
                    //     // Color.fromARGB(
                    //     //   255, 102, 104, 108), // (144, 144, 144, 1),
                    //     Color(0xffFCB233),
                    //     Color(0xffd3d3d3),
                    //     // Color(0xff757F9A),
                    //     // const Color.fromARGB(255, 252, 179, 51),
                    //   ],
                    // )),
                    child: InkWell(
                      onTap: () {},
                      child: !(isHover)
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Transform.rotate(
                                    angle: math.pi / 180 * 180,
                                    alignment: Alignment.center,
                                    child: const Icon(Icons.menu_open, size: 42,))
                              ],
                            ) //const SizedBox()
                          : Column(
                              children: [
                                const SizedBox(height: 10),
                                const Image(
                                  image: AssetImage('assets/logo_caserne.png'),
                                  fit: BoxFit.cover,
                                  width: 170,
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                    height: 40,
                                    width: 150,
                                    child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0)),
                                          side: const BorderSide(
                                              color: Colors.black, width: 2),
                                        ),
                                        onPressed: reset,
                                        child: const Text(
                                          "Reset",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black),
                                        ))),
                                const SizedBox(height: 10),
                                SizedBox(
                                    height: 40,
                                    width: 150,
                                    child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0)),
                                          side: const BorderSide(
                                              color: Colors.black, width: 2),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PauseScreen(
                                                      prefs: widget.prefs),
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          "Pause",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black),
                                        ))),
                                const SizedBox(height: 10),
                                InkWell(
                                  onHover: ((value) {
                                    // if (value == true) {
                                    //   hovercolor = Colors.grey[200]!;
                                    // } else {
                                    //   hovercolor = Colors.transparent;
                                    // }
                                    setState(() {});
                                  }),
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
                                  child: mode == "normal"
                                      ? Container(
                                          height: 40,
                                          width: 150,
                                          decoration: BoxDecoration(
                                              color: hovercolor,
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 2),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(20))),
                                          child: Row(
                                            children: [
                                              const SizedBox(width: 25),
                                              Checkbox(
                                                fillColor:
                                                    MaterialStateProperty.all(
                                                        Colors.black),
                                                checkColor: s.Style.yellow,
                                                value: checkboxValue,
                                                onChanged: null,
                                              ),
                                              const SizedBox(width: 3),
                                              const Text(
                                                "Verif",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black),
                                              )
                                            ],
                                          ))
                                      : const SizedBox(
                                          width: 0,
                                        ),
                                ),
                                SizedBox(height: screenHeight * 0.6),
                                SizedBox(
                                    height: 40,
                                    width: 150,
                                    child: OutlinedButton.icon(
                                        icon: Icon(
                                          Icons.arrow_back,
                                          color: Colors.black,
                                        ),
                                        style: OutlinedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0)),
                                          side: const BorderSide(
                                              color: Colors.black, width: 2),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        label: const Text(
                                          "Back",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black),
                                        ))),
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
                SizedBox(width: screenWidth * 0.08),
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
