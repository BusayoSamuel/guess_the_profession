import 'package:flutter/material.dart';
import 'package:guess_the_profession/models/question.dart';
import 'package:guess_the_profession/screens/select_question.dart';
import 'package:guess_the_profession/widgets/background.dart';
import 'package:guess_the_profession/data/questions.dart';

enum Difficulty { easy, medium, hard }

class DifficultyLevels extends StatelessWidget {
  const DifficultyLevels({super.key});

  @override
  Widget build(BuildContext context) {
    return Background(
      title: "Select Difficulty",
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            gamePackButton(context, Difficulty.easy),
            gamePackButton(context, Difficulty.medium),
            gamePackButton(context, Difficulty.hard),
          ],
        ),
      ),
    );
  }
}

Widget gamePackButton(BuildContext context, Difficulty difficulty) {
  ValueNotifier<List<Question>> selectedQuestionPack;
  String text;
  switch (difficulty) {
    case Difficulty.easy:
      text = "Easy Pack";
      selectedQuestionPack = easyQuestions;
    case Difficulty.medium:
      text = "Medium Pack";
    //selectedQuestionPack = mediumQuestions;
    case Difficulty.hard:
      text = "Hard Pack";
    //selectedQuestionPack = hardQuestions;
  }
  return SizedBox(
    width: double.infinity,
    child: OutlinedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SelectQuestion(
                    questions: easyQuestions,
                  )),
        );
      },
      child: Text(text),
    ),
  );
}
