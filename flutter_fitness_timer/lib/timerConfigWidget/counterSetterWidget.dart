import 'package:flutter/material.dart';
import 'package:flutter_fitness_timer/config.dart';

class CounterSetterWidget extends StatefulWidget {
  CounterSetterWidget({Key key, this.title, onChangeCallback})
      : super(key: key);
  final String title;
  Function onChangeCallback;

  @override
  _CounterSetterWidgetState createState() => _CounterSetterWidgetState();
}

class _CounterSetterWidgetState extends State<CounterSetterWidget> {
  TextEditingController _countsTextController;
  int _maxLength = 3;
  String _counts = "";
  Color _widgetColor = Colors.white;

  final Config _appConfig = new Config();

  @override
  void initState() {
    _countsTextController = new TextEditingController();
    _countsTextController.text = "00";
    _getWidgetColor();
  }

  void _getWidgetColor() {
    _appConfig.getConfig(isDarkThemeKey).then((value) {
      var colorValue = Colors.white;
      if (value == 'true') {
        colorValue = Colors.black;
      }
      setState(() {
        _widgetColor = colorValue;
      });
    });
  }

  void _onCountsChange(String newVal) {
    if (newVal.length <= _maxLength) {
      _counts = newVal;
    } else {
      _countsTextController.text = _counts;
    }
    if (int.parse(_counts) > 999) {
      _countsTextController.text = "999";
      _counts = "999";
    }
    this.widget.onChangeCallback(int.parse(_counts));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _widgetColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              widget.title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.purpleAccent),
            ),
          ),
          Container(
            constraints: BoxConstraints(),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(child: Container()),
                  Flexible(
                    child: TextField(
                      controller: _countsTextController,
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.purple,
                      onChanged: _onCountsChange,
                      style: new TextStyle(color: Colors.purple, fontSize: 26),
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
