import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:screen/screen.dart';
import 'dart:async';

class TimerScreen extends StatefulWidget {
  Map<String, dynamic> timerConfig;

  TimerScreen({Key key, this.timerConfig}) : super(key: key);

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  AudioCache _audioPlayer;

  int _prepareMinutes;
  int _prepareSeconds;

  int _trainMinutes;
  int _trainSeconds;

  int _relaxMinutes;
  int _relaxSeconds;

  int _rounds;

  Timer _timer;
  final oneSec = const Duration(seconds: 1);

  bool isRunning = true;
  bool isDone = false;
  bool isPrepare = false;
  bool isTraining = true;
  bool isRelax = false;

  int _currentMinutes = 0;
  int _currentSeconds = 0;
  int _currentRound = 0;

  String _message;

  void _setNextTimer() {
    if (isPrepare) {
      _startTraningTimer();
    } else if (isTraining) {
      _startRelaxTimer();
    } else if (isRelax) {
      _startTraningTimer();
    }
  }

  void _setPrepareState() {
    setState(() {
      isPrepare = true;
      isTraining = false;
      isRelax = false;
      _message = "Приготовились";
    });
  }

  void _startPrepareTimer() {
    this._stopTimer();
    _setPrepareState();
    _currentMinutes = this._prepareMinutes;
    _currentSeconds = this._prepareSeconds;
    _timer = new Timer.periodic(oneSec, (Timer t) => _timerTick());
  }

  void _setTraningState() {
    setState(() {
      isPrepare = false;
      isTraining = true;
      isRelax = false;
      _message = "Упражнение";
    });
  }

  void _startTraningTimer() {
    this._stopTimer();
    _setTraningState();
    _currentRound++;
    _currentMinutes = this._trainMinutes;
    _currentSeconds = this._trainSeconds;
    _timer = new Timer.periodic(oneSec, (Timer t) => _timerTick());
    this._playSingleBell();
  }

  void _setRelaxState() {
    setState(() {
      isPrepare = false;
      isTraining = false;
      isRelax = true;
      _message = "Отдых";
    });
  }

  void _startRelaxTimer() {
    if (_currentRound >= this._rounds) {
      _stopTimer();
      isRunning = false;
      isDone = true;
      _playTrippleBell();
      _message = "";
    } else {
      this._stopTimer();
      _setRelaxState();
      _currentMinutes = this._relaxMinutes;
      _currentSeconds = this._relaxSeconds;
      _timer = new Timer.periodic(oneSec, (Timer t) => _timerTick());
      this._playSingleBell();
    }
  }

  void _stopTimer() {
    if (_timer != null) {
      _timer.cancel();
    }
  }

  void _timerTick() {
    if (isRunning) {
      setState(() {
        _currentSeconds--;
        if (_currentSeconds < 0) {
          _currentSeconds = 59;
          _currentMinutes--;
          if (_currentMinutes < 0) {
            _currentMinutes = 0;
            _currentSeconds = 0;
            this._setNextTimer();
          }
        }
      });
    }
  }

  MaterialColor _currentColor() {
    if (!isRunning) {
      return Colors.yellow;
    }
    if (isPrepare) {
      return Colors.blue;
    }
    if (isTraining) {
      return Colors.red;
    }
    if (isRelax) {
      return Colors.green;
    }
    return Colors.yellow;
  }

  Icon _getFloatingButtonIcon() {
    if (isRunning) {
      return Icon(Icons.pause);
    } else if (isDone) {
      return Icon(Icons.autorenew);
    }
    return Icon(Icons.play_arrow);
  }

  void _onFloatingButtonHandler() {
    setState(() {
      if (isDone) {
        isDone = false;
        isRunning = true;
        _currentRound = 0;
        this._startPrepareTimer();
      } else {
        isRunning = !isRunning;
      }
    });
  }

  _playSingleBell() async {
    _audioPlayer.play("sounds/single_bell.mp3");
  }

  _playTrippleBell() async {
    _audioPlayer.play("sounds/triple_bell.mp3");
  }

  @override
  void initState() {
    super.initState();
    Screen.keepOn(true);
    _audioPlayer = AudioCache();
    _message = "";

    if (widget.timerConfig["prepare"].containsKey("minutes") == true) {
      this._prepareMinutes = widget.timerConfig["prepare"]["minutes"];
    } else {
      this._prepareMinutes = 0;
    }

    if (widget.timerConfig["prepare"].containsKey("seconds") == true) {
      this._prepareSeconds = widget.timerConfig["prepare"]["seconds"];
    } else {
      this._prepareSeconds = 0;
    }

    if (widget.timerConfig["train"].containsKey("minutes") == true) {
      this._trainMinutes = widget.timerConfig["train"]["minutes"];
    } else {
      this._trainMinutes = 0;
    }

    if (widget.timerConfig["train"].containsKey("seconds") == true) {
      this._trainSeconds = widget.timerConfig["train"]["seconds"];
    } else {
      this._trainSeconds = 0;
    }

    if (widget.timerConfig["relax"].containsKey("minutes") == true) {
      this._relaxMinutes = widget.timerConfig["relax"]["minutes"];
    } else {
      this._relaxMinutes = 0;
    }

    if (widget.timerConfig["relax"].containsKey("seconds") == true) {
      this._relaxSeconds = widget.timerConfig["relax"]["seconds"];
    } else {
      this._relaxSeconds = 0;
    }

    if (widget.timerConfig.containsKey("rounds") == true) {
      this._rounds = widget.timerConfig["rounds"];
    } else {
      this._rounds = 1;
    }

    this._startPrepareTimer();
  }

  @override
  void dispose() {
    super.dispose();
    Screen.keepOn(false);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Фитнес таймер"),
        backgroundColor: _currentColor(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              '$_message',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Colors.white),
            ),
            Text(
              isDone ? 'DONE' : '$_currentMinutes:$_currentSeconds',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 80,
                  color: Colors.white),
            ),
            Text(
              'Раунд: $_currentRound/' + this._rounds.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Colors.white),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Старт', // used by assistive technologies
        child: _getFloatingButtonIcon(),
        backgroundColor: _currentColor(),
        onPressed: _onFloatingButtonHandler,
      ),
    );
  }
}
