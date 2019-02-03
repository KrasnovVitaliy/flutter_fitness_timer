import 'package:flutter/material.dart';
import 'timeSetterWidget.dart';
import 'counterSetterWidget.dart';

class TimerConfigWidget extends StatelessWidget {
  Map<String, dynamic> timerSettings = new Map<String, dynamic>();
  Map<String, dynamic> prepareSettings = new Map<String, dynamic>();
  Map<String, dynamic> trainSettings = new Map<String, dynamic>();
  Map<String, dynamic> relaxSettings = new Map<String, dynamic>();

  Map<String, dynamic> getTimerSettings() {
//    prepareSettings["minutes"] = 00;
//    prepareSettings["seconds"] = 00;
//
//    trainSettings["minutes"] = 00;
//    trainSettings["seconds"] = 00;
//
//    relaxSettings["minutes"] = 00;
//    relaxSettings["seconds"] = 00;

    timerSettings["prepare"] = prepareSettings;
    timerSettings["train"] = trainSettings;
    timerSettings["relax"] = relaxSettings;

    return timerSettings;
  }

  void _onPrepareSettingsChange(int minutes, int seconds) {
    print("Prepare settings change callback");
    prepareSettings["minutes"] = minutes;
    prepareSettings["seconds"] = seconds;
  }

  void _onTrainSettingsChange(int minutes, int seconds) {
    trainSettings["minutes"] = minutes;
    trainSettings["seconds"] = seconds;
  }

  void _onRelaxSettingsChange(int minutes, int seconds) {
    trainSettings["minutes"] = minutes;
    trainSettings["seconds"] = seconds;
  }

  void _onCountsSettingsChange(int counts) {
    timerSettings["count"] = counts;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        TimeSetterWidget(
          title: "Подготовка",
          onChangeCallback: _onPrepareSettingsChange,
        ),
        TimeSetterWidget(
          title: "Тренировка",
          onChangeCallback: _onTrainSettingsChange,
        ),
        TimeSetterWidget(
          title: "Отдых",
          onChangeCallback: _onRelaxSettingsChange,
        ),
        CounterSetterWidget(
          title: "Повторения",
          onChangeCallback: _onCountsSettingsChange,
        ),
      ],
    ));
  }
}
