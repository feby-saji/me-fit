import 'package:flutter/material.dart';

class ChoiceChipWidget extends StatelessWidget{
  ChoiceChipWidget({
    super.key,
    required this.function,
    required this.value,
  });

  Function() function;
  String value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.black12,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text('+ $value'),
        ),
      ),
    );
  }
}
