import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'button_widget.dart';

class ScaleSize {
  static double textScaleFactor(BuildContext context, {double maxTextScaleFactor = 2}) {
    final width = MediaQuery.of(context).size.width;
    double val = (width / 1400) * maxTextScaleFactor;
    return max(1, min(val, maxTextScaleFactor));
  }
}

class StopWatchTimerPage extends StatefulWidget {
  @override
  _StopWatchTimerPageState createState() => _StopWatchTimerPageState();
}

class _StopWatchTimerPageState extends State<StopWatchTimerPage> {
  static const countdownDuration = Duration(minutes: 1);
  Duration duration = const Duration();
  Timer? timer;

  bool countDown = true;

  @override
  void initState() {
    super.initState();
    reset();
    startTimer();
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
          // const SizedBox(
          //   height: 80,
          // ),
          // buildButtons()
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
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Color.fromARGB(215, 224, 224, 224),
                borderRadius: BorderRadius.circular(20)),
            child: Text(
              time,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.width * 0.13),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Text(header, style: TextStyle(color: Colors.black45, fontSize: MediaQuery.of(context).size.width * 0.018)),
        ],
      );

  // Widget buildButtons() {
  //   final isRunning = timer == null ? false : timer!.isActive;
  //   final isCompleted = duration.inSeconds == 0;
  //   return isRunning || isCompleted
  //       ? Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             ButtonWidget(
  //                 text: 'STOP',
  //                 onClicked: () {
  //                   if (isRunning) {
  //                     stopTimer(resets: false);
  //                   }
  //                 }),
  //             const SizedBox(
  //               width: 12,
  //             ),
  //             ButtonWidget(text: "CANCEL", onClicked: stopTimer),
  //           ],
  //         )
  //       : ButtonWidget(
  //           text: "Start Timer!",
  //           color: Colors.black,
  //           backgroundColor: Colors.white,
  //           onClicked: () {
  //             startTimer();
  //           });
  // }
}
