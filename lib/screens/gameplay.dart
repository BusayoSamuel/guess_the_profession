import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:guess_the_profession/models/question.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guess_the_profession/widgets/background.dart';

class Gameplay extends ConsumerWidget {
  Gameplay(
      {super.key,
      required this.question,
      required this.nextQuestionIndex,
      required this.questionProvider});

  final ChangeNotifierProvider<QuestionsNotifier> questionProvider;
  final Question question;
  final int nextQuestionIndex;

  late final chosenLetters = ValueNotifier(List<List>.filled(question.answer.length, ["", () {}]));
  late final actions = List<void Function()>.filled(question.answer.length, () {});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Background(
      title: "Guess the Profession",
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset(
              question.imageLocation,
              height: 250,
            ),
            ValueListenableBuilder<List<List<dynamic>>>(
                valueListenable: chosenLetters,
                builder: (context, value, child) {
                  return Column(children: [
                    const Divider(
                      color: Colors.black,
                      thickness: 1,
                    ),
                    answerBoxes(context,
                        number: question.answer.length, response: chosenLetters.value),
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
              children: letterOptions(context,
                  letters: question.options, ref: ref, questionProvider: questionProvider),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> letterOptions(BuildContext context,
      {required List<String> letters,
      required WidgetRef ref,
      required ChangeNotifierProvider<QuestionsNotifier> questionProvider}) {
    List<Widget> children = [];
    final w = (MediaQuery.of(context).size.width - 4 * (12 - 1)) / 12;

    for (final letter in letters) {
      children.add(letterButton(letter: letter, ref: ref, questionProvider: questionProvider));
    }
    return children;
  }

  Widget letterButton(
      {required String letter,
      required WidgetRef ref,
      required ChangeNotifierProvider<QuestionsNotifier> questionProvider,
      double size = 30}) {
    bool isVisible = true;
    return StatefulBuilder(builder: (context, setState) {
      void toggleVisibility() {
        setState(() {
          isVisible = !isVisible;
        });
      }

      return Visibility(
        visible: isVisible,
        child: styledTextButton(letter, () {
          chosenLetters.value[chosenLetters.value.indexWhere((element) => element.contains(""))] = [
            letter,
            toggleVisibility
          ];
          chosenLetters.notifyListeners();
          toggleVisibility();
          String chosenAnswer = chosenLetters.value.map((e) => e[0].toString()).join();
          if (chosenAnswer == question.answer) {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: const Text("Congrats!"),
                      content: const Text("You guessed the right answer."),
                      actions: [
                        TextButton(
                          onPressed: () {
                            ref.read(questionProvider.notifier).unlockItem(nextQuestionIndex);
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: const Text('Next Level'),
                        )
                      ],
                    ));
          }
        }),
      );
    });
  }

  Widget answerBoxes(BuildContext context,
      {required int number, required List<List<dynamic>> response}) {
    final size = (MediaQuery.of(context).size.width - 14 * (number - 1)) / number;

    return StatefulBuilder(builder: (context, setState) {
      return Wrap(
        runSpacing: 4,
        spacing: 4,
        alignment: WrapAlignment.center,
        children: List.generate(number, (index) {
          return SizedBox(
              height: size,
              width: size,
              child: styledTextButton(response[index][0], () {
                setState(() {
                  response[index][0] = "";
                  response[index][1]();
                  response[index][1] = () {};
                });
              }));
        }),
      );
    });
  }

  Widget styledTextButton(String text, void Function() onPressed) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(const Color(0xFF001C30)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            side: const BorderSide(
              color: Colors.white,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        padding: WidgetStateProperty.all(EdgeInsets.zero),
      ),
      onPressed: onPressed,
      child: AutoSizeText(
        text,
        style: const TextStyle(fontSize: 45, color: Color(0xFFDAFFFB)),
      ),
    );
  }
}
