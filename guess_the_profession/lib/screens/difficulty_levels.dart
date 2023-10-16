import 'package:flutter/material.dart';
import 'package:guess_the_profession/screens/select_question.dart';
import 'package:guess_the_profession/widgets/background.dart';

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
  String text;

  switch (difficulty) {
    case Difficulty.easy:
      text = "Easy Pack";
    case Difficulty.medium:
      text = "Medium Pack";
    case Difficulty.hard:
      text = "Hard Pack";
  }

  return SizedBox(
    width: double.infinity,
    child: OutlinedButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => SelectQuestion(
                    difficulty: difficulty,
                  )),
        );
      },
      child: Text(text),
    ),
  );
}
