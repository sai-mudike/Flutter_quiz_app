import 'dart:convert';
// import 'dart:io';
import 'package:html_unescape/html_unescape.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:quiz_app/models/category.dart';
import 'package:quiz_app/models/quiz_question.dart';
import 'package:quiz_app/screens/results_screen.dart';
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
  final List<String> userEnteredAnswers = [];

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
        centerTitle: true,
        foregroundColor: Colors.white,
        title: Text(
          widget.category.title,
        ),
        backgroundColor: Color(0xff004840),
      ),
      backgroundColor: Color(0xff004840),
      body: FutureBuilder(
        future: _quizQuestion,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }
          if (snapshot.hasData) {
            final currentQuestion = snapshot.data!.elementAt(currentIndex);

            return Container(
              margin: const EdgeInsets.only(top: 40),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 60),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 200,
                      child: Text(
                        currentQuestion.question,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ...currentQuestion.getShuffledAnswers().map(
                          (ans) => AnswerButton(
                            answerText: ans,
                            onTap: () {
                              userEnteredAnswers.add(ans);
                              if (currentIndex == 9) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ResultsScreen(
                                        questions: snapshot.data!,
                                        enteredAnswer: userEnteredAnswers),
                                  ),
                                );
                              } else {
                                setState(
                                  () {
                                    // sleep(const Duration(milliseconds: 500));
                                    currentIndex++;
                                  },
                                );
                              }
                            },
                          ),
                        )
                  ],
                ),
              ),
            );
          }

          return const Center(
            child: Text('no questions'),
          );
        },
      ),
    );
  }
}
