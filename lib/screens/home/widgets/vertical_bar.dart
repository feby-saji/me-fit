import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:me_fit/screens/home/home_screen.dart';

class VerticalProgressbar extends StatelessWidget{
  const VerticalProgressbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: stepsGoalCompletePer,
        builder: (context, value, child) {
          print('printing the goal notifier value $value');
          return SizedBox(
            width: 35,
            height: 150,
            child: FAProgressBar(
              animatedDuration: const Duration(seconds: 1),
              // changeColorValue: value.round(),
              backgroundColor:
                  const Color.fromARGB(255, 224, 220, 220),
              maxValue: 100,
              currentValue: value,
              displayText: '%',
              direction: Axis.vertical,
              verticalDirection: VerticalDirection.up,
            ),
          );
        });
  }
}
