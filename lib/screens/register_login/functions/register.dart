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

registerUser(ModelOfUserProfileDetails userModel, BuildContext context) async {
  HiveDb hiveDb = HiveDb();

  Box<UserBodyDetails> userBodyDetBox =
      await Hive.openBox<UserBodyDetails>('userBodyDetailsBox');

  Box<ModelOfUserProfileDetails> userProfileDetails =
      await Hive.openBox<ModelOfUserProfileDetails>(
    hiveDb.userProfileDetailsKey,
  );
  UserBodyDetails? user = userBodyDetBox.get('userbodydetails');
  SharedPreferenceDb sharedPref = SharedPreferenceDb();
  await sharedPref.initPref();

  var isUserOld = userProfileDetails.get(userModel.email);

  if (isUserOld == null) {
    print('registering user');
    await userProfileDetails.put(userModel.email, userModel);
    // userProfileDetails.put('userProfileDetails', userModel);
    sharedPref.setAuthentication(true);
    sharedPref.setUserEmail(userModel.email);

    await hiveDb.resetDailySteps();
    stepsGoal.value = user!.dailyStepsGoal;
    stepsGoal.notifyListeners();

    await getUserImgAndName();
    googleUser = false;

    Get.offAll(() => HomeScreen(
          stepsToday: user.dailySteps,
          distanceToday: user.distanceToday,
          totalSteps: user.totalSteps,
        ));
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('user exists'),
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
