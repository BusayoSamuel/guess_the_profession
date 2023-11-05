import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guess_the_profession/data/questions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Question {
  final String answer;
  final String imageLocation;
  late List<String> options;
  late bool unlocked;

  Question(this.answer, this.imageLocation) {
    getFromMemory(answer).then((value) => unlocked = value);

    List<String> alphabet =
        "abcdefghijklmnopqrstuvwxyz".toUpperCase().split("");

    options = answer.toUpperCase().split("");

    for (int i = 0; i < 12 - answer.length; i++) {
      int randomIndex = Random().nextInt(alphabet.length);
      options.add(alphabet[randomIndex]);
    }

    options.shuffle();
  }

  Future<bool> getFromMemory(String key) async {
    var pref = await SharedPreferences.getInstance();
    var isUnlocked = pref.getBool(key) ?? false;
    return isUnlocked;
  }

  Future<void> saveToMemory() async {
    var pref = await SharedPreferences.getInstance();
    pref.setBool(answer, unlocked);
  }

  Future<void> clearMemory() async {
    var pref = await SharedPreferences.getInstance();
    pref.clear();
  }
}

class QuestionsNotifier extends ChangeNotifier {
  var questions = <Question>[];

  QuestionsNotifier(this.questions);

  void unlockItem(int index) {
    questions[index].unlocked = true;
    questions[index].saveToMemory();
    notifyListeners();
  }
}

final easyQuestionsProvider =
    ChangeNotifierProvider((ref) => QuestionsNotifier(easyQuestions));

final mediumQuestionsProvider =
    ChangeNotifierProvider((ref) => QuestionsNotifier(mediumQuestions));

final hardQuestionsProvider =
    ChangeNotifierProvider((ref) => QuestionsNotifier(hardQuestions));
