import 'package:flutter/material.dart';
import 'dart:async';

class TimerProvider with ChangeNotifier {
  Timer? _timer;
  int _start = 0;
  bool _isRunning = false;

  int get time => _start;
  bool get isRunning => _isRunning;

  void _tick(Timer timer) {
    if (_start > 0) {
      _start--;
      notifyListeners();
    } else {
      _timer!.cancel();
      _isRunning = false;
      notifyListeners();
    }
  }

  void startTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer.periodic(const Duration(seconds: 1), _tick);
    _isRunning = true;
    notifyListeners();
  }

  void stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _isRunning = false;
      notifyListeners();
    }
  }

  void resetTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
    _start = 0;
    _isRunning = false;
    notifyListeners();
  }

  void changeTime(int seconds) {
    _start = seconds;
    if (_isRunning) {
      startTimer();
    } else {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.dispose();
  }
}
