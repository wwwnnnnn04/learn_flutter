import 'package:flutter/material.dart';
import './answer.dart';
import './question.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final Function(int) answQst;
  final int id;

  Quiz({required this.answQst, required this.id, required this.questions});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(questions[id]['text'] as String),
        ...(questions[id]['answer'] as List<Map<String, Object>>).map((answer) {
          return Answer(
              () => answQst(answer['score'] as int), answer['qst'] as String);
        }).toList(),
      ],
    );
  }
}
