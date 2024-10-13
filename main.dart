// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import './question.dart';
import './answer.dart';

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
      id += 1;
    });
    print(id);
  }

  int id = 0;
  var questions = [
    {
      'text': 'Какой твой любимый цвет',
      'answer': ['Белый', 'Розовый', 'Красный']
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
              title: Text('My first app'),
            ),
            body: Column(
              children: [
                Question(questions[id]['text'] as String),
                ...(questions[id]['answer'] as List<String>).map((answer) {
                  return Answer(_answQst, answer);
                }).toList(),
              ],
            )));
  }
}
