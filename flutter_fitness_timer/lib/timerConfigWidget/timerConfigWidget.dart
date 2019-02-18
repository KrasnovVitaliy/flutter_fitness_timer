import 'package:flutter/material.dart';
import 'timeSetterWidget.dart';
import 'counterSetterWidget.dart';

class TimerConfigWidget extends StatelessWidget {
  Map<String, dynamic> timerSettings = new Map<String, dynamic>();
  Map<String, dynamic> prepareSettings = new Map<String, dynamic>();
  Map<String, dynamic> trainSettings = new Map<String, dynamic>();
  Map<String, dynamic> relaxSettings = new Map<String, dynamic>();

  Map<String, dynamic> getTimerSettings() {
    timerSettings["prepare"] = prepareSettings;
    timerSettings["train"] = trainSettings;
    timerSettings["relax"] = relaxSettings;

    return timerSettings;
  }

  void _onPrepareSettingsChange(int minutes, int seconds) {
    print("Prepare settings change callback $minutes : $seconds");
    prepareSettings["minutes"] = minutes;
    prepareSettings["seconds"] = seconds;
  }

  void _onTrainSettingsChange(int minutes, int seconds) {
    print("Prepare train change callback $minutes : $seconds");
    trainSettings["minutes"] = minutes;
    trainSettings["seconds"] = seconds;
  }

  void _onRelaxSettingsChange(int minutes, int seconds) {
    print("Prepare relax change callback $minutes : $seconds");
    relaxSettings["minutes"] = minutes;
    relaxSettings["seconds"] = seconds;
  }

  void _onRoundsSettingsChange(int rounds) {
    print("Rounds change callback $rounds");
    timerSettings["rounds"] = rounds;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
      children: <Widget>[
        TimeSetterWidget(
          title: "Подготовка",
          onChangeCallback: _onPrepareSettingsChange,
        ),
        Divider(
          color: Colors.yellowAccent,
        ),
        TimeSetterWidget(
          title: "Упражнение",
          onChangeCallback: _onTrainSettingsChange,
        ),
        Divider(
          color: Colors.yellowAccent,
        ),
        TimeSetterWidget(
          title: "Отдых",
          onChangeCallback: _onRelaxSettingsChange,
        ),
        Divider(
          color: Colors.yellowAccent,
        ),
        CounterSetterWidget(
          title: "Раунды",
          onChangeCallback: _onRoundsSettingsChange,
        ),
        Divider(
          color: Colors.yellowAccent,
        ),
      ],
    ));
  }
}
