import 'dart:math';

import 'package:flutter/material.dart';

class DiceGame extends StatefulWidget {
  const DiceGame({super.key});

  @override
  State<DiceGame> createState() => _DiceGameState();
}

class _DiceGameState extends State<DiceGame> {
  final _random = Random();
  int _diceSum = 0, _target = 0, _faceValue1 = 1, _faceValue2 = 1, _point = 100;
  String _status = '';
  bool _isGameRunning = true;
  bool _isGameFinished = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dice Roller'),
      ),
      body: Column(
        children: [
          Text('Total Points: $_point', style: const TextStyle(fontSize: 25.0,),),
          Text('Dice Sum: $_diceSum', style: const TextStyle(fontSize: 25.0,),),
          Text('Target: $_target', style: const TextStyle(fontSize: 25.0,),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Dice(faceValue: '$_faceValue1'),
              Dice(faceValue: '$_faceValue2'),
            ],
          ),
          ElevatedButton(
            onPressed: _isGameRunning ? _rollTheDice : null,
            child: const Text('ROLL'),
          ),
          ElevatedButton(
            onPressed: _isGameRunning || _isGameFinished ? null : _reset,
            child: const Text('RESET'),
          ),
          ElevatedButton(
            onPressed: !_isGameFinished ? null : () => Navigator.pop(context),
            child: const Text('FINISH'),
          ),
          const SizedBox(height: 20.0,),
          Text(_status, style: const TextStyle(fontSize: 25.0,),)
        ],
      ),
    );
  }

  void _checkPoint() {
    if(_point == 0) {
      setState(() {
        _isGameFinished = true;
      });
    }
  }

  void _rollTheDice() {
    setState(() {
      _faceValue1 = _random.nextInt(6) + 1;
      _faceValue2 = _random.nextInt(6) + 1;
      _diceSum = _faceValue1 + _faceValue2;
      if (_target > 0) {
        if(_diceSum == _target) {
          _status = 'Player Wins!';
          _point += 100;
          _isGameRunning = false;
        } else if (_diceSum == 7) {
          _status = 'Player Loses!';
          _point -= 100;
          _isGameRunning = false;
          _checkPoint();
        }
      } else {
        if(_diceSum == 7 || _diceSum == 11) {
          _status = 'Player Wins!';
          _point += 100;
          _isGameRunning = false;
        }else if (_diceSum == 2 || _diceSum == 3 || _diceSum == 12) {
          _status = 'Player Loses!';
          _point -= 100;
          _isGameRunning = false;
          _checkPoint();
        } else {
          _target = _diceSum;
        }
      }

    });
  }

  void _reset() {
    setState(() {
      _diceSum = 0;
      _target = 0;
      _faceValue2 = 1;
      _faceValue1 = 1;
      _status = '';
      _isGameRunning = true;
    });
  }
}

class Dice extends StatelessWidget {
  const Dice({
    super.key,
    required this.faceValue,
  });

  final String faceValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(5.0),
      width: 100,
      height: 100,
      color: Colors.red,
      child: Text(
        faceValue,
        style: const TextStyle(
          fontSize: 70.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
