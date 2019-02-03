import 'package:flutter/material.dart';
import 'config.dart';
import 'timerConfigWidget/timerConfigWidget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        accentColor: Colors.purpleAccent[400],
        cursorColor: Colors.purple[700],
        primaryColor: Colors.purple[500],
        primaryColorDark: Colors.purple[700],
        buttonColor: Colors.purple[500],
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  Color _scaffordColor = Colors.white;
  final Config _appConfig = new Config();
  TimerConfigWidget _timerConfigWidget;

  void _getScaffordColor() {
    _appConfig.getConfig(isDarkThemeKey).then((value) {
      var colorValue = Colors.white;
      if (value == 'true') {
        colorValue = Colors.black;
      }
      setState(() {
        _scaffordColor = colorValue;
      });
    });
  }

  void _startTimer() {
    print(_timerConfigWidget.getTimerSettings());
  }
  @override
  void initState() {
    _appConfig.setConfig(isDarkThemeKey, 'false');
    _getScaffordColor();
    _timerConfigWidget = TimerConfigWidget();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _scaffordColor,
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
