import 'package:flutter/material.dart';

class CounterSetterWidget extends StatefulWidget {
  CounterSetterWidget({Key key, this.title, this.onChangeCallback})
      : super(key: key);
  final String title;
  Function onChangeCallback;

  @override
  _CounterSetterWidgetState createState() => _CounterSetterWidgetState();
}

class _CounterSetterWidgetState extends State<CounterSetterWidget> {
  TextEditingController _countsTextController;
  int _maxLength = 3;
  String _counts = "1";

  @override
  void initState() {
    super.initState();
    _countsTextController = new TextEditingController();
    _countsTextController.text = "1";
  }

  void _onCountsChange(String newVal) {
    if (newVal.length <= _maxLength) {
      _counts = newVal;
    } else {
      _countsTextController.text = _counts;
    }
    if (int.parse(_counts) < 1) {
      _countsTextController.text = "1";
      _counts = "1";
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
      color: Colors.black,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
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
              padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    width: 55,
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: _countsTextController,
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.yellow,
                      onChanged: _onCountsChange,
                      style: new TextStyle(color: Colors.yellow, fontSize: 26),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
