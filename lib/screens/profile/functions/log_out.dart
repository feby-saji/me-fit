import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:me_fit/DB/shared_pref.dart';
import 'package:me_fit/main.dart';
import 'package:me_fit/screens/signIn/signIn_screen.dart';

logOutFunc(BuildContext context) async {
  showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      });
// TODO must complete this
  // googleUser ? userImgPathGoogle.value = '' : userImgPathFile.value = null;

  if (FirebaseAuth.instance.currentUser != null) {
    userImgPathGoogle.value = '';
    await FirebaseAuth.instance.signOut();
    userImgPathGoogle.notifyListeners();
  }
  userImgPathFile.value = null;
  userImgPathFile.notifyListeners();
  SharedPreferenceDb sharedPreferenceDb = SharedPreferenceDb();
  await sharedPreferenceDb.initPref();
  sharedPreferenceDb.setAuthentication(false);
  // Navigator.pop(context);
  Get.offAll(() => const SignInScreen());
}
