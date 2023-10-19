import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:me_fit/DB/hive_function.dart';
import 'package:me_fit/DB/shared_pref.dart';
import 'package:me_fit/Models/hive_models/user_profile_details.dart';
import 'package:me_fit/main.dart';
import 'package:me_fit/screens/bmi_screen.dart';
import 'package:me_fit/screens/goals_page.dart';
import 'package:me_fit/screens/privacy_policy.dart';
import 'package:me_fit/screens/signIn_screen.dart';
import 'package:me_fit/styles/size_config.dart';
import 'package:me_fit/styles/styles.dart';
import 'package:me_fit/widgets/profile_page.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig();
    sizeConfig.initSizeConfig(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Account')),
        ),
        body: Stack(
          children: [
            Column(children: [
              const SizedBox(height: 40),
              Center(
                child: GestureDetector(
                  onTap: () => changeImage(),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: googleUser
                          ? Image.network(
                              userImgPathGoogle.value,
                              width: sizeConfig.blockSizeHorizontal * 38,
                              height: sizeConfig.blockSizeVertical * 18,
                              fit: BoxFit.cover,
                            )
                          : ValueListenableBuilder(
                              valueListenable: userImgPathFile,
                              builder: (BuildContext context, File? file, _) {
                                return file == null
                                    ? Image.asset(
                                        'assets/images/default_profile.png',
                                        width:
                                            sizeConfig.blockSizeHorizontal * 38,
                                        height:
                                            sizeConfig.blockSizeVertical * 18,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.file(
                                        file,
                                        width:
                                            sizeConfig.blockSizeHorizontal * 38,
                                        height:
                                            sizeConfig.blockSizeVertical * 18,
                                        fit: BoxFit.cover,
                                      );
                              },
                            )),
                ),
              ),
              const SizedBox(height: 40),
              Text(
                userName.value,
                style: kMedText.copyWith(color: Colors.black),
              ),
              const SizedBox(height: 40),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(),
              ),
              const SizedBox(height: 20),
              OptionsWidget(
                icon: FluentIcons.target_16_filled,
                title: 'Goals',
                onTap: () => Get.to(() => DailyStepsInputPage(
                      goToHome: false,
                    )),
              ),
              OptionsWidget(
                icon: FluentIcons.calculator_arrow_clockwise_20_filled,
                title: 'BMI',
                onTap: () => Get.to(() => const BMICalculationScreen()),
              ),
              OptionsWidget(
                icon: FluentIcons.calculator_arrow_clockwise_20_filled,
                title: 'privacy policy',
                onTap: () => Get.to(() => const PrivacyPolicyPage()),
              ),
              OptionsWidget(
                icon: FluentIcons.calculator_arrow_clockwise_20_filled,
                title: 'log out',
                onTap: () async {
                  showLogOut();
                },
              ),
            ]),
          ],
        ),
      ),
    );
  }

  changeImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      userImgPathFile.value = imageTemp;
      userImgPathFile.notifyListeners();

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

      // if (model != null) {
      //   print('updating umage now ');
      model!.imagePath = image.path;
      await userProfileDetails.put(model.email, model);
      //   print('the imgae ${model.imagePath}');
      // }
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  showLogOut() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('log out ?'),
            actions: [
              IconButton(
                  onPressed: () async => await logOutFunc(),
                  icon: const Icon(FluentIcons.sign_out_20_regular)),
              IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close))
            ],
          );
        });
  }

  logOutFunc() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    if (FirebaseAuth.instance.currentUser != null) {
      await FirebaseAuth.instance.signOut();
    }

    SharedPreferenceDb sharedPreferenceDb = SharedPreferenceDb();
    await sharedPreferenceDb.initPref();
    sharedPreferenceDb.setAuthentication(false);
    // Navigator.pop(context);
    Get.offAll(() => const SignInScreen());
  }
}
