import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:me_fit/DB/hive_function.dart';
import 'package:me_fit/DB/shared_pref.dart';
import 'package:me_fit/Models/hive_models/user_profile_details.dart';
import 'package:me_fit/main.dart';

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