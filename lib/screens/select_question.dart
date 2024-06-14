import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:guess_the_profession/models/question.dart';
import 'package:guess_the_profession/screens/difficulty_levels.dart';
import 'package:guess_the_profession/widgets/background.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:guess_the_profession/screens/gameplay.dart';

class SelectQuestion extends ConsumerWidget {
  const SelectQuestion({super.key, required this.difficulty});

  final Difficulty difficulty;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ChangeNotifierProvider<QuestionsNotifier> questionsProvider;

    if (difficulty == Difficulty.easy) {
      questionsProvider = easyQuestionsProvider;
    } else if (difficulty == Difficulty.medium) {
      questionsProvider = mediumQuestionsProvider;
    } else {
      questionsProvider = hardQuestionsProvider;
    }

    List<Question> questions = ref.watch(questionsProvider).questions;
    ref.read(questionsProvider.notifier).unlockItem(0);

    return Background(
      title: "Select Level",
      body: GridView.builder(
        shrinkWrap: true,
        itemCount: questions.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
        ),
        itemBuilder: (context, index) {
          return FutureBuilder<bool>(
              future: questions[index].getFromMemory(questions[index].answer),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return questionButton(context,
                      index: index, questionsProvider: questionsProvider, questions: questions);
                } else {
                  return const SizedBox();
                }
              });
        },
      ),
    );
  }

  Widget questionButton(BuildContext context,
      {required int index,
      required ChangeNotifierProvider<QuestionsNotifier> questionsProvider,
      required List<Question> questions,
      double size = 30}) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: questions[index].unlocked
            ? WidgetStateProperty.all(const Color(0xFF001C30))
            : WidgetStateProperty.all(Colors.grey[700]),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            side: const BorderSide(
              color: Colors.white,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        fixedSize: WidgetStateProperty.all(Size(size, size)),
        padding: WidgetStateProperty.all(EdgeInsets.zero),
      ),
      onPressed: () {
        //questions[index].clearMemory();
        if (questions[index].unlocked) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Gameplay(
                      question: questions[index],
                      nextQuestionIndex: index == questions.length - 1 ? index : index + 1,
                      questionProvider: questionsProvider,
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
}
