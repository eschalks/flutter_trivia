import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_trivia/widgets.dart';

import 'api.dart';

class TriviaPage extends StatefulWidget {
  final Difficulty difficulty;

  const TriviaPage(this.difficulty, {super.key});

  @override
  State<StatefulWidget> createState() => TriviaState();
}

class TriviaState extends State<TriviaPage> {
  late Future<List<Question>> _questions;

  int questionIndex = 0;
  int correctCount = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _questions = TriviaClient().getQuestions(widget.difficulty, 10);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _questions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            print(snapshot.error);
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.hasData) {

            final questions = snapshot.data as List<Question>;
            if (questionIndex == questions.length) {
              return TriviaResults(
                correct: correctCount,
                total: questions.length,
              );
            }

            final question = questions[questionIndex];

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("${questionIndex+1} / ${questions.length}"),
                TriviaQuestion(
                  question: question,
                  onAnswer: (answer) => {
                    setState(() {
                      if (answer == question.correctAnswer) {
                        correctCount += 1;
                      }
                      questionIndex += 1;
                    })
                  },
                ),
              ],
            );
          }

          return Center(child: Text('No data'));
        },
      ),
    );
  }
}

class TriviaQuestion extends StatelessWidget {
  final Question question;
  final void Function(String) onAnswer;

  const TriviaQuestion(
      {required this.question, required this.onAnswer, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(24.0),
          child:
              HtmlText(question.text, style: const TextStyle(fontSize: 18.0)),
        ),
        TriviaAnswers(
          key: Key(question.text),
          answers: question.answers,
          onAnswer: onAnswer,
          correctAnswer: question.correctAnswer,
        ),
      ],
    );
  }
}

class TriviaAnswers extends StatefulWidget {
  final List<String> answers;
  final void Function(String) onAnswer;
  final String correctAnswer;

  const TriviaAnswers(
      {required this.answers,
      required this.onAnswer,
      required this.correctAnswer,
      super.key});

  @override
  State<StatefulWidget> createState() => TriviaAnswersState();
}

class TriviaAnswersState extends State<TriviaAnswers> {
  late List<String> shuffledAnswers;
  String? clickedAnswer;
  Timer? _answerTimer;

  @override
  void initState() {
    super.initState();
    shuffledAnswers = widget.answers.toList(growable: false)..shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: shuffledAnswers
          .map((answer) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                  onPressed: clickedAnswer == null
                      ? () => {
                            setState(() {
                              clickedAnswer = answer;
                              _answerTimer = Timer(const Duration(seconds: 2),
                                  () => widget.onAnswer(answer));
                            })
                          }
                      : null,
                  style: clickedAnswer == answer
                      ? ButtonStyle(
                          foregroundColor: WidgetStateProperty.all(Colors.white),
                          backgroundColor: WidgetStateProperty.all(
                              answer == widget.correctAnswer
                                  ? Colors.green
                                  : Colors.red))
                      : null,
                  child: HtmlText(answer, style: const TextStyle(fontSize: 16),),
                ),
          ))
          .toList(growable: false),
    );
  }
}



class TriviaResults extends StatelessWidget {
  final int correct;
  final int total;

  const TriviaResults({required this.correct, required this.total, super.key});

  @override
  Widget build(BuildContext context) {
    final ratio = correct.toDouble() / total;
    final percentage = (ratio * 100).floor();

    final scoreColor = Color.fromARGB(255, (255 * (1.0 - ratio)).floor(), (255 * ratio).floor(), 0);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("$percentage%", style: TextStyle(color: scoreColor, fontSize: 50)),
          ElevatedButton(onPressed: () => Navigator.of(context).pop(), child: const Text("Play again!")),
        ],
      ),
    );
  }
}