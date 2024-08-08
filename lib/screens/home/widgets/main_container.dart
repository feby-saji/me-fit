import 'package:flutter/material.dart';
import 'package:me_fit/DB/hive_function.dart';
import 'package:me_fit/screens/home/functions/date_parse.dart';
import 'package:me_fit/screens/home/home_screen.dart';
import 'package:me_fit/styles/styles.dart';

class MainContainerWidget extends StatelessWidget {
  const MainContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Stack(
        children: [
          Image.asset(
            'assets/images/rectangle.png',
            height: 350,
            fit: BoxFit.contain,
          ),
          Align(
            alignment: Alignment.topRight,
            child: Image.asset(
              'assets/images/mask_grp.png',
              height: 300,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
              top: 100,
              left: 10,
              child: ValueListenableBuilder(
                valueListenable: caloriesBurnedToday,
                builder: (context, value, child) {
                  HiveDb().getCaloriesBurnedToday();

                  return Text(
                    '${value.toString()} Kcal',
                    style: kbigText.copyWith(fontWeight: FontWeight.w400),
                  );
                },
              )),
          Positioned(
              top: 160,
              left: 15,
              child: Text(
                dateParse(DateTime.now()),
                style: kDmSansFont.copyWith(fontSize: 18),
              )),
        ],
      ),
    );
  }
}
