import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:me_fit/DB/hive_function.dart';
import 'package:me_fit/DB/shared_pref.dart';
import 'package:me_fit/Models/hive_models/user_details.dart';
import 'package:me_fit/Models/hive_models/user_profile_details.dart';
import 'package:me_fit/main.dart';
import 'package:me_fit/screens/home_screen.dart';
import 'package:me_fit/screens/signIn_screen.dart';
import 'package:me_fit/styles/size_config.dart';
import 'package:me_fit/styles/styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig();
    sizeConfig.initSizeConfig(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 1), () {
        goToScreen();
      });
    });

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: sizeConfig.screenHeight,
            width: sizeConfig.screenWidth,
            child: Image.asset(
              'assets/images/splash_screen_bck.jpg',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: sizeConfig.screenHeight,
            child: Column(
              children: [
                SizedBox(height: sizeConfig.blockSizeVertical * 15),
                Text(
                  'Me FIT',
                  style: kbigText,
                ),
                SizedBox(height: sizeConfig.blockSizeVertical * 8),

                Text(
                  'FIND OUT EXACTLY WHAT DIET & TRAINING WILL WORK SPECIFICALLY FOR YOU',
                  style: kDmSansFont.copyWith(
                      fontWeight: FontWeight.w400, fontSize: 15),
                  textAlign: TextAlign.center,
                ),
                // SizedBox(height: sizeConfig.blockSizeVertical * 30),
                const Spacer(),
                SizedBox(
                  height: 400,
                  child: Image.asset(
                    'assets/images/athletic_girl_png.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> getUserImgAndName() async {
    if (FirebaseAuth.instance.currentUser != null) {
      print('user from Google signIn');
      googleUser = true;
      userName.value = FirebaseAuth.instance.currentUser!.displayName!;
      userImgPathGoogle.value = FirebaseAuth.instance.currentUser!.photoURL!;
      return true;
    } else {
      print('user is from sharedPref');
       HiveDb hiveDb = HiveDb();
      Box<ModelOfUserProfileDetails> userProfileDetails =
          await Hive.openBox<ModelOfUserProfileDetails>(
        hiveDb.userProfileDetailsKey,
      );
      SharedPreferenceDb sharedPref = SharedPreferenceDb();
      await sharedPref.initPref();
      String email = await sharedPref.getUserEmail();
      print('email $email');
      ModelOfUserProfileDetails? model = userProfileDetails.get(email);

      if (model != null) {
        userName.value = model.userName;
        userName.notifyListeners();
        print('the image is it null ?? ${model.imagePath}');
        userImgPathFile.value = model.imagePath != null
            ? File(model.imagePath!)
            : null;
        userImgPathFile.notifyListeners();
      }
      return true;
    }
  }

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
    } else {
      Get.offAll(() => const SignInScreen());
    }
  }
}
