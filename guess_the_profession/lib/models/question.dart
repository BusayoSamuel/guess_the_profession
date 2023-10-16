import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guess_the_profession/data/questions.dart';

class Question {
  final String answer;
  final String imageLocation;
  late List<String> options;
  bool unlocked = false;

  Question(this.answer, this.imageLocation) {
    List<String> alphabet =
        "abcdefghijklmnopqrstuvwxyz".toUpperCase().split("");

    options = answer.toUpperCase().split("");

    for (int i = 0; i < 12 - answer.length; i++) {
      int randomIndex = Random().nextInt(alphabet.length);
      options.add(alphabet[randomIndex]);
    }

    options.shuffle();
  }
}

class QuestionsNotifier extends ChangeNotifier {
  var questions = <Question>[];

  QuestionsNotifier(this.questions);

  void unlockItem(int index) {
    questions[index].unlocked = true;
    notifyListeners();
  }
}

final easyQuestionsProvider =
    ChangeNotifierProvider((ref) => QuestionsNotifier(easyQuestions));

final mediumQuestionsProvider =
    ChangeNotifierProvider((ref) => QuestionsNotifier(mediumQuestions));

final hardQuestionsProvider =
    ChangeNotifierProvider((ref) => QuestionsNotifier(hardQuestions));
