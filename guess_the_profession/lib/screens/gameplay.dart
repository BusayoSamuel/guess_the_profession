import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:guess_the_profession/widgets/background.dart';

class Gameplay extends StatefulWidget {
  const Gameplay({super.key, required this.title});

  final String title;

  @override
  State<Gameplay> createState() => _GameplayState();
}

class _GameplayState extends State<Gameplay> {
  @override
  Widget build(BuildContext context) {
    return Background(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset(
              "assets/images/doctor/stethoscope.jpg",
              height: 250,
            ),
            const Divider(
              color: Colors.black,
              thickness: 1,
            ),
            answerBoxes(context, 6),
            const Divider(
              color: Colors.black,
              thickness: 1,
            ),
            GridView(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
              ),
              children: letterOptions(
                context,
                letters: [
                  "T",
                  "B",
                  "C",
                  "D",
                  "O",
                  "F",
                  "O",
                  "I",
                  "J",
                  "C",
                  "L",
                  "R",
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<Widget> letterOptions(BuildContext context,
    {required List<String> letters}) {
  List<Widget> children = [];
  final w = (MediaQuery.of(context).size.width - 4 * (12 - 1)) / 12;

  for (final letter in letters) {
    children.add(letterButton(letter: letter));
  }
  return children;
}

Widget letterButton({required String letter, double size = 30}) {
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
    onPressed: () {},
    child: AutoSizeText(
      letter,
      style: const TextStyle(fontSize: 45, color: Color(0xFFDAFFFB)),
    ),
  );
}

Widget answerBoxes(BuildContext context, answerLength) {
  final size = (MediaQuery.of(context).size.width - 14 * (6 - 1)) / 6;

  return Wrap(
    runSpacing: 4,
    spacing: 4,
    alignment: WrapAlignment.center,
    children: List.generate(6, (index) {
      return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Color(0xFF001C30),
        ),
        width: size,
        height: size,
      );
    }),
  );
}
