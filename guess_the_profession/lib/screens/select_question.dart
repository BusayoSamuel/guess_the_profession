import 'package:flutter/material.dart';
import 'package:guess_the_profession/data/easy_questions.dart';
import 'package:guess_the_profession/models/question.dart';
import 'package:guess_the_profession/widgets/background.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:guess_the_profession/screens/gameplay.dart';
import 'package:provider/provider.dart';

class SelectQuestion extends StatefulWidget {
  const SelectQuestion({super.key, required this.difficulty});

  final String difficulty;

  @override
  State<SelectQuestion> createState() => _SelectQuestionState();
}

class _SelectQuestionState extends State<SelectQuestion> {
  @override
  Widget build(BuildContext context) {
    easyQuestions[0].unlock();

    return ChangeNotifierProvider.value(
      value: easyQuestions.first,
      child: Background(
        title: "Select Level",
        body: GridView(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
          ),
          children: questions(context, questions: easyQuestions),
        ),
      ),
    );
  }
}

List<Widget> questions(BuildContext context,
    {required List<Question> questions}) {
  List<Widget> children = [];
  final w = (MediaQuery.of(context).size.width - 4 * (5 - 1)) / 5;

  for (int i = 0; i < questions.length; i++) {
    children.add(questionButton(context, index: i));
  }
  return children;
}

Widget questionButton(BuildContext context,
    {required int index, double size = 30}) {
  return TextButton(
    style: ButtonStyle(
      //overlayColor: MaterialStateProperty.all(Colors.grey[700]),
      backgroundColor: easyQuestions[index].unlocked || index == 0
          ? MaterialStateProperty.all(Color(0xFF001C30))
          : MaterialStateProperty.all(Colors.grey[700]),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          side: const BorderSide(
            color: Colors.white,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      fixedSize: MaterialStateProperty.all(Size(size, size)),
      padding: MaterialStateProperty.all(EdgeInsets.zero),
    ),
    onPressed: () {
      int nextIndex = index + 1 < easyQuestions.length ? index + 1 : index;

      if (easyQuestions[index].unlocked) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Gameplay(
                    question: easyQuestions[index],
                    nextQuestion: easyQuestions[nextIndex],
                  )),
        );
      }
    },
    child: AutoSizeText(
      (index + 1).toString(),
      style: const TextStyle(fontSize: 45, color: Color(0xFFDAFFFB)),
    ),
  );
}
