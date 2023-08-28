import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:guess_the_profession/models/question.dart';
import 'package:guess_the_profession/widgets/background.dart';

class Gameplay extends StatelessWidget {
  Gameplay({super.key, required this.question});

  final Question question;

  late final response =
      ValueNotifier(List<String>.filled(question.answer.length, ""));

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Background(
      title: "Guess the Profession",
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset(
              question.imageLocation, //"assets/images/doctor/stethoscope.jpg",
              height: 250,
            ),
            ValueListenableBuilder<List<String>>(
                valueListenable: response,
                builder: (context, value, child) {
                  return Column(children: [
                    const Divider(
                      color: Colors.black,
                      thickness: 1,
                    ),
                    answerBoxes(context,
                        number: question.answer.length,
                        response: response.value),
                    const Divider(
                      color: Colors.black,
                      thickness: 1,
                    ),
                  ]);
                }),
            GridView(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
              ),
              children: letterOptions(context, letters: question.options),
            ),
          ],
        ),
      ),
    );
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
    bool isVisible = true;
    return StatefulBuilder(builder: (context, setState) {
      return Visibility(
          key: formKey,
          visible: isVisible,
          child: styledTextButton(letter, () {
            if (response.value.contains("")) {
              response.value[response.value.indexOf("")] = letter;
              response.notifyListeners();
              setState(() {
                isVisible = !isVisible;
              });
            }
          }));
    });
  }

  Widget answerBoxes(BuildContext context,
      {required int number, required List<String> response}) {
    final size =
        (MediaQuery.of(context).size.width - 14 * (number - 1)) / number;

    return Wrap(
      runSpacing: 4,
      spacing: 4,
      alignment: WrapAlignment.center,
      // TODO: Make answer buttons iteractive
      children: List.generate(number, (index) {
        return SizedBox(
            height: size,
            width: size,
            child: styledTextButton(response[index], () {}));
      }),
    );
  }

  Widget styledTextButton(String text, void Function() onPressed) {
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
        padding: MaterialStateProperty.all(EdgeInsets.zero),
      ),
      onPressed: onPressed,
      child: AutoSizeText(
        text,
        style: const TextStyle(fontSize: 45, color: Color(0xFFDAFFFB)),
      ),
    );
  }
}
