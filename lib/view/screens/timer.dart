import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HabitTimerPage extends StatefulWidget {
  @override
  _HabitTimerPageState createState() => _HabitTimerPageState();
}

class _HabitTimerPageState extends State<HabitTimerPage> {
  double progressValue = 0.0;
  int totalTimeInSeconds = 0;
  int remainingTimeInSeconds = 0;

  @override
  void initState() {
    super.initState();

    startTimer();
  }

  void startTimer() {
    Future.delayed(Duration(seconds: 1), () {
      if (remainingTimeInSeconds > 0) {
        setState(() {
          remainingTimeInSeconds--;
          progressValue = (totalTimeInSeconds - remainingTimeInSeconds) /
              totalTimeInSeconds;
        });
        startTimer();
      }
    });
  }

  String formatTime(int totalSeconds) {
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String habitName = args['habitName'];

    remainingTimeInSeconds = totalTimeInSeconds;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black54),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          habitName, // Dynamic habit name
          style: GoogleFonts.getFont('Mulish',
              textStyle: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.greenAccent.withOpacity(0.2),
                  child:
                      Icon(Icons.self_improvement, color: Colors.greenAccent),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      habitName,
                      style: GoogleFonts.getFont('Mulish',
                          textStyle: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    Text(
                      "${(totalTimeInSeconds ~/ 60)} minute",
                      style: GoogleFonts.getFont('Mulish',
                          textStyle:
                              TextStyle(fontSize: 14, color: Colors.black54)),
                    ),
                  ],
                )
              ],
            ),
          ),

          // Circular Timer
          CircularPercentIndicator(
            radius: 150.0,
            lineWidth: 15.0,
            percent: progressValue,
            center: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  formatTime(remainingTimeInSeconds),
                  style: GoogleFonts.getFont('Mulish',
                      textStyle:
                          TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: 8),
                Text(
                  "${(totalTimeInSeconds ~/ 60)} minute",
                  style: GoogleFonts.getFont('Mulish',
                      textStyle:
                          TextStyle(fontSize: 14, color: Colors.black54)),
                ),
              ],
            ),
            progressColor: Colors.greenAccent,
            backgroundColor: Colors.grey.shade300,
            circularStrokeCap: CircularStrokeCap.round,
          ),

          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                iconSize: 40,
                icon: Icon(Icons.refresh, color: Colors.blue),
                onPressed: () {
                  setState(() {
                    remainingTimeInSeconds = totalTimeInSeconds;
                    progressValue = 0.0;
                    startTimer();
                  });
                },
              ),
              FloatingActionButton(
                onPressed: () {},
                child: Icon(Icons.pause, color: Colors.white),
                backgroundColor: Colors.blue,
              ),
              IconButton(
                iconSize: 40,
                icon: Icon(Icons.check, color: Colors.blue),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
