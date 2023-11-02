import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:me_fit/main.dart';
import 'package:me_fit/screens/bmi/bmi_screen.dart';
import 'package:me_fit/screens/goals/goals_page.dart';
import 'package:me_fit/screens/privacy_policy/privacy_policy.dart';
import 'package:me_fit/screens/profile/functions/change_image.dart';
import 'package:me_fit/screens/profile/functions/show_log_out.dart';
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
        body: Stack(
          children: [
            Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.chevron_left,
                      size: 35,
                      color: Colors.black,
                    ),
                  ),
                  const Text(
                    'Account',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(width: 50),
                ],
              ),
//

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
                icon: FluentIcons.form_20_filled,
                title: 'privacy policy',
                onTap: () => Get.to(() => const PrivacyPolicyPage()),
              ),
              OptionsWidget(
                icon: Icons.logout,
                title: 'log out',
                onTap: () async {
                  showLogOut(context);
                },
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
