import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:flutter/material.dart';
import 'pauseScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  late Color unselected;
  late Color selected;
  late Color textunselected;
  late Color textselected;

  @override
  initState() {
    unselected =
        Color(widget.prefs.getInt('colorUnselect') ?? Colors.black.value);
    selected = Color(widget.prefs.getInt('colorSelect') ??
        const Color.fromARGB(255, 252, 179, 51).value);

    textunselected =
        Color(widget.prefs.getInt('textColorUnselect') ?? Colors.white.value);
    textselected =
        Color(widget.prefs.getInt('textColorSelect') ?? Colors.black.value);
  }

  void reset() {
    bingo.clear();
    selectedIndex.clear();
    verif = false;
    setState(() {});
  }

  void setButton(index, context) {
    if (selectedIndex.contains(index)) {
      selectedIndex.remove(index);
    } else {
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
                    width: screenWidth * 0.7,
                    child: GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 10,
                        mainAxisExtent: screenHeight * 0.09,
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
                                    ? selected
                                    : unselected,
                                shadowColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(500),
                                ),
                              ),
                              child: Text('${i + 1}',
                                  style: TextStyle(
                                      fontSize: 48,
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
