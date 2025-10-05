import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:audioplayers/audioplayers.dart';

class ScaleSize {
  static double textScaleFactor(BuildContext context,
      {double maxTextScaleFactor = 2}) {
    final width = MediaQuery.of(context).size.width;
    double val = (width / 1400) * maxTextScaleFactor;
    return max(1, min(val, maxTextScaleFactor));
  }
}

class StopWatchTimerPage extends StatefulWidget {
  final SharedPreferences prefs;
  const StopWatchTimerPage({super.key, required this.prefs});
  @override
  StopWatchTimerPageState createState() => StopWatchTimerPageState();
}

class StopWatchTimerPageState extends State<StopWatchTimerPage> {
  static late Duration countdownDuration;
  Duration duration = const Duration();
  Timer? timer;
  bool countDown = true;
  // final player = AudioPlayer();

  @override
  void initState() {
    countdownDuration = Duration(
        hours: widget.prefs.getInt('hours') ?? 0,
        minutes: widget.prefs.getInt('minutes') ?? 0,
        seconds: widget.prefs.getInt('secondes') ?? 0);
    super.initState();
    reset();
    startTimer();
  }

  @override
  void dispose() {
    // player.dispose();
    super.dispose();
  }

  void playSong() async {
    if (duration.inSeconds == 127) {
      // var isSong = widget.prefs.getBool('pauseSong');
      // if (isSong == true) {
      //   await player.setSource(AssetSource('pause_song.mp3'));
      //   await player.resume();
      // }
    }
  }

  void reset() {
    if (countDown) {
      setState(() => duration = countdownDuration);
    } else {
      setState(() => duration = const Duration());
    }
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  void addTime() {
    final addSeconds = countDown ? -1 : 1;
    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      if (seconds < 0) {
        timer?.cancel();
      } else {
        duration = Duration(seconds: seconds);
        playSong();
      }
    });
  }

  // void stopTimer({bool resets = true}) {
  //   if (resets) {
  //     reset();
  //   }
  //   setState(() => timer?.cancel());
  // }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildTime(),
        ],
      );

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      buildTimeCard(time: hours, header: 'HEURES'),
      const SizedBox(
        width: 8,
      ),
      buildTimeCard(time: minutes, header: 'MINUTES'),
      const SizedBox(
        width: 8,
      ),
      buildTimeCard(time: seconds, header: 'SECONDES'),
    ]);
  }

  Widget buildTimeCard({required String time, required String header}) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
              color: const Color.fromARGB(122, 228, 231, 234),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              elevation: 20,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  time,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.width * 0.13),
                ),
              )),
          const SizedBox(
            height: 24,
          ),
          Text(header,
              style: TextStyle(
                  color: Colors.black45,
                  fontSize: MediaQuery.of(context).size.width * 0.018)),
        ],
      );
}
