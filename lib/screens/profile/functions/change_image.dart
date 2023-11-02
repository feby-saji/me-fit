 import 'dart:io';

import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:me_fit/DB/hive_function.dart';
import 'package:me_fit/DB/shared_pref.dart';
import 'package:me_fit/Models/hive_models/user_profile_details.dart';
import 'package:me_fit/main.dart';

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

      model!.imagePath = image.path;
      await userProfileDetails.put(model.email, model);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }