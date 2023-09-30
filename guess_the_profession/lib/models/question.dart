import 'dart:math';

import 'package:flutter/material.dart';

class Question extends ChangeNotifier {
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

  void unlock() {
    unlocked = true;
  }
}
