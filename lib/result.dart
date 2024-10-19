import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resScore;
  final VoidCallback reset;

  Result(this.resScore, this.reset);

  String get resultFrasa {
    var resText;
    if (resScore <= 5) {
      resText = 'Твое хобби - рисование!';
    } else if (resScore <= 9) {
      resText = 'Твое хобби - пение';
    } else if (resScore <= 18) {
      resText = 'Твое хобби - программирование';
    } else if (resScore <= 24) {
      resText = 'Твое хобби - плавание';
    }
    return resText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            resultFrasa,
            style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.purple),
            textAlign: TextAlign.center,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                foregroundColor: Colors.white,
              ),
              onPressed: reset,
              child: Text('Заново')),
        ],
      ),
    );
  }
}
