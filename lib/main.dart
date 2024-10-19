// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import './quiz.dart';
import './result.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  var _totalScore = 0;

  void _answQst(int score) {
    _totalScore += score;
    setState(() {
      _id += 1;
    });
    print(_id);
  }

  void _reset() {
    setState(() {
      _id = 0;
      _totalScore = 0;
    });
  }

  int _id = 0;
  static const _questions = [
    {
      'text': 'Какой твой любимый цвет',
      'answer': [
        {'qst': 'Белый', 'score': 3},
        {'qst': 'Розовый', 'score': 8},
        {'qst': 'Красный', 'score': 1},
        {'qst': 'Черный', 'score': 4},
      ]
    },
    {
      'text': 'Какая любимая порода животных',
      'answer': [
        {'qst': 'Котики', 'score': 3},
        {'qst': 'Собаки', 'score': 8},
        {'qst': 'Хомяки', 'score': 1},
      ]
    },
    {
      'text': 'Любимая пора года',
      'answer': [
        {'qst': 'Зима', 'score': 3},
        {'qst': 'Весна', 'score': 8},
        {'qst': 'Лето', 'score': 1},
        {'qst': 'Осень', 'score': 4},
      ]
    },
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('Анкета о себе'),
      ),
      body: _id < _questions.length
          ? Quiz(
              answQst: _answQst,
              id: _id,
              questions: _questions,
            )
          : Result(_totalScore, _reset),
    ));
  }
}
