import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api.g.dart';

const _host = 'opentdb.com';

enum Difficulty {
  easy(Colors.green),
  medium(Colors.orange),
  hard(Colors.red);

  final Color color;

  const Difficulty(this.color);
}

final class Question {
  final String text;
  final List<String> answers;

  const Question({required this.text, required this.answers});

  String get correctAnswer => answers.first;

  factory Question.fromJson(dynamic json) {
    return switch (json) {
      {
        'question': String text,
        'correct_answer': String correctAnswer,
        'incorrect_answers': List<dynamic> incorrectAnswers
      } =>
        Question(
            text: text,
            answers: _combineAnswers(correctAnswer, incorrectAnswers)),
      _ => throw const FormatException("Badly formatted question JSON")
    };
  }

  static List<String> _combineAnswers(String correctAnswer, List<dynamic> incorrectAnswers) {
    List<String> answers = incorrectAnswers.map((answer) => answer.toString()).toList();
    answers.insert(0, correctAnswer);
    return answers;
  }
}

@riverpod
Future<List<Question>> getQuestions(GetQuestionsRef ref, Difficulty difficulty, int amount) async {
  final url = Uri.https(_host, 'api.php', {
    'difficulty': difficulty.name,
    'amount': amount.toString(),
  });

  final response = await http.get(url);
  // TODO: error handling
  final json = jsonDecode(response.body) as Map<String, dynamic>;
  final results = json['results'] as List<dynamic>;

  return results.map(Question.fromJson).toList(growable: false);
}
