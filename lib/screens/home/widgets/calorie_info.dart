import 'package:flutter/material.dart';
import 'package:me_fit/screens/home/home_screen.dart';
import 'package:me_fit/screens/steps/functions/calculate_calorie_burned.dart';
import 'package:me_fit/styles/styles.dart';

class CaloriesinfoWidget extends StatelessWidget {
  const CaloriesinfoWidget({
    super.key,
  });

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
                    const Text('Calories'),
                    const Spacer(),
                    Image.asset(
                      'assets/images/local_fire_department_FILL0_wght400_GRAD0_opsz24.png',
                      color: Colors.pink,
                      width: 30,
                      height: 30,
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
                const SizedBox(height: 15),
                ValueListenableBuilder(
                  valueListenable: caloriesBurnedTotal,
                  builder: (context, value, child) {
                    calculateCalorieBuned();
                    return Text(
                      value.toString(),
                      style:
                          kMedText.copyWith(color: Colors.black, fontSize: 20),
                    );
                  },
                ),
                const SizedBox(height: 1),
                const Text('Kcal'),
              ],
            ),
          )),
    );
  }
}
