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
  });

  final HiveDb db;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {
          Box<UserBodyDetails> box =
              await Hive.openBox<UserBodyDetails>('userBodyDetailsBox');
          UserBodyDetails? user = box.get('userbodydetails');

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
