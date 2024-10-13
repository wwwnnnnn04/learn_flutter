import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final VoidCallback ans;
  final String text;

  Answer(this.ans, this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.pink,
          foregroundColor: Colors.white,
        ),
        onPressed: ans,
        child: Text(text),
      ),
    );
  }
}
