import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:me_fit/screens/goals/goals_page.dart';
import 'package:me_fit/screens/home/home_screen.dart';
import 'package:me_fit/styles/styles.dart';

class StepsGoalWidget extends StatefulWidget {
  const StepsGoalWidget({super.key});

  @override
  State<StepsGoalWidget> createState() => _StepsGoalWidgetState();
}

class _StepsGoalWidgetState extends State<StepsGoalWidget> {
  @override
  Widget build(BuildContext context) {
    return stepsGoal.value == 0
        ? ElevatedButton(
            onPressed: () => Get.to(() => DailyStepsInputPage(
                  goToHome: true,
                )),
            child: const Text('set daily goal'))
        : stepsGoal.value != 0
            ? ValueListenableBuilder(
                valueListenable: stepsGoal,
                builder: (context, value, child) {
                  return Text(
                    value.toString(),
                    style: kMedText.copyWith(color: Colors.black),
                  );
                },
              )
            : Text(
                '0',
                style: kMedText.copyWith(color: Colors.black),
              );
  }
}
