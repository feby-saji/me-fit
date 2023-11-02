  import 'package:hive_flutter/hive_flutter.dart';
import 'package:me_fit/Models/hive_models/user_details.dart';
import 'package:me_fit/screens/home/home_screen.dart';

updateGoalCompletePercentage() async {
    Box<UserBodyDetails> box =
        await Hive.openBox<UserBodyDetails>('userBodyDetailsBox');
    UserBodyDetails? user = box.get('userbodydetails');
    if (user?.dailySteps != null && stepsGoal.value != 0) {
      double? normalizedValue = ((user!.dailySteps / stepsGoal.value) * 100);

      stepsGoalCompletePer.value = normalizedValue;
      stepsGoalCompletePer.notifyListeners();
    }
  }