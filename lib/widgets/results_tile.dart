import 'package:flutter/material.dart';
import 'package:quiz_app/models/quiz_question.dart';

class ResultsTile extends StatelessWidget {
  const ResultsTile(
      {super.key, required this.question, required this.enteredAnswer});
  final QuizQuestion question;
  final String enteredAnswer;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 260,
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
          border: Border.all(
            color: question.answers[0] == enteredAnswer
                ? Colors.green[200]!
                : Colors.red[200]!,
            width: 1.5,
          ),
          color: const Color(0xff282c35),
          borderRadius: BorderRadius.circular(16)),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            question.question,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: question.answers[0] == enteredAnswer
                  ? Colors.green
                  : Colors.red[200],
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Correct Answer\n${question.answers[0]}',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              Text('User Answer\n$enteredAnswer',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 14)),
            ],
          )
        ],
      ),
    );
  }
}
