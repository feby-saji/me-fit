import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:me_fit/DB/hive_function.dart';
import 'package:me_fit/DB/shared_pref.dart';
import 'package:me_fit/Models/hive_models/user_details.dart';
import 'package:me_fit/screens/home/home_screen.dart';
import 'package:me_fit/screens/signIn/signIn_screen.dart';
import 'package:me_fit/screens/splash/functions/get_user_img_name.dart';
import 'package:me_fit/screens/splash/functions/startlistener.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../weight_height/set_weight_height_screen.dart';

/// Determines whether the user is logged in or not, and navigates to either
/// the home screen or the sign in screen accordingly. If the user is logged in,
/// it also resets the daily steps goal and starts the step listener.
goToScreen(BuildContext context) async {
  SharedPreferenceDb sharedPref = SharedPreferenceDb();
  await sharedPref.initPref();
  bool isAuthenticated = sharedPref.getAuthentication();
  HiveDb hiveDb = HiveDb();

  if (isAuthenticated) {
    Box<UserBodyDetails> box =
        await Hive.openBox<UserBodyDetails>('userBodyDetailsBox');
    UserBodyDetails? user = box.get('userbodydetails');

// reset values
    await hiveDb.resetDailySteps();
    stepsGoal.value = user!.dailyStepsGoal;
    stepsGoal.notifyListeners();

    await hiveDb.getCaloriesBurnedToday();
    await hiveDb.getCaloriesBurnedTotal();
    hiveDb.getLastWorkout();

    await getUserImgAndName().then((_) {
      Get.offAll(() => HomeScreen(
            stepsToday: user.dailySteps,
            distanceToday: user.distanceToday,
            totalSteps: user.totalSteps,
          ));
    });
  } else {
    Get.offAll(() => const SignInScreen());
  }
}

getPermissionActivityRecognition(BuildContext context) async {
  print('checking for activityRecognitionGranded');
  bool activityRecognitionGranded =
      await Permission.activityRecognition.request().isGranted;
  Box<UserBodyDetails> box =
      await Hive.openBox<UserBodyDetails>('userBodyDetailsBox');
  UserBodyDetails? user = box.get('userbodydetails');

  bool hasWeightandHeight = user!.height != 0 && user.weight != 0;
  if (activityRecognitionGranded) {
    print('activityRecognitionGranded : $activityRecognitionGranded');

    if (hasWeightandHeight) {
      await startListener();
    } else {
      _buildShowDialog(context);
    }
  } else {
    //   ask permission
    final status = await Permission.activityRecognition.request();
    if (status.isGranted) {
      // print('permission granted check user weight and height : ');
      await startListener();
    } else {
      Get.snackbar('permission needed',
          'allow activity recognition permission in app settings');
    }
  }
}

_buildShowDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('add weight and height to continue'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Get.to(() => const HeightAndWeightInput());
              },
              child: const Text('add'),
            ),
          ],
        );
      });
}
