import 'package:flutter/material.dart';

class TimerPage extends StatefulWidget {
  TimerPage({Key key}) : super(key: key);

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  String get timerString {
    Duration duration = controller.value == 0
        ? controller.duration
        : controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(minutes: 2, seconds: 10),
    );
    controller.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Time is up!"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Timer"),
      ),
      body: Stack(children: <Widget>[
        Positioned.fill(
          child: Center(
            child: FlatButton(
              onPressed: () {
                controller.reverse(
                    from: controller.value == 0.0 ? 1.0 : controller.value);
              },
              child: AnimatedBuilder(
                  animation: controller,
                  builder: (BuildContext context, Widget child) {
                    return Text(
                      timerString,
                      style: themeData.textTheme.display4,
                    );
                  }),
            ),
          ),
        ),
      ]),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
