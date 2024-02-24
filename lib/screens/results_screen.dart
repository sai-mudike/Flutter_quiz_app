import 'package:flutter/material.dart';
import 'package:quiz_app/models/quiz_question.dart';
import 'package:quiz_app/widgets/results_tile.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen(
      {super.key, required this.questions, required this.enteredAnswer});
  final List<QuizQuestion> questions;
  final List<String> enteredAnswer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1b2025),
      appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Color(0xff1b2025),
          centerTitle: true,
          title: Text(
            "Answers",
          )),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(14),
          child: Column(
            children: [
              for (var i = 0; i < questions.length; i++)
                ResultsTile(
                  question: questions[i],
                  enteredAnswer: enteredAnswer[i],
                )
            ],
          )),
    );
  }
}
