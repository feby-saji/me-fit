import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:me_fit/DB/hive_function.dart';
import 'package:me_fit/DB/shared_pref.dart';
import 'package:me_fit/Models/channel_manager.dart';
import 'package:me_fit/Models/hive_models/user_details.dart';
import 'package:me_fit/screens/home/home_screen.dart';
import 'package:me_fit/screens/signIn/signIn_screen.dart';
import 'package:me_fit/screens/splash/functions/get_user_img_name.dart';
import 'package:me_fit/screens/splash/functions/startlistener.dart';
import 'package:me_fit/screens/steps/steps_page.dart';

goToScreen() async {
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

// start step count listener
    await startListener();
  } else {
    Get.offAll(() => const SignInScreen());
  }
}
