import 'package:flutter/material.dart';
import 'package:habit_tracker/view/screens/habbit_detailpage.dart';
import 'package:habit_tracker/view/screens/homepage.dart';
import 'package:habit_tracker/view/screens/splash_screen.dart';
import 'package:habit_tracker/view/screens/timer.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      '/': (context) => SplashScreen(),
      'home': (context) => HomePage(),
      'habbit_detail': (context) => HabbitDetailpage(),
      'habbit_timer': (context) => HabitTimerPage(),
    },
  ));
}
