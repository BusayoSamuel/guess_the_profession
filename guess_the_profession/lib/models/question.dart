import 'dart:math';

class Question {
  final String answer;
  final String imageLocation;
  late List<String> options;

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
