import 'dart:convert';
import 'package:html_unescape/html_unescape.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:quiz_app/models/category.dart';
import 'package:quiz_app/models/quiz_question.dart';
import 'package:quiz_app/widgets/answer_button.dart';

final unescape = HtmlUnescape();

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key, required this.category});
  final Category category;
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late Future<List<QuizQuestion>> _quizQuestion;
  var currentIndex = 0;

  @override
  void initState() {
    _quizQuestion = _getQuestion();
    super.initState();
  }

  Future<List<QuizQuestion>> _getQuestion() async {
    final url = Uri.https('opentdb.com', 'api.php', {
      'amount': '10',
      widget.category.id != 'any' ? 'category' : widget.category.id: null,
      'type': 'multiple',
    });

    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
    });
    final listData = json.decode(response.body)['results'];
    final List<QuizQuestion> question = [];
    for (final item in listData) {
      question.add(
        QuizQuestion(
          question: unescape.convert(item['question']),
          answers: [
            unescape.convert(
              item['correct_answer'],
            ),
            for (final answer in item['incorrect_answers'])
              unescape.convert(
                answer,
              ),
          ],
        ),
      );
    }
    return question;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: FutureBuilder(
          future: _quizQuestion,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              final currentQuestion = snapshot.data!.elementAt(currentIndex);

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(currentQuestion.question),
                    const SizedBox(
                      height: 30,
                    ),
                    ...currentQuestion.answers.map((ans) => AnswerButton(
                        answerText: ans,
                        onTap: () {
                          setState(() {
                            currentIndex++;
                          });
                        })),
                  ],
                ),
              );
            }

            return const Center(
              child: Text('no questions'),
            );
          },
        ),
      ),
    );
  }
}
