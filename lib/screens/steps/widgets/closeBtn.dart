import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:me_fit/DB/hive_function.dart';
import 'package:me_fit/Models/hive_models/user_details.dart';
import 'package:me_fit/screens/home/home_screen.dart';

class CloseBtnWidget extends StatelessWidget {
  const CloseBtnWidget({
    super.key,
    required this.db,
    required int totalSteps,
    required int stepCurrent,
    required int caloriesBurnedToday,
  })  : _totalSteps = totalSteps,
        _stepCurrent = stepCurrent,
        _caloriesBurnedToday = caloriesBurnedToday;

  final HiveDb db;
  final int _totalSteps;
  final int _stepCurrent;
  final int _caloriesBurnedToday;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {
          Box<UserBodyDetails> box =
              await Hive.openBox<UserBodyDetails>('userBodyDetailsBox');
          UserBodyDetails? user = box.get('userbodydetails');
          await db.setLastStep(_totalSteps);
          print('_totalsteps $_totalSteps');
          await db.setTodaySteps(_stepCurrent.abs());
          await db.setCaloriesBurnedTotal(_caloriesBurnedToday);
          await db.setCaloriesBurnedToday(_caloriesBurnedToday);

          print(' today _caloriesBurnedToday$_caloriesBurnedToday');

          // print(' printng steps saving to db ${_stepCurrent.abs()}');
          Get.offAll(HomeScreen(
            stepsToday: user!.dailySteps,
            totalSteps: user.totalSteps,
            distanceToday: user.distanceToday,
          ));

          // Get.back();
        },
        icon: const Icon(
          Icons.close,
          size: 50,
        ));
  }
}
