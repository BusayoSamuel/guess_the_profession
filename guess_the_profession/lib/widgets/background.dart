import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({super.key, required this.body});

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDAFFFB),
      appBar: AppBar(
        backgroundColor: const Color(0xFF001C30),
        title: const Text(
          "GuessTheProfession",
          style: TextStyle(color: Color(0xFFDAFFFB)),
        ),
      ),
      body: body,
    );
  }
}
