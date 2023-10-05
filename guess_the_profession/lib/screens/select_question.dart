import 'package:flutter/material.dart';
import 'package:guess_the_profession/data/questions.dart';
import 'package:guess_the_profession/models/question.dart';
import 'package:guess_the_profession/screens/difficulty_levels.dart';
import 'package:guess_the_profession/widgets/background.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:guess_the_profession/screens/gameplay.dart';
import 'package:provider/provider.dart';

class SelectQuestion extends StatefulWidget {
  const SelectQuestion({super.key, required this.questions});

  final ValueNotifier<List<Question>> questions;

  @override
  State<SelectQuestion> createState() => _SelectQuestionState();
}

class _SelectQuestionState extends State<SelectQuestion> {
  @override
  Widget build(BuildContext context) {
    widget.questions.value[0].unlock();

    return ChangeNotifierProvider.value(
      value: widget.questions,
      child: Background(
        title: "Select Level",
        body: GridView(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
          ),
          children: questions(context, questions: widget.questions),
        ),
      ),
    );
  }
}

List<Widget> questions(BuildContext context,
    {required ValueNotifier<List<Question>> questions}) {
  List<Widget> children = [];
  final w = (MediaQuery.of(context).size.width - 4 * (5 - 1)) / 5;

  for (int i = 0; i < questions.value.length; i++) {
    children.add(questionButton(context, index: i, questions: questions));
  }
  return children;
}

Widget questionButton(BuildContext context,
    {required int index,
    required ValueNotifier<List<Question>> questions,
    double size = 30}) {
  return TextButton(
    style: ButtonStyle(
      backgroundColor: questions.value[index].unlocked || index == 0
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
      int nextIndex = index + 1 < questions.value.length ? index + 1 : index;

      if (questions.value[index].unlocked) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Gameplay(
                    question: questions.value[index],
                    nextQuestion: questions.value[nextIndex],
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
