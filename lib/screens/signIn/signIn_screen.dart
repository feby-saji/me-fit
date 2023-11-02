import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:me_fit/DB/hive_function.dart';
import 'package:me_fit/DB/shared_pref.dart';
import 'package:me_fit/Models/hive_models/user_details.dart';
import 'package:me_fit/main.dart';
import 'package:me_fit/screens/home/home_screen.dart';
import 'package:me_fit/screens/signIn/functions/google_singIN.dart';
import 'package:me_fit/screens/signIn/functions/register_login_btn.dart';
import 'package:me_fit/screens/splash/functions/get_user_img_name.dart';
import 'package:me_fit/styles/size_config.dart';
import 'package:me_fit/styles/styles.dart';
import 'package:me_fit/widgets/g_signIn_btn.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig();
    sizeConfig.initSizeConfig(context);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: sizeConfig.screenWidth,
            height: sizeConfig.screenHeight,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('assets/images/login_scrn_bck.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5),
                  BlendMode.srcOver,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Center(
                      child: Text(
                        'Me FIT',
                        style: kbigText.copyWith(color: kprimaryClr),
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: sizeConfig.blockSizeVertical * 20),
                    Text(
                      'Best Fitness app to make your body fit.',
                      textAlign: TextAlign.center,
                      style: kMedText.copyWith(
                          fontSize: 27, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: sizeConfig.blockSizeVertical * 5),
// G signIn
                    GestureDetector(
                        onTap: () async {
                          HiveDb hiveDb = HiveDb();
                          Box<UserBodyDetails> box =
                              await Hive.openBox<UserBodyDetails>(
                            'userBodyDetailsBox',
                          );
                          UserBodyDetails? user = box.get('userbodydetails');

                          SharedPreferenceDb sharedPreferenceDb =
                              SharedPreferenceDb();
                          await sharedPreferenceDb.initPref();
                          sharedPreferenceDb.setAuthentication(true);

                          await hiveDb.resetDailySteps();
                          stepsGoal.value = user!.dailyStepsGoal;
                          stepsGoal.notifyListeners();

                          await signInWithGoogle(context);
                          await getUserImgAndName();
                          await hiveDb.getCaloriesBurnedToday();
                          await hiveDb.getCaloriesBurnedTotal();
                          hiveDb.getLastWorkout();
                          googleUser = true;
                          Get.offAll(() => HomeScreen(
                                stepsToday: user.dailySteps,
                                distanceToday: user.distanceToday,
                                totalSteps: user.totalSteps,
                              ));
                        },
                        child: GoogleSignInBtn(sizeConfig: sizeConfig)),

                    SizedBox(height: sizeConfig.blockSizeVertical * 2),
                    Text(
                      'OR',
                      style: kMedText.copyWith(fontSize: 20),
                    ),
                    SizedBox(height: sizeConfig.blockSizeVertical * 2),
// register  &  login
                    RegisterLoginBtnWidget(sizeConfig: sizeConfig),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
