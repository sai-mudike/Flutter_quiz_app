import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  const AnswerButton({
    super.key,
    required this.answerText,
    required this.onTap,
  });

  final String answerText;

  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          width: double.infinity,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xff818181),
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(20)),
          child: Text(
            answerText,
            style: const TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ));
  }
}
