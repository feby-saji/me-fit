import 'package:flutter/material.dart';

class InstructionsContainer extends StatelessWidget {
  const InstructionsContainer({
    super.key,
    required this.instructions,
  });

  final String instructions;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black45,
      ),
      height: 180,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
            child: Text(
          instructions,
          style: const TextStyle(color: Colors.white),
        )),
      ),
    );
  }
}
