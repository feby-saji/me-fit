import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:me_fit/DB/hive_function.dart';
import 'package:me_fit/DB/shared_pref.dart';
import 'package:me_fit/Models/hive_models/user_profile_details.dart';
import 'package:me_fit/screens/home_screen.dart';
import 'package:me_fit/screens/splash_screen.dart';
import 'package:me_fit/styles/size_config.dart';
import 'package:me_fit/styles/styles.dart';
import 'package:me_fit/Models/hive_models/user_details.dart';

class RegisterOrLoginScreen extends StatefulWidget {
  final bool isRegister;
  const RegisterOrLoginScreen({super.key, required this.isRegister});

  @override
  State<RegisterOrLoginScreen> createState() => _RegisterOrLoginScreenState();
}

class _RegisterOrLoginScreenState extends State<RegisterOrLoginScreen> {
  TextEditingController ctrlUserName = TextEditingController();
  TextEditingController ctrlEmail = TextEditingController();
  TextEditingController ctrlPassword = TextEditingController();
  SizeConfig sizeConfig = SizeConfig();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    ctrlEmail.clear();
    ctrlPassword.clear();
    ctrlUserName.clear();
  }

  @override
  Widget build(BuildContext context) {
    sizeConfig.initSizeConfig(context);

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.pinkAccent,
      body: SingleChildScrollView(
        child: Stack(children: [
          SizedBox(
            height: sizeConfig.screenHeight,
            width: sizeConfig.screenWidth,
            child: Image.asset(
              'assets/images/splash_screen_bck.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: sizeConfig.blockSizeHorizontal * 20,
              right: sizeConfig.blockSizeHorizontal * 9,
              top: sizeConfig.blockSizeVertical * 5,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Me FIT',
                  style: kbigText,
                ),
                SizedBox(
                    height: widget.isRegister
                        ? sizeConfig.blockSizeVertical * 8
                        : sizeConfig.blockSizeVertical * 22),
                Visibility(
                  visible: widget.isRegister,
                  child: Text(
                    'user name',
                    style: kDmSansFont,
                  ),
                ),
                Visibility(
                  visible: widget.isRegister,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 3, vertical: 2),
                      child: TextField(
                        maxLength: 10,
                        controller: ctrlUserName,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp("[a-zA-Z_]")),
                        ],
                        decoration: const InputDecoration(
                            border: InputBorder.none, counterText: ''),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: sizeConfig.blockSizeVertical * 5),
                Text(
                  'email',
                  style: kDmSansFont,
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                    child: TextField(
                      controller: ctrlEmail,
                      maxLength: 40,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp("[0-9a-zA-Z@_.]")),
                      ],
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        counterText: '',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: sizeConfig.blockSizeVertical * 5),
                Text(
                  'password',
                  style: kDmSansFont,
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                    child: TextField(
                      maxLength: 12,
                      controller: ctrlPassword,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        counterText: '',
                      ),
                    ),
                  ),
                ),

                // btn
                SizedBox(height: sizeConfig.blockSizeVertical * 20),
                ElevatedButton(
                    onPressed: () {
                      if (widget.isRegister) {
                        if (ctrlUserName.text.isNotEmpty &&
                            ctrlEmail.text.isNotEmpty &&
                            ctrlPassword.text.isNotEmpty) {
                          if (RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(ctrlEmail.text)) {
                            ModelOfUserProfileDetails user =
                                ModelOfUserProfileDetails(
                              userName: ctrlUserName.text,
                              email: ctrlEmail.text,
                              password: ctrlPassword.text,
                            );
                            registerUser(user);
                          } else {
                            Get.snackbar('', 'email incorrect');
                          }
                        } else {
                          Get.snackbar('make sure all fields are filled', '',
                              icon: const Icon(Icons.warning));
                        }
                      } else {
                        if (ctrlEmail.text.isNotEmpty &&
                            ctrlPassword.text.isNotEmpty) {
                          loginUser(ctrlEmail.text, ctrlPassword.text);
                        } else {
                          Get.snackbar('make sure all fields are filled', '',
                              icon: const Icon(Icons.warning));
                        }
                      }
                    },
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Text(widget.isRegister ? 'Register' : 'Login'))),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  registerUser(ModelOfUserProfileDetails userModel) async {
    HiveDb hiveDb = HiveDb();
    Box<UserBodyDetails> box1 =
        await Hive.openBox<UserBodyDetails>('userBodyDetailsBox');
    Box<ModelOfUserProfileDetails> userProfileDetails =
        await Hive.openBox<ModelOfUserProfileDetails>(
      hiveDb.userProfileDetailsKey,
    );
    UserBodyDetails? user = box1.get('userbodydetails');
    SharedPreferenceDb sharedPref = SharedPreferenceDb();
    await sharedPref.initPref();

    var isUserOld = userProfileDetails.get(userModel.email);

    if (isUserOld == null) {
      print('registering user');
      await userProfileDetails.put(userModel.email, userModel);

      userProfileDetails.put('userProfileDetails', userModel);
      sharedPref.setAuthentication(true);
      sharedPref.setUserEmail(userModel.email);

      await hiveDb.resetDailySteps();
      stepsGoal.value = user!.dailyStepsGoal;
      stepsGoal.notifyListeners();

      await SplashScreenState().getUserImgAndName();

      Get.offAll(() => HomeScreen(
            stepsToday: user.dailySteps,
            distanceToday: user.distanceToday,
            totalSteps: user.totalSteps,
          ));
    } else {
      Get.snackbar('user existes', '');
    }
  }

  loginUser(email, password) async {
    Box<ModelOfUserProfileDetails> box =
        await Hive.openBox<ModelOfUserProfileDetails>('userBox');

    ModelOfUserProfileDetails? user = box.get(email);

    if (user != null) {
      if (password == user.password) {
        SharedPreferenceDb sharedPreferenceDb = SharedPreferenceDb();
        await sharedPreferenceDb.initPref();
        sharedPreferenceDb.setAuthentication(true);
        sharedPreferenceDb.setUserEmail(email);

        Box<UserBodyDetails> box1 =
            await Hive.openBox<UserBodyDetails>('userBodyDetailsBox');
        UserBodyDetails? user = box1.get('userbodydetails');

        await SplashScreenState().getUserImgAndName().then((_) {
          Get.offAll(() => HomeScreen(
                stepsToday: user?.dailySteps ?? 0,
                distanceToday: user?.distanceToday ?? 0,
                totalSteps: user?.totalSteps ?? 0,
              ));
        });
      } else {
        Get.snackbar('', 'password or email incorrect');
      }
    } else {
      Get.snackbar('', 'no user found');
    }
  }
}
