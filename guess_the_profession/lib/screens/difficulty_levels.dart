import 'package:flutter/material.dart';
import 'package:guess_the_profession/screens/select_question.dart';
import 'package:guess_the_profession/widgets/background.dart';

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
            gamePackButton(context, "Easy"),
            gamePackButton(context, "Medium"),
            gamePackButton(context, "Hard"),
          ],
        ),
      ),
    );
  }
}

Widget gamePackButton(BuildContext context, String difficulty) {
  return SizedBox(
    width: double.infinity,
    child: OutlinedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SelectQuestion(
                    difficulty: difficulty,
                  )),
        );
      },
      child: Text("$difficulty Pack"),
    ),
  );
}
