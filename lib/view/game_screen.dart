import 'package:bingo/view/pause_screen.dart';
import 'package:bingo/widget/game_carrousel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:confetti/confetti.dart';
import '../style/style.dart' as s;
import 'dart:math' as math;

class GameScreen extends StatefulWidget {
  final SharedPreferences prefs;
  const GameScreen({super.key, required this.prefs});

  @override
  State<GameScreen> createState() => _GameScreen();
}

class _GameScreen extends State<GameScreen> {
  List<int> selectedIndex = [];
  List<int> bingo = [];
  bool verif = false;
  bool isHover = false;
  ConfettiController confettiController = ConfettiController();
  late Color unselected;
  late Color selected;
  late Color textunselected;
  late Color textselected;
  late String mode;
  late Color hovercolor;
  static const dropItems = ["jeu", "1 ligne", "2 lignes", "bingo"];
  String dropValue = "jeu";

  @override
  initState() {
    super.initState();
    mode = widget.prefs.getString('mode') ?? "libre";
    hovercolor = Colors.transparent;
    unselected =
        Color(widget.prefs.getInt('colorUnselect') ?? Colors.black.value);
    selected = Color(widget.prefs.getInt('colorSelect') ??
        const Color.fromARGB(255, 252, 178, 51).value);
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

  void showBingo(String str) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: const Color.fromARGB(200, 0, 0, 0),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
            side: BorderSide(
                color: Color.fromARGB(255, 252, 178, 51), width: 2.0)),
        content: SizedBox(
          height: 200,
          child: Stack(alignment: AlignmentDirectional.center, children: [
            Row(
              children: [
                Transform.rotate(
                  angle: math.pi / 180 * 275,
                  child: const Image(
                    image: AssetImage('assets/party.png'),
                    fit: BoxFit.cover,
                    width: 170,
                  ),
                ),
                Text(
                  str,
                  style: const TextStyle(
                      fontSize: 100, color: Color.fromARGB(255, 252, 178, 51)),
                ),
                const Image(
                  image: AssetImage('assets/party.png'),
                  fit: BoxFit.cover,
                  width: 170,
                ),
              ],
            ),
          ]),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: <Widget>[
          OutlinedButton(
            onPressed: () {
              Navigator.pop(context, 'fermer');
              confettiController.stop();
            },
            child: const Text(
              'fermer',
              style: TextStyle(color: Color.fromARGB(255, 252, 178, 51)),
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
        if (bingo.length == 5 && dropValue == "1 ligne") {
          showBingo("1 Ligne");
          confettiController.play();
        } else if (bingo.length == 10 && dropValue == "2 lignes") {
          showBingo("2 Lignes");
          confettiController.play();
        } else if (bingo.length == 15 && dropValue == "bingo") {
          showBingo("Bingo");
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
        return Colors.red;
      } else if (selectedIndex.contains(index)) {
        return selected;
      } else {
        return unselected;
      }
    } else {
      if (selectedIndex.contains(index)) {
        return selected;
      } else {
        return unselected;
      }
    }
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          textAlign: TextAlign.end,
          style: const TextStyle(fontSize: 22, color: Colors.black),
        ),
      );

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
                Color(0xffD7DDE8),
                Color.fromARGB(255, 152, 136, 93),
              ],
            )),
            alignment: Alignment.center,
            child: Row(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: screenHeight * 0.45,
                      child: Column(
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
                                        fontSize: 20, color: Colors.black),
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
                                            PauseScreen(prefs: widget.prefs),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "Pause",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  ))),
                          const SizedBox(height: 10),
                          mode == "normal"
                              ? Container(
                                  padding: const EdgeInsetsDirectional.only(
                                      start: 30),
                                  height: 40,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      color: hovercolor,
                                      border: Border.all(
                                          color: Colors.black, width: 2),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20))),
                                  child: DropdownButton<String>(
                                    underline: Container(
                                      height: 0,
                                    ),
                                    icon: const Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.black,
                                    ),
                                    items:
                                        dropItems.map(buildMenuItem).toList(),
                                    value: dropValue,
                                    onChanged: (value) => setState(() {
                                      if (value != null) {
                                        dropValue = value;
                                        if (value == "jeu") {
                                          verif = false;
                                          bingo.clear();
                                        } else {
                                          verif = true;
                                        }
                                      }
                                    }),
                                  ))
                              : const SizedBox(
                                  width: 0,
                                ),
                          SizedBox(height: screenHeight * 0.01),
                          SizedBox(
                              height: 40,
                              width: 150,
                              child: OutlinedButton.icon(
                                  icon: const Icon(
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
                                        fontSize: 20, color: Colors.black),
                                  ))),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.55,
                      width: 170,
                      child: GameCarouselWidget(prefs: widget.prefs),
                    )
                  ],
                ),
                SizedBox(width: screenWidth * 0.04),
                SizedBox(
                    // size de la grille
                    width: screenWidth * 0.8,
                    child: GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 10,
                        mainAxisExtent: screenHeight * 0.1,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      children: List<Widget>.generate(90, (int i) {
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
              ],
            )));
  }
}
