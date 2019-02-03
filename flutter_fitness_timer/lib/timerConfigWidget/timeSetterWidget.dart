import 'package:flutter/material.dart';
import 'package:flutter_fitness_timer/config.dart';

class TimeSetterWidget extends StatefulWidget {
  TimeSetterWidget({Key key, this.title, this.onChangeCallback})
      : super(key: key);
  final String title;
  Function onChangeCallback;

  @override
  _TimeSetterWidgetState createState() => _TimeSetterWidgetState();
}

class _TimeSetterWidgetState extends State<TimeSetterWidget> {
  TextEditingController _minutesTextController;
  TextEditingController _secondesTextController;
  int _maxLength = 2;
  String _minutes = "0";
  String _seconds = "0";

  final Config _appConfig = new Config();

  @override
  void initState() {
    super.initState();
    _minutesTextController = new TextEditingController();
    _secondesTextController = new TextEditingController();

    _minutesTextController.text = "0";
    _secondesTextController.text = "0";
  }

  void _onMinutesChange(String newVal) {
    if (newVal.length <= _maxLength) {
      _minutes = newVal;
    } else {
      _minutesTextController.text = _minutes;
    }
    if (int.parse(_minutes) < 0) {
      _minutesTextController.text = "0";
      _minutes = "0";
    }
    if (int.parse(_minutes) > 60) {
      _minutesTextController.text = "60";
      _minutes = "60";
    }

    this.widget.onChangeCallback(int.parse(_minutes), int.parse(_seconds));
  }

  void _onSecondesChange(String newVal) {
    if (newVal.length <= _maxLength) {
      _seconds = newVal;
    } else {
      _secondesTextController.text = _seconds;
    }
    if (int.parse(_seconds) < 0) {
      _secondesTextController.text = "0";
      _seconds = "0";
    }
    if (int.parse(_seconds) > 59) {
      _secondesTextController.text = "59";
      _seconds = "59";
    }
    this.widget.onChangeCallback(int.parse(_minutes), int.parse(_seconds));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8, top: 8),
            child: Text(
              widget.title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.yellow),
            ),
          ),
          Container(
            constraints: BoxConstraints(),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16, left: 8, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(child: Container()),
                  Container(
                    width: 55,
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: _minutesTextController,
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.yellow,
                      onChanged: _onMinutesChange,
                      style: new TextStyle(color: Colors.yellow, fontSize: 26),
                    ),
                  ),
                  Text(
                    " : ",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.yellow,
                        fontWeight: FontWeight.bold,
                        fontSize: 32),
                  ),
                  Container(
                    width: 55,
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: _secondesTextController,
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.yellow,
                      onChanged: _onSecondesChange,
                      style: new TextStyle(color: Colors.yellow, fontSize: 26),
                    ),
                  ),
                  Expanded(child: Container()),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
