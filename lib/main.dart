import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:me_fit/DB/shared_pref.dart';
import 'package:me_fit/Models/hive_models/user_details.dart';
import 'package:me_fit/Models/hive_models/workout_record.dart';
import 'package:me_fit/Models/hive_models/user_profile_details.dart';
import 'package:me_fit/Models/workout_model.dart';
import 'package:me_fit/screens/splash/splash_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

List<WorkoutModel> allBodyPartWorkouts = [];
ValueNotifier<String> userName = ValueNotifier('');
ValueNotifier<String> userImgPathGoogle = ValueNotifier('');
ValueNotifier<File?> userImgPathFile = ValueNotifier(null);
bool googleUser = false;
void main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SharedPreferenceDb sharedPreferenceDb = SharedPreferenceDb();
  await sharedPreferenceDb.initPref();

// registering userBodyDetails box
  if (!Hive.isAdapterRegistered(UserBodyDetailsAdapter().typeId)) {
    Hive.registerAdapter(UserBodyDetailsAdapter());
  }
  if (!Hive.isAdapterRegistered(WorkOutRecordModelAdapter().typeId)) {
    Hive.registerAdapter(WorkOutRecordModelAdapter());
  }
  if (!Hive.isAdapterRegistered(ModelOfUserProfileDetailsAdapter().typeId)) {
    Hive.registerAdapter(ModelOfUserProfileDetailsAdapter());
  }

// setting initial user data values
  if (await sharedPreferenceDb.getInitUserBodyDataValues() == false) {
    Box<UserBodyDetails> box =
        await Hive.openBox<UserBodyDetails>('userBodyDetailsBox');
    UserBodyDetails? user = box.get('userbodydetails');
    if (user == null) {
      UserBodyDetails userBodyDetails = UserBodyDetails(
        height: 0,
        weight: 0,
        caloriesBurnedToday: 0,
        totalCaloriesBurned: 0,
        dailySteps: 0,
        totalSteps: 0,
        dailyStepsGoal: 0,
        distanceToday: 0,
        distanceTotal: 0,
        userBmi: 0,
        lastSteps: 1,
        lastStepTakenDate: DateTime.now().subtract(const Duration(days: 1)),
        dateIsToday: DateTime.now().subtract(const Duration(days: 1)),
      );
      await box.put('userbodydetails', userBodyDetails);
    }
  } 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Thiswidget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xffFF758B)),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
