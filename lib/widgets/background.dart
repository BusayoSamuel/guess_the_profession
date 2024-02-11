import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({
    super.key,
    required this.body,
    required this.title,
  });

  final Widget body;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDAFFFB),
      appBar: AppBar(
        backgroundColor: const Color(0xFF001C30),
        centerTitle: true,
        title: Text(
          title,
          style: const TextStyle(
            color: Color(0xFFDAFFFB),
          ),
        ),
      ),
      body: body,
    );
  }
}
