// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:me_fit/styles/styles.dart';

class StepsInfoWidget extends StatelessWidget {
  StepsInfoWidget({
    super.key,
    required this.value,
  });

  String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 130, left: 30),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              border: Border.all(width: 1, color: Colors.grey)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 7),
                Row(
                  children: [
                    const Text('steps'),
                    const Spacer(),
                    Image.asset(
                      'assets/images/steps.png',
                      color: Colors.pink,
                      width: 30,
                      height: 30,
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
                const SizedBox(height: 15),
                Text(
                  value,
                  style: kMedText.copyWith(color: Colors.black, fontSize: 20),
                ),
                const SizedBox(height: 1),
                const Text('steps'),
              ],
            ),
          )),
    );
  }
}
