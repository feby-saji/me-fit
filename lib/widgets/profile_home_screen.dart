import 'dart:io';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:me_fit/DB/shared_pref.dart';
import 'package:me_fit/main.dart';
import 'package:me_fit/screens/calendar/calendar_screen.dart';
import 'package:me_fit/screens/home/home_screen.dart';
import 'package:me_fit/screens/profile/profile_screen.dart';
import 'package:me_fit/screens/signIn/signIn_screen.dart';
import 'package:me_fit/styles/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile1Widget extends StatefulWidget {
  const Profile1Widget({super.key});

  @override
  State<Profile1Widget> createState() => _Profile1WidgetState();
}

class _Profile1WidgetState extends State<Profile1Widget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: sizeConfig.blockSizeHorizontal * 5,
        right: sizeConfig.blockSizeHorizontal * 5,
        top: sizeConfig.blockSizeVertical * 2,
      ),
      child: GestureDetector(
        onTap: () => Get.to(() => const ProfileScreen()),
        child: Row(
          children: [
            ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                child: googleUser
                    ? Image.network(
                        userImgPathGoogle.value,
                        width: sizeConfig.blockSizeHorizontal * 20,
                        height: sizeConfig.blockSizeVertical * 9,
                        fit: BoxFit.cover,
                      )
                    : ValueListenableBuilder(
                        valueListenable: userImgPathFile,
                        builder: (BuildContext context, File? file, _) {
                          return file == null
                              ? Image.asset(
                                  'assets/images/default_profile.png',
                                  width: sizeConfig.blockSizeHorizontal * 20,
                                  height: sizeConfig.blockSizeVertical * 9,
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  file,
                                  width: sizeConfig.blockSizeHorizontal * 20,
                                  height: sizeConfig.blockSizeVertical * 9,
                                  fit: BoxFit.cover,
                                );
                        },
                      )),
            SizedBox(width: sizeConfig.blockSizeHorizontal * 2),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName.value,
                  style: kDmSansFont.copyWith(
                    color: Colors.grey,
                    fontSize: sizeConfig.blockSizeHorizontal * 4.5,
                  ),
                ),
                Text(dateParse(DateTime.now())),
              ],
            ),
            const Spacer(),
            IconButton(
                onPressed: () => Get.to(() => const CalendarScreen()),
                icon: const Icon(FluentIcons.calendar_16_regular))
          ],
        ),
      ),
    );
  }

  signOut() async {
    SharedPreferenceDb sharedPreferenceDb = SharedPreferenceDb();
    await sharedPreferenceDb.initPref();
    sharedPreferenceDb.setAuthentication(false);
    await FirebaseAuth.instance.signOut();
    Get.offAll(() => const SignInScreen());
  }

  String dateParse(date) {
    return DateFormat.MMMMEEEEd().format(date);
  }
}

class Widget2 extends StatelessWidget {
  const Widget2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
