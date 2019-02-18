import 'package:flutter/material.dart';
import 'timerConfigWidget/timerConfigWidget.dart';
import 'timerScreen.dart';
import 'package:flutter/services.dart';
import 'dart:async';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runZoned<Future<Null>>(() async {
      runApp(new MyApp());
    });
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        accentColor: Colors.yellowAccent[400],
        cursorColor: Colors.yellow[700],
        primaryColor: Colors.yellow[500],
        primaryColorDark: Colors.yellow[700],
        buttonColor: Colors.yellow[500],
      ),
      home: MyHomePage(title: 'Фитнес таймер'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TimerConfigWidget _timerConfigWidget;

  void _startTimer() {
    var _timerConfig = _timerConfigWidget.getTimerSettings();
    print(_timerConfig);
    Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => new TimerScreen(timerConfig: _timerConfig)),
    );
  }

  @override
  void initState() {
    super.initState();
    _timerConfigWidget = TimerConfigWidget();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _timerConfigWidget,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Старт', // used by assistive technologies
        child: Icon(Icons.play_arrow),
        onPressed: _startTimer,
      ),
    );
  }
}
