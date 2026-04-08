import 'dart:async';

import 'package:flutter/material.dart';

class StopWatchScreen extends StatefulWidget {
  const StopWatchScreen({super.key});

  @override
  State<StopWatchScreen> createState() => _StopWatchScreenState();
}

class _StopWatchScreenState extends State<StopWatchScreen> {
  Timer? _timer;
  int _time = 0;
  bool _isRunning = false;
  List<String> lapTimes = [];

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _clickButton() {
    _isRunning = !_isRunning;
    if (_isRunning) {
      _start();
    } else {
      _pause();
    }
  }

  void _start() {
    _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      setState(() {
        _time++;
      });
    });
  }

  void _pause() {
    _timer?.cancel();
  }

  void _reset() {
    _isRunning = false;
    _timer?.cancel();
    lapTimes.clear();
    _time = 0;
  }

  void _recordLapTimes(String time) {
    lapTimes.insert(0, '${lapTimes.length + 1}등 $time');
  }

  @override
  Widget build(BuildContext context) {
    int sec = _time ~/ 100;
    String hundredth = '${_time % 100}'.padLeft(2, '0');

    return Scaffold(
      appBar: AppBar(title: Text('Stop Watch'), centerTitle: true),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$sec',
                style: TextStyle(fontSize: 70, fontWeight: FontWeight.bold),
              ),
              Text(hundredth, style: TextStyle(fontSize: 20)),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 100,
            height: 200,
            child: ListView(
              children:
                  lapTimes.map((time) => Center(child: Text(time))).toList(),
            ),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    _reset();
                  });
                },
                child: Icon(Icons.refresh, color: Colors.orange),
              ),
              FloatingActionButton(
                onPressed: () {
                  _clickButton();
                },
                child: _isRunning ? Icon(Icons.pause) : Icon(Icons.play_arrow),
              ),
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    _recordLapTimes('$sec.$hundredth');
                  });
                },
                child: Icon(Icons.add, color: Colors.green),
              ),
            ],
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
