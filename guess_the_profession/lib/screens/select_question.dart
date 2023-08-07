import 'package:flutter/material.dart';
import 'package:guess_the_profession/widgets/background.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:guess_the_profession/screens/gameplay.dart';

class SelectQuestion extends StatefulWidget {
  const SelectQuestion({super.key});

  @override
  State<SelectQuestion> createState() => _SelectQuestionState();
}

class _SelectQuestionState extends State<SelectQuestion> {
  @override
  Widget build(BuildContext context) {
    return Background(
      body: GridView(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
        ),
        children: questions(
          context,
          questions: [
            "1",
            "2",
            "3",
            "4",
            "5",
            "6",
            "7",
            "8",
            "9",
            "10",
            "11",
            "12",
          ],
        ),
      ),
    );
  }
}

List<Widget> questions(BuildContext context,
    {required List<String> questions}) {
  List<Widget> children = [];
  final w = (MediaQuery.of(context).size.width - 4 * (5 - 1)) / 5;

  for (final question in questions) {
    children.add(questionButton(context, number: question));
  }
  return children;
}

Widget questionButton(BuildContext context,
    {required String number, double size = 30}) {
  return TextButton(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Color(0xFF001C30)),
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
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const Gameplay(title: 'GuessTheProfession')),
      );
    },
    child: AutoSizeText(
      number,
      style: const TextStyle(fontSize: 45, color: Color(0xFFDAFFFB)),
    ),
  );
}
