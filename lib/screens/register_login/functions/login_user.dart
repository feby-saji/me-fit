import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:me_fit/DB/hive_function.dart';
import 'package:me_fit/DB/shared_pref.dart';
import 'package:me_fit/Models/hive_models/user_details.dart';
import 'package:me_fit/Models/hive_models/user_profile_details.dart';
import 'package:me_fit/main.dart';
import 'package:me_fit/screens/home/home_screen.dart';
import 'package:me_fit/screens/splash/functions/get_user_img_name.dart';

loginUser(email, password, BuildContext context) async {
  HiveDb hiveDb = HiveDb();
  Box<ModelOfUserProfileDetails> userProfileDetails =
      await Hive.openBox<ModelOfUserProfileDetails>(
    hiveDb.userProfileDetailsKey,
  );
  ModelOfUserProfileDetails? user = userProfileDetails.get(email);

  if (user != null) {
    if (password == user.password) {
      SharedPreferenceDb sharedPreferenceDb = SharedPreferenceDb();
      await sharedPreferenceDb.initPref();
      sharedPreferenceDb.setAuthentication(true);
      sharedPreferenceDb.setUserEmail(email);

      Box<UserBodyDetails> box1 =
          await Hive.openBox<UserBodyDetails>('userBodyDetailsBox');
      UserBodyDetails? user = box1.get('userbodydetails');
      googleUser = false;

      await getUserImgAndName().then((_) {
        Get.offAll(() => HomeScreen(
              stepsToday: user?.dailySteps ?? 0,
              distanceToday: user?.distanceToday ?? 0,
              totalSteps: user?.totalSteps ?? 0,
            ));
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('credentials incorect'),
          action: SnackBarAction(
            label: 'okay',
            onPressed: () {
              // Undo the action that caused the snackbar to be displayed.
            },
          ),
        ),
      );
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('no user found'),
        action: SnackBarAction(
          label: 'okay',
          onPressed: () {
            // Undo the action that caused the snackbar to be displayed.
          },
        ),
      ),
    );
  }
}
