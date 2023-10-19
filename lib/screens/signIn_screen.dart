import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:me_fit/DB/hive_function.dart';
import 'package:me_fit/DB/shared_pref.dart';
import 'package:me_fit/Models/hive_models/user_details.dart';
import 'package:me_fit/screens/home_screen.dart';
import 'package:me_fit/screens/register_or_login_screen.dart';
import 'package:me_fit/screens/splash_screen.dart';
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
                          await SplashScreenState().getUserImgAndName();
                          await hiveDb.getCaloriesBurnedToday();
                          await hiveDb.getCaloriesBurnedTotal();
                          hiveDb.getLastWorkout();

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
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () => Get.to(() =>
                                const RegisterOrLoginScreen(isRegister: true)),
                            child: Container(
                              width: sizeConfig.blockSizeHorizontal * 40,
                              height: sizeConfig.blockSizeHorizontal * 10,
                              decoration: BoxDecoration(
                                color: kprimaryClr,
                                // border: Border.all(width: 1, color: kBorderClr),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text(
                                  'register',
                                  style: kDmSansFont.copyWith(
                                      fontSize:
                                          sizeConfig.blockSizeHorizontal * 4),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Get.to(() =>
                                const RegisterOrLoginScreen(isRegister: false)),
                            child: Container(
                              width: sizeConfig.blockSizeHorizontal * 40,
                              height: sizeConfig.blockSizeHorizontal * 10,
                              decoration: BoxDecoration(
                                color: kprimaryClr,
                                // border: Border.all(width: 1, color: kBorderClr),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text(
                                  'Login',
                                  style: kDmSansFont.copyWith(
                                      fontSize:
                                          sizeConfig.blockSizeHorizontal * 4),
                                ),
                              ),
                            ),
                          ),
                        ]),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<UserCredential> signInWithGoogle(context) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
