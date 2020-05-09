import 'package:flutter/material.dart';
import 'package:fluttertimer/pages/timer_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Timer',
      theme: ThemeData.dark(),
      home: TimerPage(),
    );
  }
}
