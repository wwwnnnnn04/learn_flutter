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
  void _answQst() {
    setState(() {
      _id += 1;
    });
    print(_id);
  }

  int _id = 0;
  static const _questions = [
    {
      'text': 'Какой твой любимый цвет',
      'answer': ['Белый', 'Розовый', 'Красный', 'Черный']
    },
    {
      'text': 'Какая любимая порода животных',
      'answer': ['Котики', 'Собаки', 'Хомяки']
    },
    {
      'text': 'Любимая пора года',
      'answer': ['Лето', 'Весна', 'Зима']
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
          : Result(),
    ));
  }
}
